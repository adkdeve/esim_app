import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final popular = [
    {'name': 'Qatar',    'asset': 'https://flagcdn.com/w320/qa.png'},
    {'name': 'China',    'asset': 'https://flagcdn.com/w320/cn.png'},
    {'name': 'Cuba',   'asset': 'https://flagcdn.com/w320/cu.png'},
    {'name': 'Egypt', 'asset': 'https://flagcdn.com/w320/eg.png'},
    {'name': 'Israel',   'asset': 'https://flagcdn.com/w320/il.png'},
    {'name': 'England',  'asset': 'https://flagcdn.com/w320/gb.png'},
  ];

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);

    super.onInit();
  }

}
