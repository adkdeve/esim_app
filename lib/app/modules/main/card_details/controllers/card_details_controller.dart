import 'package:get/get.dart';

class CardDetailsController extends GetxController {

  var category = [
    '1 Day',
    '7 Days',
    '10 Days',
    '15 Days',
    '20 Days',
    '30 Days',
  ];

  var selectedIndex = 0.obs;
  Rx<int> selectedPlanIndex = Rx<int>(-1);
  Rx<int> quantity = 1.obs;
  RxList<int> selectedPlans = RxList<int>();

  final List<Map<String, dynamic>> plans = [
    {'price': 4.00, 'calls': '50', 'sms': '50', 'data': '1 GB', 'validity': '7 days', 'index': 0},
    {'price': 5.00, 'calls': '70', 'sms': '70', 'data': '3 GB', 'validity': '10 days', 'index': 1},
    {'price': 6.00, 'calls': '100', 'sms': '100', 'data': '5 GB', 'validity': '15 days', 'index': 2},
    {'price': 6.00, 'calls': '100', 'sms': '100', 'data': '5 GB', 'validity': '15 days', 'index': 3},
    {'price': 4.00, 'calls': '50', 'sms': '50', 'data': '1 GB', 'validity': '7 days', 'index': 4},
    {'price': 5.00, 'calls': '70', 'sms': '70', 'data': '3 GB', 'validity': '10 days', 'index': 5},
    {'price': 6.00, 'calls': '100', 'sms': '100', 'data': '5 GB', 'validity': '15 days', 'index': 6},
    {'price': 6.00, 'calls': '100', 'sms': '100', 'data': '5 GB', 'validity': '15 days', 'index': 7},

  ];

  void selectPlan(int index) {
    selectedPlanIndex.value = index;
    quantity.value = 1; // Reset quantity when a new plan is selected
  }

  void updateQuantity(int change) {
    if (quantity.value + change > 0) {
      quantity.value += change;
    }
  }

  double get totalPrice {
    if (selectedPlanIndex.value != -1 && quantity.value > 0) {
      return plans[selectedPlanIndex.value]['price'] * quantity.value;
    }
    return 0.0;
  }

  String get planDescription {
    if (selectedPlanIndex.value != -1) {
      var plan = plans[selectedPlanIndex.value];
      return "${plan['validity']}, ${plan['sms']} SMS, ${plan['calls']} phone call, and ${plan['data']}";
    }
    return "";
  }

  bool get isCheckoutEnabled {
    return selectedPlanIndex.value != -1 && quantity.value > 0;
  }
}
