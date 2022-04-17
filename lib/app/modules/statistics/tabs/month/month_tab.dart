import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/models/statistic_data.dart';
import 'package:financial_control_app/app/data/provider/database_provider.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:financial_control_app/app/modules/statistics/tabs/month/month_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthTabPage extends GetView<MonthTabController> {
  const MonthTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: MonthTabController(MonthRepository(DatabaseProvider.db)),
        builder: (_) => Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Get.theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(
                          'Months total values',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      controller.isLoading
                          ? Container(
                              height: 300,
                            )
                          : SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(width: 0),
                              ),
                              series: <ChartSeries>[
                                SplineSeries<StatisticData, String>(
                                  dataSource: controller.datas,
                                  color: Get.theme.colorScheme.primary,
                                  width: 3,
                                  xValueMapper: (StatisticData data, _) =>
                                      data.x,
                                  yValueMapper: (StatisticData data, _) =>
                                      data.y,
                                )
                              ],
                            ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      _buildStatisticCard(
                        label: 'Current month price',
                        icon: Icons.monetization_on_outlined,
                        iconColor: Get.theme.colorScheme.primary,
                        value: controller.totalPrice,
                        profit: controller.totalPriceDecreased,
                      ),
                      _buildStatisticCard(
                        label: 'Balance difference',
                        icon: Icons.percent,
                        iconColor: Get.theme.colorScheme.secondary,
                        percent: controller.balanceDifferencePercentage,
                        profit: controller.balanceDifferencePercentage < 0
                            ? false
                            : true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: controller.isLoading,
              child: Container(
                color: Colors.black45,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard({
    required String label,
    required IconData icon,
    required Color iconColor,
    num? value,
    num? percent,
    bool profit = false,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(
        left: 15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Icon(
            icon,
            size: 32,
            color: iconColor,
          ),
          const SizedBox(
            height: 15,
          ),
          Wrap(
            direction: Axis.horizontal,
            children: [
              Text(
                value != null
                    ? AppHelpers.formatCurrency(value)
                    : '${percent?.toStringAsFixed(0) ?? 0}%',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              profit
                  ? const Icon(
                      Icons.arrow_upward,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.arrow_downward,
                      color: Colors.red,
                    ),
            ],
          )
        ],
      ),
    );
  }
}
