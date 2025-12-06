import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pcom_app/app/core/config/app_config.dart';
import '../views/data_usage_status.dart';

class DataUsageController extends GetxController {

  // --- Input ---
  TextEditingController esimIDController = TextEditingController();

  // --- State Observables ---
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // --- Data Observables (Stored as MB) ---
  var totalDataMb = 0.0.obs;
  var remainingDataMb = 0.0.obs;

  // Plan Details
  var planName = ''.obs;
  var status = ''.obs;

  // --- Computed Properties ---

  // Calculate Used Data
  double get usedDataMb => totalDataMb.value - remainingDataMb.value;

  // Calculate Percentage (0 to 100)
  double get remainingPercentage {
    if (totalDataMb.value == 0) return 0;
    return (remainingDataMb.value / totalDataMb.value) * 100;
  }

  // --- UI Formatters ---
  String get totalDataStr => _formatBytesToReadable(totalDataMb.value);
  String get usedDataStr => _formatBytesToReadable(usedDataMb);
  String get remainingDataStr => _formatBytesToReadable(remainingDataMb.value);

  // --- Actions ---

  Future<void> checkDataUsage() async {
    // 1. Validation
    String input = esimIDController.text.trim();
    if (input.isEmpty) {
      Get.snackbar("Required", "Please enter an Order No or ICCID",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    // 2. Start Loading
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // 3. Get URL (wilixifysoft.com)
      final Uri url = _getApiUrl(input);

      print("🚀 FETCHING: $url");

      // 4. API Call
      // Note: Removed Maya Basic Auth as this is your custom endpoint.
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      log(response.body, name: 'USAGE_API_RESPONSE');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // 5. Parse Response
        if (data['plans'] != null && (data['plans'] as List).isNotEmpty) {

          var plan = data['plans'][0];

          // Extract Bytes
          double totalBytes = double.parse(plan['data_quota_bytes'].toString());
          double remainingBytes = double.parse(plan['data_bytes_remaining'].toString());

          // Convert to MB (Bytes / 1024 / 1024)
          totalDataMb.value = totalBytes / 1048576;
          remainingDataMb.value = remainingBytes / 1048576;

          // Store details
          planName.value = plan['plan_type']?['plan_name'] ?? 'eSIM Plan';
          status.value = plan['network_status'] ?? 'UNKNOWN';

          // 6. Navigate
          Get.to(() => const DataUsageStatus());

        } else {
          errorMessage.value = "No active plans found for this ID.";
          Get.snackbar("No Plans", errorMessage.value);
        }
      } else {
        errorMessage.value = "Error ${response.statusCode}: ${response.reasonPhrase}";
        Get.snackbar("Error", "Could not fetch details.");
      }
    } catch (e) {
      errorMessage.value = "Connection error: $e";
      print(e);
      Get.snackbar("Error", "Something went wrong.");
    } finally {
      isLoading.value = false;
    }
  }

  /// Helper to determine if input is ICCID or Order ID
  Uri _getApiUrl(String input) {
    // Logic: ICCIDs start with '89' and are long. Everything else is an Order ID.
    bool isIccid = input.startsWith('89') && input.length > 15;

    if (isIccid) {
      // Example: .../usage?iccid=8910...
      return Uri.parse(AppConfig.baseUrl +"db2/usage?iccid=$input");
    } else {
      // Example: .../usage?order=8097
      return Uri.parse(AppConfig.baseUrl + "db2/usage?order=$input");
    }
  }

  /// Helper to convert MB to readable GB/MB string
  String _formatBytesToReadable(double mb) {
    if (mb >= 1024) {
      return "${(mb / 1024).toStringAsFixed(2)} GB";
    }
    return "${mb.toStringAsFixed(0)} MB";
  }
}