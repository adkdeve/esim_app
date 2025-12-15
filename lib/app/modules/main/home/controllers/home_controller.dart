import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../common/widgets/login_required_view.dart';
import '../../../../../common/widgets/my_text.dart';
import '../../../../data/models/category_model.dart';
import '../../../../data/models/sub_category_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/services/auth_service.dart';
import '../../../../routes/app_pages.dart';
import '../../card_details/views/payment_webview.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var regionalCategories = <CategoryModel>[].obs;
  var countryCategories = <SubCategoryModel>[].obs;

  final AuthService _authService = AuthService();

  // Search Logic
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final LayerLink layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  var searchResults = <dynamic>[].obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    // fetchAndProcessProducts();
    loadRegionalCategories();
    loadCountryCategories();
    // Listen to focus changes to hide overlay when clicking away
    searchFocusNode.addListener(() {
      if (!searchFocusNode.hasFocus) {
        removeOverlay();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    removeOverlay(); // Clean up
    super.onClose();
  }

  // --- SEARCH LOGIC ---
  void onSearchQueryChanged(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      removeOverlay();
      return;
    }

    // 1. Filter Countries
    final countries = countryCategories.where((c) =>
        c.name.toLowerCase().contains(query.toLowerCase())
    ).toList();

    // 2. Filter Regions
    final regions = regionalCategories.where((r) =>
        r.name.toLowerCase().contains(query.toLowerCase())
    ).toList();

    // 3. Combine
    searchResults.value = [...countries, ...regions];

    // 4. Show/Update Overlay
    if (searchResults.isNotEmpty) {
      if (_overlayEntry == null) {
        showOverlay();
      } else {
        // Force rebuild of the overlay to show new results
        _overlayEntry!.markNeedsBuild();
      }
    } else {
      removeOverlay();
    }
  }

  // --- OVERLAY MANAGEMENT ---
  void showOverlay() {
    if (_overlayEntry != null) return;

    // Get the render box of the search bar to know its size
    // Note: This requires context, but since we are in controller,
    // we assume the view sets up the LayerLink correctly.

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: Get.width - 44, // Match search bar width (screen width - padding)
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0, 50), // 50 is approx height of search bar + spacing
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(8),
              color: Colors.white, // White background as per image
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300), // Limit height
                child: Obx(() => ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: searchResults.length,
                  separatorBuilder: (c, i) => const Divider(height: 1, color: Colors.grey),
                  itemBuilder: (context, index) {
                    final item = searchResults[index];
                    return _buildSearchItem(item, context);
                  },
                )),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(Get.overlayContext!)?.insert(_overlayEntry!);
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // Helper to build the list item (Handles both models)
  Widget _buildSearchItem(dynamic item, BuildContext context) {
    String name = '';
    String image = '';
    String price = '';

    if (item is SubCategoryModel) {
      name = item.name;
      image = item.image;
      price = item.price;
    } else if (item is CategoryModel) {
      name = item.name;
      image = item.image;
      price = item.price;
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      leading: Container(
        width: 30,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          image: DecorationImage(
            image: (image.startsWith('http') ? NetworkImage(image) : AssetImage(image)) as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: MyText(
        text: name,
        color: Colors.black, // Black text on white bg
        fontSize: 14,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.start,
      ),
      trailing: MyText(
        text: price,
        color: Colors.grey[700],
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      onTap: () {
        searchController.clear();
        searchFocusNode.unfocus();
        removeOverlay();

        // Navigate
        if (item is SubCategoryModel) {
          navigateToDetails(item);
        } else if (item is CategoryModel) {
          navigateToDetails(item);
        }
      },
    );
  }

  Future<void> navigateToDetails(dynamic model) async {
    // 1. CHECK AUTHENTICATION FIRST
    UserModel? user = await _authService.getUserData();
    String? password = await _authService.getPassword();

    // If user or password is missing, they are treated as a Guest
    if (user == null || password == null) {
      // Stop the process and show Login Required Screen
      Get.to(() => Scaffold(
        body: LoginRequiredView(
          bodyText: "Please login first to proceed with the purchase.",
          onLoginPressed: () {
            // Navigate to your Login Screen
            // Verify 'Routes.SIGNIN' matches your app's route name
            Get.offAllNamed(Routes.SIGNIN);
          },
        ),
      ));
      return; // Exit the function here
    }

    // 2. USER IS LOGGED IN - PROCEED WITH API CALL
    try {
      final Uri url = Uri.parse('https://wilixifysoft.com/wp-json/esim/v1/login-redirect');

      // Prepare Body using the retrieved credentials
      Map<String, dynamic> body = {
        "email": user.userEmail, // Safe to use now
        "password": password,    // Safe to use now
        "region": model.name,
        "plan": '10 GB 5 Days'
      };

      // --- Debugging Logs ---
      print("==================================================");
      print("🚀 API REQUEST: $url");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );


      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);

          if (data['success'] == true && data['redirect_url'] != null) {
            String redirectUrl = data['redirect_url'];

            // Proceed to Payment WebView
            await _openPaymentWebView(redirectUrl);

          } else {
            Get.snackbar("Login Failed", data['msg'] ?? "Unknown error occurred");
          }
        } catch (jsonError) {
          print("❌ JSON PARSING ERROR: $jsonError");
          Get.snackbar("API Error", "Server returned invalid JSON");
        }
      } else {
        Get.snackbar("Server Error", "Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ EXCEPTION: $e");
      Get.snackbar("Connection Error", "Check your internet connection");
    }
  }

  Future<void> _openPaymentWebView(String urlString) async {
    // 1. Navigate to WebView
    final result = await Get.to(() => PaymentWebView(initialUrl: urlString));

    // 2. NOW we can turn off the loader, because the user has come back
    // (or the navigation is fully complete)

    // 3. Handle Result
    if (result == 'success') {
      Get.offAllNamed('/home');
      Get.snackbar("Success", "Payment completed successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
    }
  }

  void loadRegionalCategories() {
    List<Map<String, dynamic>> rawData = [
      {
        "uid": "5652",
        "name": "Europe",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/eu-300x300.png",
        "price": "\$5.00 - \$79.99"
      },
      {
        "uid": "5686",
        "name": "Asia",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/Asia-300x300.jpg",
        "price": "\$5.00 - \$99.99"
      },
      {
        "uid": "5798",
        "name": "Balkans",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/balkans-300x300.jpg",
        "price": "\$5.99 - \$66.99"
      },
      {
        "uid": "5742",
        "name": "Caribbean",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/caribbean-300x300.png",
        "price": "\$6.99 - \$73.99"
      },
      {
        "uid": "5820",
        "name": "Caucasus",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/caucasus-300x300.png",
        "price": "\$5.99 - \$79.99"
      },
      {
        "uid": "5720",
        "name": "Latin America",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/latinamerica-150x150.png",
        "price": "\$9.99 - \$73.99"
      },
      {
        "uid": "5764",
        "name": "Middle East",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/middleeast-600x600.jpg",
        "price": "\$6.99 - \$149.99"
      }
    ];

    regionalCategories.value = rawData.map((json) => CategoryModel.fromJson(json)).toList();
  }

  void loadCountryCategories() {
    List<Map<String, dynamic>> rawData = [
      {
        "id": 5627,
        "name": "Afghanistan",
        "price": "\$29.99 – \$216.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/af-4-150x150.png",
        "category": "Asia"
      },
      {
        "id": 5587,
        "name": "Zambia",
        "price": "\$34.99 – \$254.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/zm-150x150.png",
        "category": "Africa"
      },
      {
        "id": 5553,
        "name": "Vietnam",
        "price": "\$5.00 – \$112.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/vn-150x150.png",
        "category": "Asia"
      },
      {
        "id": 5531,
        "name": "Venezuela",
        "price": "\$6.99 – \$76.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ve-150x150.png",
        "category": "South America"
      },
      {
        "id": 5513,
        "name": "Vanuatu",
        "price": "\$58.99 – \$420.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/vu-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 5479,
        "name": "Uzbekistan",
        "price": "\$4.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/uz-150x150.png",
        "category": "Asia"
      },
      {
        "id": 5445,
        "name": "United States",
        "price": "\$4.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/us-150x150.png",
        "category": "North America"
      },
      {
        "id": 5423,
        "name": "Uruguay",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/uy-150x150.png",
        "category": "South America"
      },
      {
        "id": 5401,
        "name": "United Arab Emirates",
        "price": "\$6.99 – \$64.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ae-150x150.png",
        "category": "Asia"
      },
      {
        "id": 5367,
        "name": "Ukraine",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ua-150x150.png",
        "category": "Europe"
      },
      {
        "id": 5333,
        "name": "United Kingdom",
        "price": "\$5.00 – \$69.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gb-150x150.png",
        "category": "Europe"
      },
      {
        "id": 5311,
        "name": "Uganda",
        "price": "\$8.99 – \$87.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ug-150x150.png",
        "category": "Africa"
      },
      {
        "id": 5289,
        "name": "Turks and Caicos Islands",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/tc-150x150.png",
        "category": "North America"
      },
      {
        "id": 5255,
        "name": "Turkey",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/tr-150x150.png",
        "category": "Europe"
      },
      {
        "id": 5221,
        "name": "Tunisia",
        "price": "\$5.00 – \$112.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/tn-150x150.png",
        "category": "Africa"
      },
      {
        "id": 5203,
        "name": "Trinidad and Tobago",
        "price": "\$18.99 – \$135.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/tt-150x150.png",
        "category": "North America"
      },
      {
        "id": 5185,
        "name": "Tonga",
        "price": "\$34.99 – \$254.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/to-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 5167,
        "name": "Timor-Leste",
        "price": "\$31.99 – \$231.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/tl-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 5133,
        "name": "Thailand",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/th-150x150.png",
        "category": "Asia"
      },
      {
        "id": 5111,
        "name": "Tanzania",
        "price": "\$7.99 – \$86.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/tz-150x150.png",
        "category": "Africa"
      },
      {
        "id": 5093,
        "name": "Tajikistan",
        "price": "\$27.99 – \$201.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/tj-150x150.png",
        "category": "Asia"
      },
      {
        "id": 5059,
        "name": "Taiwan",
        "price": "\$5.00 – \$112.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/tw-150x150.png",
        "category": "Asia"
      },
      {
        "id": 5025,
        "name": "Switzerland",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ch-300x300.png",
        "category": "Europe"
      },
      {
        "id": 4991,
        "name": "Sweden",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/se-150x150.png",
        "category": "Europe"
      },
      {
        "id": 4969,
        "name": "Eswatini",
        "price": "\$13.99 – \$188.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/sz-150x150.png",
        "category": "Africa"
      },
      {
        "id": 4951,
        "name": "Suriname",
        "price": "\$38.99 – \$277.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/sr-150x150.png",
        "category": "South America"
      },
      {
        "id": 4933,
        "name": "Sudan",
        "price": "\$27.99 – \$201.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/sd-150x150.png",
        "category": "Africa"
      },
      {
        "id": 4911,
        "name": "Saint Vincent and the Grenadines",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/vc-150x150.png",
        "category": "North America"
      },
      {
        "id": 4877,
        "name": "Sri Lanka",
        "price": "\$5.00 – \$99.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/lk-150x150.png",
        "category": "Asia"
      },
      {
        "id": 4843,
        "name": "Spain",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/es-150x150.png",
        "category": "Europe"
      },
      {
        "id": 4809,
        "name": "South Korea",
        "price": "\$5.99 – \$99.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/kr-150x150.png",
        "category": "Asia"
      },
      {
        "id": 4775,
        "name": "South Africa",
        "price": "\$6.99 – \$246.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/za-150x150.png",
        "category": "Africa"
      },
      {
        "id": 4753,
        "name": "Slovenia",
        "price": "\$5.00 – \$24.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/si-150x150.png",
        "category": "Europe"
      },
      {
        "id": 4719,
        "name": "Slovakia",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/sk-150x150.png",
        "category": "Europe"
      },
      {
        "id": 4685,
        "name": "Singapore",
        "price": "\$4.00 – \$99.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/sg-150x150.png",
        "category": "Asia"
      },
      {
        "id": 4667,
        "name": "Seychelles",
        "price": "\$27.99 – \$201.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/sc-150x150.png",
        "category": "Africa"
      },
      {
        "id": 4633,
        "name": "Serbia",
        "price": "\$6.99 – \$149.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/rs-150x150.png",
        "category": "Europe"
      },
      {
        "id": 4615,
        "name": "Senegal",
        "price": "\$20.99 – \$150.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/sn-150x150.png",
        "category": "Africa"
      },
      {
        "id": 4581,
        "name": "Saudi Arabia",
        "price": "\$6.99 – \$99.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/sa-150x150.png",
        "category": "Asia"
      },
      {
        "id": 4547,
        "name": "San Marino",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/sm-150x150.png",
        "category": "Europe"
      },
      {
        "id": 4529,
        "name": "Samoa",
        "price": "\$37.99 – \$276.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ws-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 4507,
        "name": "Saint Lucia",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/lc-150x150.png",
        "category": "North America"
      },
      {
        "id": 4485,
        "name": "Saint Kitts and Nevis",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/kn-150x150.png",
        "category": "North America"
      },
      {
        "id": 4463,
        "name": "Rwanda",
        "price": "\$13.99 – \$188.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/rw-150x150.png",
        "category": "Africa"
      },
      {
        "id": 4441,
        "name": "Russia",
        "price": "\$5.99 – \$65.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ru-150x150.png",
        "category": "Europe"
      },
      {
        "id": 4407,
        "name": "Romania",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ro-150x150.png",
        "category": "Europe"
      },
      {
        "id": 4373,
        "name": "Réunion",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/re-150x150.png",
        "category": "Africa"
      },
      {
        "id": 4339,
        "name": "Republic of the Congo",
        "price": "\$8.99 – \$199.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/cg-150x150.png",
        "category": "Africa"
      },
      {
        "id": 4317,
        "name": "Qatar",
        "price": "\$6.99 – \$52.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/qa-150x126.png",
        "category": "Asia"
      },
      {
        "id": 4283,
        "name": "Portugal",
        "price": "\$6.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/pt-150x150.png",
        "category": "Europe"
      },
      {
        "id": 4249,
        "name": "Poland",
        "price": "\$5.00 – \$69.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/pl-150x150.png",
        "category": "Europe"
      },
      {
        "id": 4215,
        "name": "Philippines",
        "price": "\$5.00 – \$99.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ph-150x150.png",
        "category": "Asia"
      },
      {
        "id": 4193,
        "name": "Peru",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/pe-150x150.png",
        "category": "South America"
      },
      {
        "id": 4171,
        "name": "Paraguay",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/py-150x150.png",
        "category": "South America"
      },
      {
        "id": 4153,
        "name": "Papua New Guinea",
        "price": "\$68.99 – \$501.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/pg-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 4131,
        "name": "Panama",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/pa-150x150.png",
        "category": "North America"
      },
      {
        "id": 4097,
        "name": "Pakistan",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/pk-150x150.png",
        "category": "Asia"
      },
      {
        "id": 4075,
        "name": "Oman",
        "price": "\$6.99 – \$52.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/om-150x150.png",
        "category": "Asia"
      },
      {
        "id": 4041,
        "name": "Norway",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/no-150x150.png",
        "category": "Europe"
      },
      {
        "id": 4023,
        "name": "Northern Mariana Islands",
        "price": "\$31.99 – \$231.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mp-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 4001,
        "name": "Nigeria",
        "price": "\$7.99 – \$86.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ng-150x150.png",
        "category": "Africa"
      },
      {
        "id": 3983,
        "name": "Niger",
        "price": "\$66.99 – \$486.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ne-150x150.png",
        "category": "Africa"
      },
      {
        "id": 3961,
        "name": "Nicaragua",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ni-150x150.png",
        "category": "North America"
      },
      {
        "id": 3927,
        "name": "New Zealand",
        "price": "\$5.00 – \$112.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/nz-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 3893,
        "name": "Netherlands",
        "price": "\$5.00 – \$69.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/nl-150x150.png",
        "category": "Europe"
      },
      {
        "id": 3875,
        "name": "Nepal",
        "price": "\$24.99 – \$186.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/np-300x300.png",
        "category": "Asia"
      },
      {
        "id": 3857,
        "name": "Nauru",
        "price": "\$36.99 – \$269.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/nr-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 3823,
        "name": "Myanmar",
        "price": "\$5.99 – \$112.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mm-150x150.png",
        "category": "Asia"
      },
      {
        "id": 3801,
        "name": "Mozambique",
        "price": "\$11.99 – \$160.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mz-150x150.png",
        "category": "Africa"
      },
      {
        "id": 3779,
        "name": "Morocco",
        "price": "\$8.99 – \$75.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ma-150x150.png",
        "category": "Africa"
      },
      {
        "id": 3757,
        "name": "Montserrat",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ms-150x150.png",
        "category": "North America"
      },
      {
        "id": 3723,
        "name": "Montenegro",
        "price": "\$6.99 – \$149.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/me-150x150.png",
        "category": "Europe"
      },
      {
        "id": 3705,
        "name": "Mongolia",
        "price": "\$17.99 – \$134.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mn-150x150.png",
        "category": "Asia"
      },
      {
        "id": 3683,
        "name": "Monaco",
        "price": "\$14.99 – \$202.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mc-150x150.png",
        "category": "Europe"
      },
      {
        "id": 3661,
        "name": "Moldova",
        "price": "\$5.00 – \$30.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/md-150x150.png",
        "category": "Europe"
      },
      {
        "id": 3639,
        "name": "Mexico",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mx-150x150.png",
        "category": "North America"
      },
      {
        "id": 3605,
        "name": "Mayotte",
        "price": "\$5.99 – \$199.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/yt-150x150.png",
        "category": "Africa"
      },
      {
        "id": 3583,
        "name": "Mauritius",
        "price": "\$13.99 – \$182.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mu-150x150.png",
        "category": "Africa"
      },
      {
        "id": 3549,
        "name": "Martinique",
        "price": "\$5.99 – \$149.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mq-150x150.png",
        "category": "North America"
      },
      {
        "id": 3515,
        "name": "Malta",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mt-150x150.png",
        "category": "Europe"
      },
      {
        "id": 3481,
        "name": "Malaysia",
        "price": "\$5.00 – \$99.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/my-150x150.png",
        "category": "Asia"
      },
      {
        "id": 3447,
        "name": "Malawi",
        "price": "\$9.99 – \$246.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mw-150x150.png",
        "category": "Africa"
      },
      {
        "id": 3425,
        "name": "Madagascar",
        "price": "\$5.99 – \$65.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mg-150x150.png",
        "category": "Africa"
      },
      {
        "id": 3403,
        "name": "North Macedonia",
        "price": "\$5.99 – \$32.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mk-150x150.png",
        "category": "Europe"
      },
      {
        "id": 3381,
        "name": "Macau",
        "price": "\$5.00 – \$30.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/mo-150x150.png",
        "category": "Asia"
      },
      {
        "id": 3347,
        "name": "Luxembourg",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/lu-150x150.png",
        "category": "Europe"
      },
      {
        "id": 3313,
        "name": "Lithuania",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/lt-150x150.png",
        "category": "Europe"
      },
      {
        "id": 3279,
        "name": "Liechtenstein",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/li-150x150.png",
        "category": "Europe"
      },
      {
        "id": 3261,
        "name": "Liberia",
        "price": "\$45.99 – \$336.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/lr-150x150.png",
        "category": "Africa"
      },
      {
        "id": 3227,
        "name": "Latvia",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/lv-150x150.png",
        "category": "Europe"
      },
      {
        "id": 3205,
        "name": "Laos",
        "price": "\$7.99 – \$75.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/la-150x150.png",
        "category": "Asia"
      },
      {
        "id": 3183,
        "name": "Kyrgyzstan",
        "price": "\$5.00 – \$31.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/kg-150x150.png",
        "category": "Asia"
      },
      {
        "id": 3161,
        "name": "Kuwait",
        "price": "\$6.99 – \$44.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/kw-150x150.png",
        "category": "Asia"
      },
      {
        "id": 3143,
        "name": "Kiribati",
        "price": "\$36.99 – \$269.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ki-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 3121,
        "name": "Kenya",
        "price": "\$8.99 – \$87.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ke-150x150.png",
        "category": "Africa"
      },
      {
        "id": 3087,
        "name": "Kazakhstan",
        "price": "\$4.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/kz-150x150.png",
        "category": "Asia"
      },
      {
        "id": 3065,
        "name": "Jordan",
        "price": "\$6.99 – \$52.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/jo-150x150.png",
        "category": "Asia"
      },
      {
        "id": 3031,
        "name": "Japan",
        "price": "\$5.00 – \$69.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/jp-150x150.png",
        "category": "Asia"
      },
      {
        "id": 3009,
        "name": "Jamaica",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/jm-150x150.png",
        "category": "North America"
      },
      {
        "id": 2987,
        "name": "Ivory Coast",
        "price": "\$11.99 – \$160.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ci-150x150.png",
        "category": "Africa"
      },
      {
        "id": 2953,
        "name": "Italy",
        "price": "\$5.00 – \$69.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/it-150x150.png",
        "category": "Europe"
      },
      {
        "id": 2919,
        "name": "Israel",
        "price": "\$4.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/il-150x150.png",
        "category": "Asia"
      },
      {
        "id": 2885,
        "name": "Ireland",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ie-150x150.png",
        "category": "Europe"
      },
      {
        "id": 2851,
        "name": "Iraq",
        "price": "\$6.99 – \$149.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/iq-150x150.png",
        "category": "Asia"
      },
      {
        "id": 2817,
        "name": "Indonesia",
        "price": "\$5.00 – \$69.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/id-150x150.png",
        "category": "Asia"
      },
      {
        "id": 2783,
        "name": "India",
        "price": "\$5.00 – \$99.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/in-150x150.png",
        "category": "Asia"
      },
      {
        "id": 2749,
        "name": "Iceland",
        "price": "\$6.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/is-150x150.png",
        "category": "Europe"
      },
      {
        "id": 2715,
        "name": "Hungary",
        "price": "\$5.00 – \$38.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/hk-150x150.png",
        "category": "Asia"
      },
      {
        "id": 2671,
        "name": "Honduras",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/hn-150x150.png",
        "category": "North America"
      },
      {
        "id": 2653,
        "name": "Haiti",
        "price": "\$37.99 – \$276.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ht-150x150.png",
        "category": "North America"
      },
      {
        "id": 2635,
        "name": "Guyana",
        "price": "\$38.99 – \$277.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gy-150x150.png",
        "category": "South America"
      },
      {
        "id": 2613,
        "name": "Guinea-Bissau",
        "price": "\$13.99 – \$188.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gw-150x150.png",
        "category": "Africa"
      },
      {
        "id": 2591,
        "name": "Guinea",
        "price": "\$13.99 – \$188.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gn-150x150.png",
        "category": "Africa"
      },
      {
        "id": 2569,
        "name": "Guatemala",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gt-150x150.png",
        "category": "North America"
      },
      {
        "id": 2551,
        "name": "Guam",
        "price": "\$15.99 – \$119.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gu-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 2517,
        "name": "Guadeloupe",
        "price": "\$5.99 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gp-150x150.png",
        "category": "North America"
      },
      {
        "id": 2495,
        "name": "Grenada",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gd-150x150.png",
        "category": "North America"
      },
      {
        "id": 2477,
        "name": "Greenland",
        "price": "\$17.99 – \$127.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gl-150x150.png",
        "category": "North America"
      },
      {
        "id": 2443,
        "name": "Greece",
        "price": "\$6.00 – \$69.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gr-150x150.png",
        "category": "Europe"
      },
      {
        "id": 2409,
        "name": "Gibraltar",
        "price": "\$5.99 – \$112.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gi-150x150.png",
        "category": "Europe"
      },
      {
        "id": 2375,
        "name": "Ghana",
        "price": "\$5.99 – \$199.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gh-150x150.png",
        "category": "Africa"
      },
      {
        "id": 2341,
        "name": "Germany",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/de-150x150.png",
        "category": "Europe"
      },
      {
        "id": 2307,
        "name": "Georgia",
        "price": "\$4.00 – \$149.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ge-150x150.png",
        "category": "Asia"
      },
      {
        "id": 2289,
        "name": "Gambia",
        "price": "\$31.99 – \$225.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gm-150x150.png",
        "category": "Africa"
      },
      {
        "id": 2271,
        "name": "Gabon",
        "price": "\$34.99 – \$254.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ga-150x150.png",
        "category": "Africa"
      },
      {
        "id": 2253,
        "name": "French Polynesia",
        "price": "\$61.99 – \$449.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/pf-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 2219,
        "name": "French Guiana",
        "price": "\$5.99 – \$149.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/gf-150x150.png",
        "category": "South America"
      },
      {
        "id": 2185,
        "name": "France",
        "price": "\$5.00 – \$69.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/fr-150x150.png",
        "category": "Europe"
      },
      {
        "id": 2151,
        "name": "Finland",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/fi-150x150.png",
        "category": "Europe"
      },
      {
        "id": 2129,
        "name": "Fiji",
        "price": "\$10.99 – \$133.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/fj-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 2107,
        "name": "Faroe Islands",
        "price": "\$6.00 – \$24.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/fo-150x150.png",
        "category": "Europe"
      },
      {
        "id": 2089,
        "name": "Ethiopia",
        "price": "\$68.99 – \$501.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/et-150x150.png",
        "category": "Africa"
      },
      {
        "id": 2055,
        "name": "Estonia",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ee-150x150.png",
        "category": "Europe"
      },
      {
        "id": 2033,
        "name": "El Salvador",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/sv-150x150.png",
        "category": "North America"
      },
      {
        "id": 2011,
        "name": "Egypt",
        "price": "\$6.99 – \$53.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/eg-150x150.png",
        "category": "Africa"
      },
      {
        "id": 1977,
        "name": "Ecuador",
        "price": "\$6.99 – \$199.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ec-150x150.png",
        "category": "South America"
      },
      {
        "id": 1955,
        "name": "Dominican Republic",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/do-150x150.png",
        "category": "North America"
      },
      {
        "id": 1933,
        "name": "Dominica",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/dm-150x150.png",
        "category": "North America"
      },
      {
        "id": 1899,
        "name": "Denmark",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/dk-150x150.png",
        "category": "Europe"
      },
      {
        "id": 1877,
        "name": "DR Congo",
        "price": "\$9.99 – \$86.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/cd-150x150.png",
        "category": "Africa"
      },
      {
        "id": 1843,
        "name": "Czechia",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/cz-150x150.png",
        "category": "Europe"
      },
      {
        "id": 1809,
        "name": "Cyprus",
        "price": "\$5.00 – \$69.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/cy-150x150.png",
        "category": "Europe"
      },
      {
        "id": 1775,
        "name": "Croatia",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/hr-150x150.png",
        "category": "Europe"
      },
      {
        "id": 1753,
        "name": "Costa Rica",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/cr-150x150.png",
        "category": "North America"
      },
      {
        "id": 1731,
        "name": "Colombia",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/co-150x150.png",
        "category": "South America"
      },
      {
        "id": 1697,
        "name": "China",
        "price": "\$6.99 – \$149.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/cn-150x150.png",
        "category": "Asia"
      },
      {
        "id": 1675,
        "name": "Chile",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/cl-150x150.png",
        "category": "South America"
      },
      {
        "id": 1641,
        "name": "Chad",
        "price": "\$8.99 – \$199.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/td-150x150.png",
        "category": "Africa"
      },
      {
        "id": 1619,
        "name": "Cayman Islands",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ky-150x150.png",
        "category": "North America"
      },
      {
        "id": 1601,
        "name": "Cape Verde",
        "price": "\$54.99 – \$396.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/cv-150x150.png",
        "category": "Africa"
      },
      {
        "id": 1567,
        "name": "Canada",
        "price": "\$5.99 – \$112.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ca-150x150.png",
        "category": "North America"
      },
      {
        "id": 1545,
        "name": "Cameroon",
        "price": "\$11.99 – \$160.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/cm-150x150.png",
        "category": "Africa"
      },
      {
        "id": 1523,
        "name": "Cambodia",
        "price": "\$8.99 – \$75.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/kh-150x150.png",
        "category": "Asia"
      },
      {
        "id": 1501,
        "name": "Bulgaria",
        "price": "\$5.00 – \$24.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/bg-150x150.png",
        "category": "Europe"
      },
      {
        "id": 1467,
        "name": "Brunei",
        "price": "\$6.99 – \$149.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/bn-150x150.png",
        "category": "Asia"
      },
      {
        "id": 1445,
        "name": "British Virgin Islands",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/vg-150x150.png",
        "category": "North America"
      },
      {
        "id": 1423,
        "name": "Brazil",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/br-150x150.png",
        "category": "South America"
      },
      {
        "id": 1401,
        "name": "Botswana",
        "price": "\$12.99 – \$161.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/bw-150x150.png",
        "category": "Africa"
      },
      {
        "id": 1379,
        "name": "Bosnia and Herzegovina",
        "price": "\$6.99 – \$65.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ba-150x150.png",
        "category": "Europe"
      },
      {
        "id": 1357,
        "name": "Bolivia",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/bo-150x150.png",
        "category": "South America"
      },
      {
        "id": 1339,
        "name": "Bhutan",
        "price": "\$16.99 – \$120.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/bt-150x150.png",
        "category": "Asia"
      },
      {
        "id": 1321,
        "name": "Bermuda",
        "price": "\$18.99 – \$141.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/bm-150x150.png",
        "category": "North America"
      },
      {
        "id": 1303,
        "name": "Benin",
        "price": "\$45.99 – \$336.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/bj-150x150.png",
        "category": "Africa"
      },
      {
        "id": 1285,
        "name": "Belize",
        "price": "\$21.99 – \$164.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/bz-150x150.png",
        "category": "North America"
      },
      {
        "id": 1251,
        "name": "Belgium",
        "price": "\$5.00 – \$69.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/be-150x150.png",
        "category": "Europe"
      },
      {
        "id": 1229,
        "name": "Barbados",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/bb-150x150.png",
        "category": "North America"
      },
      {
        "id": 1207,
        "name": "Bangladesh",
        "price": "\$5.99 – \$65.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/bd-150x150.png",
        "category": "Asia"
      },
      {
        "id": 1185,
        "name": "Bahrain",
        "price": "\$7.99 – \$75.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/bh-150x150.png",
        "category": "Asia"
      },
      {
        "id": 1163,
        "name": "Bahamas",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/bs-150x150.png",
        "category": "North America"
      },
      {
        "id": 1129,
        "name": "Azerbaijan",
        "price": "\$5.99 – \$199.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/az-150x150.png",
        "category": "Europe"
      },
      {
        "id": 1095,
        "name": "Austria",
        "price": "\$5.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/at-150x150.png",
        "category": "Europe"
      },
      {
        "id": 1073,
        "name": "Australia",
        "price": "\$5.99 – \$38.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/au-150x150.png",
        "category": "Oceania"
      },
      {
        "id": 1051,
        "name": "Aruba",
        "price": "\$12.99 – \$174.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/aw-150x150.png",
        "category": "North America"
      },
      {
        "id": 1017,
        "name": "Armenia",
        "price": "\$5.00 – \$112.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/am-150x150.png",
        "category": "Asia"
      },
      {
        "id": 995,
        "name": "Argentina",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ar-150x150.png",
        "category": "South America"
      },
      {
        "id": 973,
        "name": "Antigua and Barbuda",
        "price": "\$6.99 – \$73.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ag-150x150.png",
        "category": "North America"
      },
      {
        "id": 951,
        "name": "Anguilla",
        "price": "\$6.99 – \$72.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ai-150x150.png",
        "category": "North America"
      },
      {
        "id": 929,
        "name": "Andorra",
        "price": "\$5.99 – \$65.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/ad-150x150.png",
        "category": "Europe"
      },
      {
        "id": 895,
        "name": "Algeria",
        "price": "\$4.00 – \$79.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/dz-150x150.png",
        "category": "Africa"
      },
      {
        "id": 861,
        "name": "Albania",
        "price": "\$6.99 – \$199.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/al-150x150.png",
        "category": "Europe"
      }
    ];

    countryCategories.value = rawData.map((json) => SubCategoryModel.fromJson(json)).toList();
  }

}