import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsController extends GetxController with GetSingleTickerProviderStateMixin {
  final tabs = <Tab>[
    const Tab(text: 'Month'),
    const Tab(text: 'Category'),
  ];

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
