import 'package:get/get.dart';

import '../../../../data/models/esim_model.dart';

class CardDetailsController extends GetxController {

  // Received Data
  late String countryName;
  late String imageUrl;

  // Observables
  var isLoading = true.obs;

  // All plans for this country
  var allPlans = <EsimProduct>[];

  // Plans currently displayed (filtered by category/validity)
  var displayedPlans = <EsimProduct>[].obs;

  // Categories (Unique Validity Days found in the product list)
  var category = <String>[].obs;
  var selectedCategoryIndex = 0.obs;

  // Checkout Selection
  Rx<int> selectedPlanIndex = Rx<int>(-1); // Index within displayedPlans
  Rx<int> quantity = 1.obs;

  @override
  void onInit() {
    super.onInit();
    // Retrieve arguments passed from Home
    final args = Get.arguments as Map<String, dynamic>;
    countryName = args['countryName'] ?? '';
    imageUrl = args['imageUrl'] ?? '';

    // Retrieve the list of products for this country
    if (args['products'] != null) {
      allPlans = args['products'] as List<EsimProduct>;
      processData();
    }
  }

  void processData() {
    if (allPlans.isEmpty) return;

    // 1. Extract unique validities for the Category Tabs (e.g., "7 Days", "30 Days")
    Set<int> uniqueDays = allPlans.map((e) => e.validityDays).toSet();
    List<int> sortedDays = uniqueDays.toList()..sort();

    category.value = sortedDays.map((d) => "$d Days").toList();

    // Add an "All" option if you prefer, usually sorted by days is better
    // For now, we default to the first available validity
    if (category.isNotEmpty) {
      filterPlansByIndex(0);
    }

    isLoading.value = false;
  }

  // Filter the displayed list when a category chip is clicked
  void filterPlansByIndex(int index) {
    selectedCategoryIndex.value = index;
    selectedPlanIndex.value = -1; // Reset selection
    quantity.value = 1;

    // Parse "7 Days" back to integer 7
    String dayString = category[index].split(' ')[0];
    int days = int.tryParse(dayString) ?? 0;

    displayedPlans.value = allPlans.where((p) => p.validityDays == days).toList();

    // Optional: Sort by Price or Data
    displayedPlans.sort((a, b) => a.retailPrice.compareTo(b.retailPrice));
  }

  void selectPlan(int index) {
    selectedPlanIndex.value = index;
    quantity.value = 1;
  }

  // --- Computed Properties for UI ---

  // Helper to format MB to GB
  String formatData(int mb) {
    if (mb >= 1024) {
      return "${(mb / 1024).toStringAsFixed(0)} GB";
    }
    return "$mb MB";
  }

  double get totalPrice {
    if (selectedPlanIndex.value != -1 && quantity.value > 0) {
      return displayedPlans[selectedPlanIndex.value].retailPrice * quantity.value;
    }
    return 0.0;
  }

  String get selectedPlanDescription {
    if (selectedPlanIndex.value != -1) {
      var plan = displayedPlans[selectedPlanIndex.value];
      return "${formatData(plan.dataQuotaMb)}, ${plan.validityDays} Days";
    }
    return "";
  }

  // For the Recommendation Card (Just picking the first available or selected)
  EsimProduct? get recommendedPlan {
    if (selectedPlanIndex.value != -1) return displayedPlans[selectedPlanIndex.value];
    if (displayedPlans.isNotEmpty) return displayedPlans.first;
    return null;
  }

  // Price Range for Recommendation Card (e.g. "$5.00 - $20.00")
  String get priceRange {
    if (allPlans.isEmpty) return "\$0.00";
    double min = allPlans.map((e) => e.retailPrice).reduce((a, b) => a < b ? a : b);
    double max = allPlans.map((e) => e.retailPrice).reduce((a, b) => a > b ? a : b);
    if (min == max) return "\$${min.toStringAsFixed(2)}";
    return "\$${min.toStringAsFixed(2)} – \$${max.toStringAsFixed(2)}";
  }

  // var selectedIndex = 0.obs;
  // Rx<int> selectedPlanIndex = Rx<int>(-1);
  // Rx<int> quantity = 1.obs;
  // RxList<int> selectedPlans = RxList<int>();
  //
  // final List<Map<String, dynamic>> plans = [
  //   {'price': 4.00, 'calls': '50', 'sms': '50', 'data': '1 GB', 'validity': '7 days', 'index': 0},
  //   {'price': 5.00, 'calls': '70', 'sms': '70', 'data': '3 GB', 'validity': '10 days', 'index': 1},
  //   {'price': 6.00, 'calls': '100', 'sms': '100', 'data': '5 GB', 'validity': '15 days', 'index': 2},
  //   {'price': 6.00, 'calls': '100', 'sms': '100', 'data': '5 GB', 'validity': '15 days', 'index': 3},
  //   {'price': 4.00, 'calls': '50', 'sms': '50', 'data': '1 GB', 'validity': '7 days', 'index': 4},
  //   {'price': 5.00, 'calls': '70', 'sms': '70', 'data': '3 GB', 'validity': '10 days', 'index': 5},
  //   {'price': 6.00, 'calls': '100', 'sms': '100', 'data': '5 GB', 'validity': '15 days', 'index': 6},
  //   {'price': 6.00, 'calls': '100', 'sms': '100', 'data': '5 GB', 'validity': '15 days', 'index': 7},
  //
  // ];
  //
  // void selectPlan(int index) {
  //   selectedPlanIndex.value = index;
  //   quantity.value = 1; // Reset quantity when a new plan is selected
  // }
  //
  // void updateQuantity(int change) {
  //   if (quantity.value + change > 0) {
  //     quantity.value += change;
  //   }
  // }
  //
  // double get totalPrice {
  //   if (selectedPlanIndex.value != -1 && quantity.value > 0) {
  //     return plans[selectedPlanIndex.value]['price'] * quantity.value;
  //   }
  //   return 0.0;
  // }
  //
  // String get planDescription {
  //   if (selectedPlanIndex.value != -1) {
  //     var plan = plans[selectedPlanIndex.value];
  //     return "${plan['validity']}, ${plan['sms']} SMS, ${plan['calls']} phone call, and ${plan['data']}";
  //   }
  //   return "";
  // }
  //
  // bool get isCheckoutEnabled {
  //   return selectedPlanIndex.value != -1 && quantity.value > 0;
  // }
}
