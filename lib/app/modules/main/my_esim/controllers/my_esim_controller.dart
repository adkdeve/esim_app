import 'package:get/get.dart';

class MyEsimController extends GetxController {
  String iccid = '312425346456576767879';
  var esimName = "Son's eSIM".obs;

  final List<Map<String, dynamic>> currentPlans = [
    {
      'country': 'China',
      'subtitle': 'eSIM',
      'validUntil': DateTime(2024, 8, 19),
      'totalGb': 20.0,
      'usedGb': 9.35,
      'flagImage': 'https://flagcdn.com/w320/cn.png',
      'active': true

    },
    {
      'country': 'USA',
      'subtitle': 'eSIM',
      'validUntil': DateTime(2024, 9, 10),
      'totalGb': 15.0,
      'usedGb': 5.5,
      'flagImage': 'https://flagcdn.com/w320/cn.png',
      'active': true
    },
    {
      'country': 'China',
      'subtitle': 'eSIM',
      'validUntil': DateTime(2024, 8, 19),
      'totalGb': 20.0,
      'usedGb': 9.35,
      'flagImage': 'https://flagcdn.com/w320/cn.png',
      'active': true

    },
    {
      'country': 'USA',
      'subtitle': 'eSIM',
      'validUntil': DateTime(2024, 9, 10),
      'totalGb': 15.0,
      'usedGb': 5.5,
      'flagImage': 'https://flagcdn.com/w320/cn.png',
      'active': true
    },
  ];

  final List<Map<String, dynamic>> achievedPlans = [
    {
      'country': 'Pakistan',
      'subtitle': 'eSIM',
      'validUntil': DateTime(2024, 7, 10),
      'totalGb': 10.0,
      'usedGb': 10.0,
      'flagImage': 'https://flagcdn.com/w320/cn.png',
      'active': false
    },
    {
      'country': 'Pakistan',
      'subtitle': 'eSIM',
      'validUntil': DateTime(2024, 7, 10),
      'totalGb': 10.0,
      'usedGb': 10.0,
      'flagImage': 'https://flagcdn.com/w320/cn.png',
      'active': false
    },
    {
      'country': 'Pakistan',
      'subtitle': 'eSIM',
      'validUntil': DateTime(2024, 7, 10),
      'totalGb': 10.0,
      'usedGb': 10.0,
      'flagImage': 'https://flagcdn.com/w320/cn.png',
      'active': false
    },
    {
      'country': 'Pakistan',
      'subtitle': 'eSIM',
      'validUntil': DateTime(2024, 7, 10),
      'totalGb': 10.0,
      'usedGb': 10.0,
      'flagImage': 'https://flagcdn.com/w320/cn.png',
      'active': false
    },
  ];

}
