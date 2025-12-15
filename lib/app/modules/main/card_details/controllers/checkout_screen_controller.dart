import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../data/models/esim_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/services/auth_service.dart';
import '../views/payment_webview.dart';

class CheckoutController extends GetxController {

  final AuthService _authService = AuthService();

  // --- Data Variables ---
  late EsimProduct plan;
  late int quantity;
  late String countryName;
  late String imageUrl;

  // --- State ---
  var isLoading = false.obs;

  // --- Calculated Variables ---
  double totalPrice = 0.0;

  @override
  void onInit() {
    super.onInit();
    _retrieveArguments();
  }

  void _retrieveArguments() {
    final args = Get.arguments as Map<String, dynamic>;

    plan = args['plan'];
    quantity = args['quantity'] ?? 1;
    countryName = args['name'] ?? 'Unknown Country';
    imageUrl = args['imageUrl'] ?? '';
    totalPrice = plan.retailPrice * quantity;
  }

  // --- Logic / Actions ---
  Future<void> submitOrder() async {
    // 1. Set Loading ON
    isLoading.value = true;

    try {
      final Uri url = Uri.parse(
          'https://wilixifysoft.com/wp-json/esim/v1/login-redirect');

      // Construct Plan String
      String formattedData = _getFormattedPlanString();
      String planString = "$formattedData ${plan.validityDays}Days";

      // Get Credentials
      UserModel? user = await _authService.getUserData();
      String? password = await _authService.getPassword();

      // Prepare Body
      Map<String, dynamic> body = {
        "email": user?.userEmail,
        "password": password,
        "region": 'Europe',
        "plan": planString
      };

      // ---------------- DEBUGGING REQUEST ----------------
      print("==================================================");
      print("🚀 API REQUEST: $url");
      try {
        // Pretty Print JSON for readability
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        String prettyBody = encoder.convert(body);
        print("📦 BODY SENT:\n$prettyBody");
      } catch (e) {
        print("📦 BODY SENT (Raw): $body");
      }
      print("==================================================");
      // ---------------------------------------------------

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // ---------------- DEBUGGING RESPONSE ----------------
      print("==================================================");
      print("📥 STATUS CODE: ${response.statusCode}");
      print("📥 RAW RESPONSE BODY (See Log below):");

      // We use log() because print() cuts off long text
      log(response.body, name: 'API_RESPONSE');
      print("==================================================");
      // ----------------------------------------------------

      if (response.statusCode == 200) {
        // Try to parse JSON. If the server returns HTML (error page), this will throw an exception
        try {
          final data = jsonDecode(response.body);

          print("✅ PARSED JSON: $data"); // Debug parsed data

          if (data['success'] == true && data['redirect_url'] != null) {
            String redirectUrl = data['redirect_url'];

            print("🔗 REDIRECTING TO: $redirectUrl");

            // Keep loading true while opening webview
            await _openPaymentWebView(redirectUrl);
          } else {
            isLoading.value = false;
            Get.snackbar(
                "Login Failed", data['msg'] ?? "Unknown error occurred");
          }
        } catch (jsonError) {
          isLoading.value = false;
          print("❌ JSON PARSING ERROR: $jsonError");
          Get.snackbar("API Error", "Server returned invalid JSON");
        }
      } else {
        isLoading.value = false;
        Get.snackbar("Server Error", "Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ EXCEPTION: $e");
      isLoading.value = false;
      Get.snackbar("Connection Error", "Check your internet connection");
    }
  }
  // --- Helpers ---
  Future<void> _openPaymentWebView(String urlString) async {
    // 1. Navigate to WebView
    final result = await Get.to(() => PaymentWebView(initialUrl: urlString));

    // 2. NOW we can turn off the loader, because the user has come back
    // (or the navigation is fully complete)
    isLoading.value = false;

    // 3. Handle Result
    if (result == 'success') {
      Get.offAllNamed('/home');
      Get.snackbar("Success", "Payment completed successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
    }
  }

  String _getFormattedPlanString() {
    if (plan.dataQuotaMb >= 1024) {
      return "${(plan.dataQuotaMb / 1024).toStringAsFixed(0)}GB";
    }
    return "${plan.dataQuotaMb}MB";
  }

  String get formattedDataUI {
    if (plan.dataQuotaMb >= 1024) {
      return "${(plan.dataQuotaMb / 1024).toStringAsFixed(0)} GB";
    }
    return "${plan.dataQuotaMb} MB";
  }
}
