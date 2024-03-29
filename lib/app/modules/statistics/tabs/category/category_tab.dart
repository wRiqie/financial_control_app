import '../../../../core/theme/dark/dark_colors.dart';
import '../../../../data/models/category_data_model.dart';
import '../../../../data/provider/database_provider.dart';
import '../../../../data/repository/bill_repository.dart';
import '../../../../data/repository/category_repository.dart';
import 'category_tab_controller.dart';
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
                          PieSeries<CategoryDataModel, String>(
                            dataSource: controller.datas,
                            pointColorMapper: (CategoryDataModel data, _) =>
                                data.color,
                            xValueMapper: (CategoryDataModel data, _) =>
                                data.name,
                            yValueMapper: (CategoryDataModel data, _) =>
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
                        color: e.color,
                        icon: e.icon,
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
    IconData? icon,
    Color? color,
  }) {
    return ListTile(
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 15,
          color: Get.theme.colorScheme.onSurface,
        ),
      ),
      leading: Icon(
        icon,
        color: color,
      ),
      trailing: Text(
        '${percent ?? 0}%',
        style: const TextStyle(color: DarkColors.grey),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
    );
  }
}
