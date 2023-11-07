import '../../../../core/utils/helpers.dart';
import '../../../../data/models/month_data_model.dart';
import '../../../../data/provider/database_provider.dart';
import '../../../../data/repository/month_repository.dart';
import 'month_tab_controller.dart';
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
            SingleChildScrollView(
              primary: true,
              child: Column(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            'totalPriceForMonths'.tr,
                            style: const TextStyle(
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
                                  majorGridLines:
                                      const MajorGridLines(width: 0),
                                ),
                                series: <ChartSeries>[
                                  SplineSeries<MonthDataModel, String>(
                                    dataSource: controller.datas,
                                    color: Get.theme.colorScheme.primary,
                                    width: 3,
                                    xValueMapper: (MonthDataModel data, _) =>
                                        data.x,
                                    yValueMapper: (MonthDataModel data, _) =>
                                        data.y,
                                  )
                                ],
                              ),
                      ],
                    ),
                  ),
                  GridView.count(
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: [
                      _buildStatisticCard(
                        label: 'expensesOfMonth'.tr,
                        icon: Icons.monetization_on_outlined,
                        iconColor: Get.theme.colorScheme.primary,
                        value: controller.totalPrice,
                        profit: controller.totalPriceDecreased,
                      ),
                      _buildStatisticCard(
                        label: 'balanceDifference'.tr,
                        icon: Icons.percent,
                        iconColor: Get.theme.colorScheme.secondary,
                        percent: controller.balanceDifferencePercentage,
                        profit: controller.balanceDifferencePercentage < 0
                            ? false
                            : true,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      controller.caption,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Get.theme.colorScheme.primary),
                    ),
                  ),
                ],
              ),
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
              value != null && value != 0
                  ? profit
                      ? const Icon(
                          Icons.arrow_downward,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.arrow_upward,
                          color: Colors.red,
                        )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}
