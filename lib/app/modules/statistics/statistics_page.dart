import 'statistics_controller.dart';
import 'tabs/category/category_tab.dart';
import 'tabs/month/month_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsPage extends GetView<StatisticsController> {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticsController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('statistics'.tr),
            bottom: TabBar(
              controller: controller.tabController,
              tabs: controller.tabs,
            ),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: const [
              MonthTabPage(),
              CategoryTabPage(),
            ],
          ),
        );
      },
    );
  }
}
