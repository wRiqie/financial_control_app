import 'package:expandable/expandable.dart';
import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/modules/home/widgets/category_item/category_item_controller.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final Function(int categoryId) addBill;
  const CategoryItem({Key? key, required this.category, required this.addBill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryItemController>(
      init: CategoryItemController(),
      global: false,
      builder: (_) => ExpandablePanel(
        theme: const ExpandableThemeData(
          hasIcon: false,
          tapHeaderToExpand: true,
        ),
        header: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: category.color,
                  ),
                  height: 50,
                  width: 50,
                  child: Icon(
                    category.icon,
                    color: Colors.white,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppHelpers.categoryResolver(category.id),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const LinearProgressIndicator(
                      minHeight: 5,
                      value: 0.3,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppHelpers.formatCurrency(200.32),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Left ' + AppHelpers.formatCurrency(54.67),
                      style: const TextStyle(color: DarkColors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        collapsed: Container(),
        expanded: Container(
          color: Get.theme.colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ..._.bills
                    .map(
                      (e) => Material(
                        color: Get.theme.colorScheme.surface,
                        child: InkWell(
                          onTap: () {},
                          child: _buildBill(e),
                        ),
                      ),
                    )
                    .toList(),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  child: const Text('Add a bill'),
                  onPressed: () {
                    addBill(category.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBill(Bill bill) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 5,
                    color: AppHelpers.billStatusResolver(bill.status),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        bill.title,
                        style: TextStyle(color: Get.theme.colorScheme.primary),
                      ),
                      bill.maxPortion != null
                          ? Text(
                              '${bill.portion}/${bill.maxPortion}',
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
              Text(
                AppHelpers.formatCurrency(bill.value),
              ),
            ],
          ),
        ),
        Divider(color: Get.theme.colorScheme.onBackground,),
      ],
    );
  }
}
