import 'package:financial_control_app/app/data/models/statistic_data.dart';
import 'package:financial_control_app/app/modules/statistics/statistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends GetView<StatisticsController> {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(10) 
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Months total values',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                  ),
                  series: <ChartSeries>[
                    SplineSeries<StatisticData, String>(
                      dataSource: controller.datas,
                      color: Get.theme.colorScheme.primary,
                      width: 3,
                      xValueMapper: (StatisticData data, _) => data.x,
                      yValueMapper: (StatisticData data, _) => data.y,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
