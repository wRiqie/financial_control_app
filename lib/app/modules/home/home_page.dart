import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/enums/bill_status.dart';
import 'package:financial_control_app/app/modules/home/home_controller.dart';
import 'package:financial_control_app/app/modules/home/widgets/category_item/category_item.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () {
              controller.swapDate(context);
            },
            child: Text(
                AppHelpers.monthResolver(controller.selectedDate.month) +
                    ' - ${controller.selectedDate.year}'),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: size.width,
                  height: size.height * .25,
                  color: Get.theme.colorScheme.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Remaining balance',
                        style: TextStyle(
                          fontSize: 32,
                          color: Get.theme.colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        AppHelpers.formatCurrency(controller.remainingBalance),
                        style: const TextStyle(
                          fontSize: 42,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Bills of the month',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ...controller.categories
                          .map((e) => CategoryItem(
                                onTap: (bill, billController) =>
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (_) {
                                          return Wrap(
                                            children: [
                                              ListTile(
                                                title: bill.status ==
                                                        BillStatus.paid.index
                                                    ? const Text(
                                                        'Mark as unpaid')
                                                    : const Text(
                                                        'Mark as paid'),
                                                leading: Icon(
                                                  bill.status ==
                                                          BillStatus.paid.index
                                                      ? Icons.highlight_off
                                                      : Icons
                                                          .check_circle_outline,
                                                  color: Get.theme.colorScheme
                                                      .primary,
                                                ),
                                                onTap: () async {
                                                  await controller
                                                      .toogleBillStatus(bill);
                                                  await billController
                                                      .getBills();
                                                  Get.back();
                                                },
                                              ),
                                              ListTile(
                                                title: const Text('Edit'),
                                                leading: Icon(
                                                  Icons.edit,
                                                  color: Get.theme.colorScheme
                                                      .primary,
                                                ),
                                                onTap: () async {
                                                  Get.back();
                                                  await Get.toNamed(
                                                      Routes.registerBill,
                                                      arguments: {
                                                        'categoryId':
                                                            bill.categoryId,
                                                        'bill': bill,
                                                        'selectedMonth':
                                                            controller
                                                                .selectedMonth,
                                                      });
                                                  await billController
                                                      .getBills();
                                                  await controller
                                                      .selectMonth();
                                                },
                                              ),
                                              ListTile(
                                                title: const Text('Delete'),
                                                leading: Icon(
                                                  Icons.delete,
                                                  color: Get.theme.colorScheme
                                                      .primary,
                                                ),
                                                onTap: () async {
                                                  Get.back();
                                                  Get.defaultDialog(
                                                    contentPadding: const EdgeInsets.all(20),
                                                    title: 'Alert',
                                                    middleText:
                                                        'Are you sure you want to delete this bill?',
                                                    confirm: Text('yes'),
                                                    cancel: Text('no'),
                                                    onCancel: (){},
                                                    onConfirm: (){print('confirm');},
                                                  );
                                                  // await controller.selectMonth();
                                                },
                                              ),
                                            ],
                                          );
                                        }),
                                category: e,
                                addBillToCategory: controller.addBillToCategory,
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
