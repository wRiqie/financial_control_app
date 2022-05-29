import 'package:expandable/expandable.dart';
import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/enums/category_enum.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/data/provider/database_provider.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/modules/home/widgets/category_item/category_item_controller.dart';
import 'package:flutter/Material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final Function(int categoryId, CategoryItemController controller)
      addBillToCategory;
  final Function(Bill bill, CategoryItemController controller) onTap;
  const CategoryItem(
      {Key? key,
      required this.onTap,
      required this.category,
      required this.addBillToCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryItemController>(
      init:
          CategoryItemController(BillRepository(DatabaseProvider.db), category),
      global: false,
      tag: category.id.toString(),
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
                    color: CategoryExtension.color(category.id),
                  ),
                  height: 50,
                  width: 50,
                  child: Icon(
                    CategoryExtension.icon(category.id),
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
                          CategoryExtension.getById(category.id).name.tr,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppHelpers.formatCurrency(_.totalPrice),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            _.leftPrice > 0
                            ? Text(
                                'Falta ${AppHelpers.formatCurrency(_.leftPrice)}',
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
                      value: _.percentage,
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
                          onTap: () {
                            onTap(e, _);
                          },
                          child: _buildBill(e),
                        ),
                      ),
                    )
                    .toList(),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  child: Text('addABill'.tr),
                  onPressed: () {
                    addBillToCategory(category.id, _);
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
        Divider(
          color: Get.theme.colorScheme.onBackground,
        ),
      ],
    );
  }
}
