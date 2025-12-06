import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pcom_app/app/core/config/app_config.dart';
import 'package:pcom_app/app/core/core.dart';
import '../../../../data/models/esim_model.dart';

class CardDetailsController extends GetxController {

  // Received Data
  late String name;
  late String imageUrl;

  // Observables
  var isLoading = true.obs;
  var errorMessage = ''.obs;

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
    // 1. Get the argument (Just the name)
    name = Get.arguments['name'] ?? 'Unknown';

    // Set a placeholder image or logic to get image based on name
    imageUrl = Get.arguments['imageUrl'] ?? 'assets/flags/default.png';

    // 2. Fetch Data
    fetchPlans(name);
  }

  /// Determines if input is Region or Country and calls API
  Future<void> fetchPlans(String name) async {
    isLoading.value = true; // START LOADING
    errorMessage.value = '';

    try {
      String queryParam = _resolveApiParameter(name);
      final Uri url = Uri.parse(ApisUrl.getAllProducts + queryParam);

      String basicAuth = 'Basic ' + base64Encode(utf8.encode('${AppConfig.maya_api_username}:${AppConfig.maya_api_password}'));

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> productList = data['products'] ?? [];

        if (productList.isEmpty) {
          errorMessage.value = "No plans available for this region.";
        } else {
          // Map JSON to Models
          allPlans = productList.map((e) => EsimProduct.fromJson(e)).toList();

          // Organize data (Create categories, sort lists)
          processData();
        }
      } else {
        errorMessage.value = "Failed to load plans. (Error ${response.statusCode})";
      }
    } catch (e) {
      errorMessage.value = "Something went wrong. Please check your connection.";
      print("Error: $e");
    } finally {
      // STOP LOADING (This runs whether successful or failed)
      isLoading.value = false;
    }
  }

  /// Logic to distinguish Region vs Country and format query
  String _resolveApiParameter(String input) {
    String cleanedInput = input.trim().toLowerCase();

    // 1. Check if it matches known Regions
    // API Regions: europe, apac, latam, caribbean, mena, balkans, caucasus
    const List<String> regions = [
      'europe', 'apac', 'latam', 'caribbean', 'mena', 'balkans', 'caucasus',
      'asia pacific', 'latin america' // Handling friendly names
    ];

    if (regions.contains(cleanedInput)) {
      // Map friendly names to API slugs if necessary
      if (cleanedInput == 'asia pacific') cleanedInput = 'apac';
      if (cleanedInput == 'latin america') cleanedInput = 'latam';

      return "?region=$cleanedInput";
    }

    // 2. If not a region, assume it's a Country and get ISO2 code
    String isoCode = _getIsoCode(input);
    return "?country=${isoCode.toLowerCase()}";
  }

  /// Helper to convert Country Name to ISO2 Code (US, FR, GB)
  /// Ideally, replace this with a package like 'country_codes'
  String _getIsoCode(String name) {
    // Normalize input
    String cleanedName = name.trim().toLowerCase();

    Map<String, String> isoCodes = {
      // --- Common Aliases & Variations ---
      'usa': 'US',
      'united states of america': 'US',
      'uk': 'GB',
      'great britain': 'GB',
      'uae': 'AE',
      'south korea': 'KR',
      'north korea': 'KP',
      'russia': 'RU',
      'vietnam': 'VN',
      'laos': 'LA',
      'ivory coast': 'CI',
      'turkiye': 'TR',
      'czech republic': 'CZ',
      'swaziland': 'SZ',
      'macau': 'MO',
      'hong kong': 'HK',

      // --- A ---
      'afghanistan': 'AF',
      'aland islands': 'AX',
      'albania': 'AL',
      'algeria': 'DZ',
      'american samoa': 'AS',
      'andorra': 'AD',
      'angola': 'AO',
      'anguilla': 'AI',
      'antarctica': 'AQ',
      'antigua and barbuda': 'AG',
      'argentina': 'AR',
      'armenia': 'AM',
      'aruba': 'AW',
      'australia': 'AU',
      'austria': 'AT',
      'azerbaijan': 'AZ',

      // --- B ---
      'bahamas': 'BS',
      'bahrain': 'BH',
      'bangladesh': 'BD',
      'barbados': 'BB',
      'belarus': 'BY',
      'belgium': 'BE',
      'belize': 'BZ',
      'benin': 'BJ',
      'bermuda': 'BM',
      'bhutan': 'BT',
      'bolivia': 'BO',
      'bonaire, sint eustatius and saba': 'BQ',
      'bosnia and herzegovina': 'BA',
      'botswana': 'BW',
      'bouvet island': 'BV',
      'brazil': 'BR',
      'british indian ocean territory': 'IO',
      'brunei darussalam': 'BN',
      'brunei': 'BN',
      'bulgaria': 'BG',
      'burkina faso': 'BF',
      'burundi': 'BI',

      // --- C ---
      'cabo verde': 'CV',
      'cape verde': 'CV',
      'cambodia': 'KH',
      'cameroon': 'CM',
      'canada': 'CA',
      'cayman islands': 'KY',
      'central african republic': 'CF',
      'chad': 'TD',
      'chile': 'CL',
      'china': 'CN',
      'christmas island': 'CX',
      'cocos (keeling) islands': 'CC',
      'colombia': 'CO',
      'comoros': 'KM',
      'congo': 'CG',
      'congo, democratic republic of the': 'CD',
      'dr congo': 'CD',
      'cook islands': 'CK',
      'costa rica': 'CR',
      'cote d\'ivoire': 'CI',
      'croatia': 'HR',
      'cuba': 'CU',
      'curacao': 'CW',
      'cyprus': 'CY',
      'czechia': 'CZ',

      // --- D ---
      'denmark': 'DK',
      'djibouti': 'DJ',
      'dominica': 'DM',
      'dominican republic': 'DO',

      // --- E ---
      'ecuador': 'EC',
      'egypt': 'EG',
      'el salvador': 'SV',
      'equatorial guinea': 'GQ',
      'eritrea': 'ER',
      'estonia': 'EE',
      'eswatini': 'SZ',
      'ethiopia': 'ET',

      // --- F ---
      'falkland islands': 'FK',
      'falkland islands (malvinas)': 'FK',
      'faroe islands': 'FO',
      'fiji': 'FJ',
      'finland': 'FI',
      'france': 'FR',
      'french guiana': 'GF',
      'french polynesia': 'PF',
      'french southern territories': 'TF',

      // --- G ---
      'gabon': 'GA',
      'gambia': 'GM',
      'georgia': 'GE',
      'germany': 'DE',
      'ghana': 'GH',
      'gibraltar': 'GI',
      'greece': 'GR',
      'greenland': 'GL',
      'grenada': 'GD',
      'guadeloupe': 'GP',
      'guam': 'GU',
      'guatemala': 'GT',
      'guernsey': 'GG',
      'guinea': 'GN',
      'guinea-bissau': 'GW',
      'guyana': 'GY',

      // --- H ---
      'haiti': 'HT',
      'heard island and mcdonald islands': 'HM',
      'holy see': 'VA',
      'vatican': 'VA',
      'honduras': 'HN',
      'hong kong': 'HK',
      'hungary': 'HU',

      // --- I ---
      'iceland': 'IS',
      'india': 'IN',
      'indonesia': 'ID',
      'iran': 'IR',
      'iraq': 'IQ',
      'ireland': 'IE',
      'isle of man': 'IM',
      'israel': 'IL',
      'italy': 'IT',

      // --- J ---
      'jamaica': 'JM',
      'japan': 'JP',
      'jersey': 'JE',
      'jordan': 'JO',

      // --- K ---
      'kazakhstan': 'KZ',
      'kenya': 'KE',
      'kiribati': 'KI',
      'korea, democratic people\'s republic of': 'KP',
      'korea, republic of': 'KR',
      'kuwait': 'KW',
      'kyrgyzstan': 'KG',

      // --- L ---
      'lao people\'s democratic republic': 'LA',
      'latvia': 'LV',
      'lebanon': 'LB',
      'lesotho': 'LS',
      'liberia': 'LR',
      'libya': 'LY',
      'liechtenstein': 'LI',
      'lithuania': 'LT',
      'luxembourg': 'LU',

      // --- M ---
      'macao': 'MO',
      'madagascar': 'MG',
      'malawi': 'MW',
      'malaysia': 'MY',
      'maldives': 'MV',
      'mali': 'ML',
      'malta': 'MT',
      'marshall islands': 'MH',
      'martinique': 'MQ',
      'mauritania': 'MR',
      'mauritius': 'MU',
      'mayotte': 'YT',
      'mexico': 'MX',
      'micronesia': 'FM',
      'moldova': 'MD',
      'monaco': 'MC',
      'mongolia': 'MN',
      'montenegro': 'ME',
      'montserrat': 'MS',
      'morocco': 'MA',
      'mozambique': 'MZ',
      'myanmar': 'MM',

      // --- N ---
      'namibia': 'NA',
      'nauru': 'NR',
      'nepal': 'NP',
      'netherlands': 'NL',
      'new caledonia': 'NC',
      'new zealand': 'NZ',
      'nicaragua': 'NI',
      'niger': 'NE',
      'nigeria': 'NG',
      'niue': 'NU',
      'norfolk island': 'NF',
      'north macedonia': 'MK',
      'northern mariana islands': 'MP',
      'norway': 'NO',

      // --- O ---
      'oman': 'OM',

      // --- P ---
      'pakistan': 'PK',
      'palau': 'PW',
      'palestine': 'PS',
      'panama': 'PA',
      'papua new guinea': 'PG',
      'paraguay': 'PY',
      'peru': 'PE',
      'philippines': 'PH',
      'pitcairn': 'PN',
      'poland': 'PL',
      'portugal': 'PT',
      'puerto rico': 'PR',

      // --- Q ---
      'qatar': 'QA',

      // --- R ---
      'reunion': 'RE',
      'romania': 'RO',
      'russian federation': 'RU',
      'rwanda': 'RW',

      // --- S ---
      'saint barthelemy': 'BL',
      'saint helena': 'SH',
      'saint kitts and nevis': 'KN',
      'saint lucia': 'LC',
      'saint martin (french part)': 'MF',
      'saint pierre and miquelon': 'PM',
      'saint vincent and the grenadines': 'VC',
      'samoa': 'WS',
      'san marino': 'SM',
      'sao tome and principe': 'ST',
      'saudi arabia': 'SA',
      'senegal': 'SN',
      'serbia': 'RS',
      'seychelles': 'SC',
      'sierra leone': 'SL',
      'singapore': 'SG',
      'sint maarten (dutch part)': 'SX',
      'slovakia': 'SK',
      'slovenia': 'SI',
      'solomon islands': 'SB',
      'somalia': 'SO',
      'south africa': 'ZA',
      'south georgia and the south sandwich islands': 'GS',
      'south sudan': 'SS',
      'spain': 'ES',
      'sri lanka': 'LK',
      'sudan': 'SD',
      'suriname': 'SR',
      'svalbard and jan mayen': 'SJ',
      'sweden': 'SE',
      'switzerland': 'CH',
      'syrian arab republic': 'SY',
      'syria': 'SY',

      // --- T ---
      'taiwan': 'TW',
      'tajikistan': 'TJ',
      'tanzania': 'TZ',
      'thailand': 'TH',
      'timor-leste': 'TL',
      'togo': 'TG',
      'tokelau': 'TK',
      'tonga': 'TO',
      'trinidad and tobago': 'TT',
      'tunisia': 'TN',
      'turkey': 'TR',
      'turkmenistan': 'TM',
      'turks and caicos islands': 'TC',
      'tuvalu': 'TV',

      // --- U ---
      'uganda': 'UG',
      'ukraine': 'UA',
      'united arab emirates': 'AE',
      'united kingdom': 'GB',
      'united states': 'US',
      'united states minor outlying islands': 'UM',
      'uruguay': 'UY',
      'uzbekistan': 'UZ',

      // --- V ---
      'vanuatu': 'VU',
      'venezuela': 'VE',
      'viet nam': 'VN',
      'virgin islands (british)': 'VG',
      'virgin islands (u.s.)': 'VI',

      // --- W ---
      'wallis and futuna': 'WF',
      'western sahara': 'EH',

      // --- Y ---
      'yemen': 'YE',

      // --- Z ---
      'zambia': 'ZM',
      'zimbabwe': 'ZW',
    };

    // Return mapped code, or if not found, assume it might already be an ISO code or return the name
    return isoCodes[cleanedName] ?? name;
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

  // Helper to format MB to GB
  String formatData(int mb) {
    if (mb >= 1024) {
      return "${(mb / 1024).toStringAsFixed(0)} GB";
    }
    return "$mb MB";
  }

  double get totalPrice {
    if (selectedPlanIndex.value != -1) {
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
