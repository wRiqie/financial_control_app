import 'package:expandable/expandable.dart';
import '../../../../core/theme/dark/dark_colors.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../data/models/bill_model.dart';
import '../../../../data/models/category_model.dart';
import '../../../../data/models/month_model.dart';
import '../../../../data/provider/database_provider.dart';
import '../../../../data/repository/bill_repository.dart';
import 'category_item_controller.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final Function(CategoryModel category, CategoryItemController controller)
      addBillToCategory;
  final Function(BillModel bill, CategoryItemController controller) onTap;
  final MonthModel? month;
  const CategoryItem({
    Key? key,
    required this.onTap,
    required this.category,
    required this.addBillToCategory,
    required this.month,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryItemController>(
      init: CategoryItemController(
        homeController: Get.find(),
        repository: BillRepository(DatabaseProvider.db),
        category: category,
        month: month,
      ),
      global: false,
      builder: (_) => ExpandablePanel(
        controller: _.expandable,
        theme: const ExpandableThemeData(
          hasIcon: false,
          tapHeaderToExpand: false,
        ),
        header: InkWell(
          onTap: _.expandable.toggle,
          onLongPress: () {
            if (!_.expandable.expanded) _.expandable.toggle();
            _.toggleSelectedBills();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Color(category.color),
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
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category.translateName?.tr ?? category.name,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                AppHelpers.formatCurrency(_.bills.totalPrice),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              _.bills.leftPrice > 0
                                  ? Text(
                                      'missing'.tr +
                                          ' ' +
                                          AppHelpers.formatCurrency(
                                              _.bills.leftPrice),
                                      style: TextStyle(
                                          color: Get.theme.colorScheme.primary),
                                      textAlign: TextAlign.end,
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LinearProgressIndicator(
                        minHeight: 5,
                        value: _.bills.percentage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                      (e) => _buildBill(_, e),
                    )
                    .toList(),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  child: Text('addABill'.tr),
                  onPressed: () {
                    addBillToCategory(category, _);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBill(CategoryItemController _, BillModel bill) {
    return Column(
      children: [
        Material(
          color: Get.theme.colorScheme.surface,
          child: InkWell(
            onLongPress: () => _.toggleSelectedBill(bill),
            onTap: () {
              print(bill);
              _.homeController.selectedBills.isEmpty
                  ? onTap(bill, _)
                  : _.toggleSelectedBill(bill);
            },
            child: Container(
              color:
                  _.selected(bill) ? DarkColors.darkGrey : Colors.transparent,
              child: Padding(
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
            ),
          ),
        ),
        Divider(
          color: Get.theme.colorScheme.onBackground,
        ),
      ],
    );
  }
}
