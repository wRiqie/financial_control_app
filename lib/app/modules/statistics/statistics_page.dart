import 'package:financial_control_app/app/modules/statistics/statistics_controller.dart';
import 'package:financial_control_app/app/modules/statistics/tabs/category/category_tab.dart';
import 'package:financial_control_app/app/modules/statistics/tabs/month/month_tab.dart';
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
            title: const Text('Statistics'),
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
