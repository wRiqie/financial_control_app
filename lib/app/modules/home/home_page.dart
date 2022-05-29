import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/enums/bill_status_enum.dart';
import 'package:financial_control_app/app/global/widgets/confirm_dialog.dart';
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
              // controller.swapDate(context);
            },
            child: Text(
                AppHelpers.monthResolver(controller.selectedDate.month) +
                    ' - ${controller.selectedDate.year}'),
          ),
          actions: [
            IconButton(
              onPressed: controller.openPreferences,
              icon: const Icon(Icons.app_registration_outlined),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SingleChildScrollView(
                  controller: controller.valueCardController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      _buildValueCard(
                        title: 'remainingBalance'.tr,
                        value: controller.remainingBalance,
                        position: 0,
                        size: size,
                      ),
                      _buildValueCard(
                        title: 'balanceOfMonth'.tr,
                        value: controller.selectedMonth?.balance ?? 0,
                        position: 1,
                        size: size,
                        color: Get.theme.colorScheme.secondary,
                      )
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
                      Text(
                        'billsOfMonth'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ...controller.categories
                          .map((e) => CategoryItem(
                                onTap: (bill, categoryController) =>
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (_) {
                                          return Wrap(
                                            children: [
                                              ListTile(
                                                title: bill.status ==
                                                        EBillStatus.paid.id
                                                    ? Text('marksUnpaid'.tr)
                                                    : Text('marksPaid'.tr),
                                                leading: Icon(
                                                  bill.status ==
                                                          EBillStatus.paid.id
                                                      ? Icons.highlight_off
                                                      : Icons
                                                          .check_circle_outline,
                                                  color: Get.theme.colorScheme
                                                      .primary,
                                                ),
                                                onTap: () async {
                                                  await controller
                                                      .toogleBillStatus(bill);
                                                  await categoryController
                                                      .getBills();
                                                  Get.back();
                                                },
                                              ),
                                              ListTile(
                                                title: Text('edit'.tr),
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
                                                  await categoryController
                                                      .getBills();
                                                  await controller.loadMonth();
                                                },
                                              ),
                                              ListTile(
                                                title: Text('delete'.tr),
                                                leading: Icon(
                                                  Icons.delete,
                                                  color: Get.theme.colorScheme
                                                      .primary,
                                                ),
                                                onTap: () async {
                                                  Get.back();
                                                  Get.dialog(
                                                    ConfirmDialog(
                                                      icon: Icon(Icons.delete,
                                                          color: Get
                                                              .theme
                                                              .colorScheme
                                                              .primary),
                                                      body: 'wantDeleteBill'.tr,
                                                      onConfirm: () {
                                                        controller.deleteBill(
                                                            bill,
                                                            categoryController);
                                                      },
                                                    ),
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

  Widget _buildValueCard(
      {required String title,
      required num value,
      Color? color,
      required int position,
      required Size size}) {
    return Container(
      width: size.width,
      height: 230,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: color ?? Get.theme.colorScheme.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Container(
              height: size.height * .24,
              color: Colors.transparent,
              width: 30,
              child: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            onTap: () {
              controller.scrollValueCard(size.width, position, back: true);
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 32,
                  color: Get.theme.colorScheme.onPrimary,
                ),
              ),
              Text(
                AppHelpers.formatCurrency(value),
                style: const TextStyle(
                  fontSize: 42,
                ),
              ),
            ],
          ),
          GestureDetector(
            child: Container(
              color: Colors.transparent,
              height: size.height * .24,
              width: 30,
              child: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
            onTap: () {
              controller.scrollValueCard(size.width, position);
            },
          ),
        ],
      ),
    );
  }
}
