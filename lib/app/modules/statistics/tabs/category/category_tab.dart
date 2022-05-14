import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/enums/category_enum.dart';
import 'package:financial_control_app/app/data/models/category_data.dart';
import 'package:financial_control_app/app/data/provider/database_provider.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/data/repository/category_repository.dart';
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
        init: CategoryTabController(
          BillRepository(DatabaseProvider.db),
          CategoryRepository(DatabaseProvider.db),
        ),
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                controller.isLoading
                    ? Container(
                        height: 300,
                      )
                    : SfCircularChart(
                        legend: Legend(
                          position: LegendPosition.right,
                          overflowMode: LegendItemOverflowMode.wrap,
                          isVisible: true,
                        ),
                        series: <CircularSeries>[
                          PieSeries<CategoryData, String>(
                            dataSource: controller.datas,
                            pointColorMapper: (CategoryData data, _) =>
                                data.color,
                            xValueMapper: (CategoryData data, _) => data.name,
                            yValueMapper: (CategoryData data, _) =>
                                data.totalPrice,
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 20,
                ),
                ...controller.datas.map(
                  (e) => Material(
                    color: controller.datas.indexOf(e).isEven
                        ? Get.theme.colorScheme.surface
                        : Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: categoryTile(
                        id: e.id,
                        title: e.name,
                        totalPrice: e.totalPrice,
                        color: CategoryExtension.color(e.id),
                        percent: controller
                            .calcPercent(e.totalPrice)
                            .toStringAsFixed(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget categoryTile({
    required int id,
    String? title,
    num? totalPrice,
    String? percent,
    Color? color,
  }) {
    return ListTile(
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: color
        ),
      ),
      leading: Icon(
        CategoryExtension.icon(id),
        color: color,
      ),
      trailing: Text(
        '${percent ?? 0}%',
        style: TextStyle(color: DarkColors.grey),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
    );
  }
}
