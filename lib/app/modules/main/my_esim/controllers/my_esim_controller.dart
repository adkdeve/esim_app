import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pcom_app/app/data/services/auth_service.dart';
import 'package:pcom_app/app/modules/main/controllers/main_controller.dart';

class MyEsimController extends GetxController {

  MainController get mainController => Get.find<MainController>();

  var isLoading = true.obs;

  var planName = "".obs;
  var iccid = "".obs;
  var qrCodeLink = "".obs;

  var currentPlans = <Map<String, dynamic>>[].obs;
  var achievedPlans = <Map<String, dynamic>>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    await fetchUserPlans();
  }

  Future<void> fetchUserPlans() async {
    // Get logged-in email from MainController
    // Ensure MainController has loaded the user profile before this runs
    final email = mainController.user?.userEmail;

    if (email == null) {
      print("⚠️ No email found for logged-in user.");
      isLoading.value = false;
      return;
    }

    try {
      final Uri url = Uri.parse("https://wilixifysoft.com/wp-json/esim/v1/db2/user-plans?email=$email");
      print("🚀 FETCHING PLANS: $url");

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['result'] == 1 && data['plans'] != null) {
          _processPlans(data['plans']);
        } else {
          print("⚠️ API returned no plans or result != 1");
        }
      } else {
        print("❌ API Error: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception fetching plans: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _processPlans(List<dynamic> rawPlans) {
    currentPlans.clear();
    achievedPlans.clear();

    if (rawPlans.isEmpty) {
      isLoading.value = false;
      return;
    }

    // A. Populate Header with the most recent plan details
    var latest = rawPlans.first;
    planName.value = latest['product_title'] ?? 'My eSIM';
    iccid.value = latest['iccid'] ?? 'N/A';
    qrCodeLink.value = latest['qrCodeLink'] ?? '';

    // B. Loop through all plans
    for (var plan in rawPlans) {
      // 1. Convert Bytes to GB
      double totalBytes = double.tryParse(plan['data_quota'].toString()) ?? 0;
      double usedBytes = double.tryParse(plan['used_data'].toString()) ?? 0;

      double totalGb = totalBytes / 1073741824;
      double usedGb = usedBytes / 1073741824;

      // 2. Parse Expiration Date (Kept for UI display in PlanCard)
      DateTime validUntil = DateTime.now();
      try {
        String endStr = plan['end_time'].toString();
        if (endStr.startsWith("0000") || endStr == "null") {
          DateTime start = DateTime.parse(plan['start_time']);
          int days = int.tryParse(plan['perioddays'].toString()) ?? 0;
          validUntil = start.add(Duration(days: days));
        } else {
          validUntil = DateTime.parse(endStr);
        }
      } catch (e) {
        print("Date Parsing Error: $e");
      }

      // --- 3. UPDATED LOGIC: Determine if Active via Network Status ---
      // Get the status and normalize it to uppercase
      String networkStatus = plan['network_status']?.toString().toUpperCase() ?? "";

      // If NOT terminated, it belongs in Current Plans
      bool isActive = networkStatus != "TERMINATED";

      // 4. Create UI Model
      var planMap = {
        'country': plan['planName'] ?? 'eSIM Plan',
        'subtitle': "Order #${plan['order_number']}",
        'validUntil': validUntil,
        'totalGb': totalGb,
        'usedGb': usedGb,
        'flagImage': 'assets/images/ic_sim.png',
        'active': isActive,
        'status': networkStatus // Storing the raw status can be useful for debugging
      };

      // 5. Sort into reactive lists
      if (isActive) {
        currentPlans.add(planMap);
      } else {
        achievedPlans.add(planMap);
      }
    }
  }
}