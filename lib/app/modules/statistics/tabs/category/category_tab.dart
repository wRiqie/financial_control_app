import 'package:financial_control_app/app/data/models/category_data.dart';
import 'package:financial_control_app/app/modules/statistics/tabs/category/category_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryTabPage extends GetView<CategoryTabController> {
  const CategoryTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CategoryTabController>(
        init: CategoryTabController(),
        builder: (_) {
          return Column(
            children: [
              SfCircularChart(
                legend: Legend(
                  position: LegendPosition.right,
                  overflowMode: LegendItemOverflowMode.wrap,
                  isVisible: true,
                  isResponsive: true,
                ),
                series: <CircularSeries>[
                  PieSeries<CategoryData, String>(
                    dataSource: controller.datas,
                    pointColorMapper: (CategoryData data, _) => data.color,
                    xValueMapper: (CategoryData data, _) => data.x,
                    yValueMapper: (CategoryData data, _) => data.y,
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
