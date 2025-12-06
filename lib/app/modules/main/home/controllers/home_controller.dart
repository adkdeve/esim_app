import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pcom_app/app/core/values/apis_url.dart';

import '../../../../data/models/category_model.dart';
import '../../../../data/models/esim_model.dart';
import '../../../../data/models/sub_category_model.dart';
import '../../card_details/views/card_details_view.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  // // 1. Store all products (hidden from UI, used for details view later)
  // var allProducts = <EsimProduct>[];
  //
  // // 2. Store unique countries to display on the Home Tab
  // var uniqueCountries = <String>[].obs;
  //
  // // 3. Loading state
  // var isLoading = true.obs;
  //
  // var countryNamesMap = <String, String>{}.obs;

  // 1. Observables to store the data
  var regionalCategories = <CategoryModel>[].obs;
  var countryCategories = <SubCategoryModel>[].obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    // fetchAndProcessProducts();
    loadRegionalCategories();
    loadCountryCategories();
    super.onInit();
  }

  // void fetchAndProcessProducts() async {
  //   // Debug: starting API call
  //   print("🔍 [DEBUG] fetchAndProcessProducts() CALLED");
  //   print("🔑 Using Basic Auth for Maya Connect API");
  //
  //   String username = "UEw6L0izT14n";
  //   String password = "IqH5NV6G9DTj7pL5moCfCsPqWX2hBYmMiUQrgpTzRt41iDYrSga8xEEucnk2Ken9";
  //
  //   String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
  //
  //   try {
  //     isLoading.value = true;
  //
  //     print("🌐 API URL: ${ApisUrl.getAllProducts}");
  //     print("📨 Sending GET request...");
  //     print("📌 Headers: {Authorization: $basicAuth}");
  //
  //     var response = await http
  //         .get(
  //       Uri.parse(ApisUrl.getAllProducts),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': basicAuth,
  //       },
  //     )
  //         .timeout(const Duration(seconds: 150))
  //         .catchError((e) {
  //       print("⏳ [ERROR] Timeout occurred: $e");
  //       throw Exception("Timeout occurred");
  //     });
  //
  //     print("📥 Response Status: ${response.statusCode}");
  //     print("📥 Raw Response Body:\n${response.body}");
  //
  //     // SUCCESS
  //     if (response.statusCode == 200) {
  //       dynamic decodedResponse;
  //
  //       try {
  //         decodedResponse = jsonDecode(response.body);
  //         print("📦 JSON Decoded Successfully");
  //       } catch (e) {
  //         print("❌ JSON DECODE ERROR: $e");
  //         return;
  //       }
  //
  //       if (decodedResponse == null || decodedResponse is! Map) {
  //         print("❌ Invalid API structure — Expected Map, got ${decodedResponse.runtimeType}");
  //         return;
  //       }
  //
  //       if (!decodedResponse.containsKey('products')) {
  //         print("❌ 'products' key NOT FOUND in API response");
  //         print("🔍 Keys found: ${decodedResponse.keys}");
  //         return;
  //       }
  //
  //       List<dynamic> data = decodedResponse['products'];
  //
  //       print("📦 Total products received: ${data.length}");
  //
  //       List<EsimProduct> products = [];
  //
  //       try {
  //         products = data.map((e) => EsimProduct.fromJson(e)).toList();
  //         print("✔ Product deserialization complete");
  //       } catch (e) {
  //         print("❌ ERROR MAPPING PRODUCTS: $e");
  //       }
  //
  //       allProducts = products;
  //
  //       // --- LOGIC UPDATE START ---
  //       Set<String> countries = {};
  //       Map<String, String> namesMap = {}; // Temporary map
  //
  //       for (var product in products) {
  //         // Skip products with no countries or regional plans (length > 1)
  //         if (product.countriesEnabled.isEmpty) continue;
  //
  //         if (product.countriesEnabled.length == 1) {
  //           String isoCode = product.countriesEnabled.first;
  //
  //           countries.add(isoCode);
  //
  //           // If we haven't found a name for this ISO code yet, extract it
  //           if (!namesMap.containsKey(isoCode)) {
  //             // Using the getter we added to the Model in Step 2
  //             namesMap[isoCode] = product.countryFromProductName;
  //           }
  //         }
  //       }
  //
  //       uniqueCountries.value = countries.toList()..sort();
  //       countryNamesMap.value = namesMap; // Update the observable map
  //
  //       for (var product in products) {
  //         if (product.countriesEnabled.isEmpty) {
  //           print("⚠ Product missing countries: ${product.name}");
  //           continue;
  //         }
  //         if (product.countriesEnabled.length == 1) {
  //           countries.add(product.countriesEnabled.first);
  //         }
  //       }
  //
  //       uniqueCountries.value = countries.toList()..sort();
  //
  //       print("🌍 Unique Countries Extracted: ${uniqueCountries.length}");
  //       print("🌍 Values: $uniqueCountries");
  //     } else {
  //       print("❌ API ERROR: ${response.statusCode} - ${response.reasonPhrase}");
  //       print("📥 Body: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("🔥 EXCEPTION in fetchAndProcessProducts(): $e");
  //   } finally {
  //     isLoading.value = false;
  //     print("🏁 DEBUG: fetchAndProcessProducts() COMPLETED");
  //   }
  // }
  //
  // // Helper to get flag URL (API gives 3-letter ISO, FlagCDN needs 2-letter)
  // String getFlagUrl(String iso3Code) {
  //   // You will need a map or package 'country_codes' to convert AFG -> af
  //   // For now, this is a placeholder
  //   return "https://flagcdn.com/w320/${iso3Code.substring(0,2).toLowerCase()}.png";
  // }
  //
  // // Helper to get Country Name from ISO code
  // String getCountryName(String iso3Code) {
  //   // Use a package like 'country_picker' or a local map
  //   return countryNamesMap[iso3Code] ?? iso3Code;
  // }

  // Inside HomeController or HomeView onTap
  void navigateToDetails(String countryIsoCode) {
    // // 1. Get Country Name and URL (use your existing helpers)
    // String name = getCountryName(countryIsoCode);
    // String flag = getFlagUrl(countryIsoCode);
    //
    // // 2. Filter the products strictly for this country
    // // We check if the product's 'countriesEnabled' list contains the selected ISO
    // List<EsimProduct> specificPlans = allProducts
    //     .where((p) => p.countriesEnabled.contains(countryIsoCode))
    //     .toList();
    //
    // // 3. Navigate with Arguments
    // Get.to(
    //         () => const CardDetailsView(),
    //     arguments: {
    //       'countryName': name,
    //       'imageUrl': flag,
    //       'products': specificPlans, // Pass the filtered list here
    //     }
    // );
  }

  void loadRegionalCategories() {
    List<Map<String, dynamic>> rawData = [
      {
        "uid": "1",
        "name": "South Africa",
        "image": "assets/images/ic_south_africa.png",
        "price": "\$6.99 - \$246.99"
      },
      {
        "uid": "2",
        "name": "Asia",
        "image": "assets/images/ic_asia.jpg",
        "price": "\$5.00 - \$99.00"
      },
      {
        "uid": "3",
        "name": "Balkans",
        "image": "assets/images/ic_balkans.jpg",
        "price": "\$5.99 - \$66.99"
      },
      {
        "uid": "4",
        "name": "Caribbean",
        "image": "assets/images/ic_caribbean.png",
        "price": "\$6.99 - \$73.99"
      },
      {
        "uid": "5",
        "name": "Caucasus",
        "image": "assets/images/ic_caucasus.png",
        "price": "\$5.99 - \$79.99"
      },
      {
        "uid": "6",
        "name": "Latin America",
        "image": "assets/images/ic_latinamerica.png",
        "price": "\$9.99 - \$73.99"
      },
      {
        "uid": "7",
        "name": "Middle East",
        "image": "assets/images/ic_middleeast.jpg",
        "price": "\$6.99 - \$149.99"
      }
    ];

    regionalCategories.value = rawData.map((json) => CategoryModel.fromJson(json)).toList();
  }

  void loadCountryCategories() {
    // Category ID for Asia (example)
    const String asiaCategoryId = "4678";

    List<Map<String, dynamic>> rawData = [
      {
        "id": 5627,
        "name": "Afghanistan",
        "price": "\$29.99 – \$216.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/af-4-150x150.png",
        "category_id": asiaCategoryId
      },
      {
        "id": 5553,
        "name": "Vietnam",
        "price": "\$5.00 – \$112.99",
        "image": "https://wilixifysoft.com/wp-content/uploads/2025/01/vn-150x150.png",
        "category_id": asiaCategoryId
      }
    ];

    countryCategories.value = rawData.map((json) => SubCategoryModel.fromJson(json)).toList();
  }

}
