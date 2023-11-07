import 'package:financial_control_app/app/data/services/snackbar_service.dart';

import '../../core/theme/dark/dark_colors.dart';
import '../../core/utils/helpers.dart';
import '../../data/enums/bill_status_enum.dart';
import '../../data/models/bill_model.dart';
import '../../global/widgets/confirm_dialog.dart';
import 'home_controller.dart';
import 'widgets/category_item/category_item.dart';
import '../../routes/pages.dart';
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
          title: controller.selectedBills.isEmpty
              ? controller.selectedMonth != null
                  ? InkWell(
                      onTap: () {
                        // controller.swapDate(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(AppHelpers.monthResolver(
                                controller.selectedDate.month) +
                            ' - ${controller.selectedDate.year}'),
                      ),
                    )
                  : Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${controller.selectedBills.length} Selecionado(s)',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      AppHelpers.formatCurrency(
                          controller.selectedBills.totalPrice),
                      style: const TextStyle(
                        fontSize: 12,
                        color: DarkColors.grey,
                      ),
                    ),
                  ],
                ),
          centerTitle: controller.selectedBills.isEmpty,
          actions: controller.selectedBills.isEmpty
              ? [
                  IconButton(
                    onPressed: controller.openPreferences,
                    icon: const Icon(Icons.more_vert),
                  ),
                ]
              : [
                  IconButton(
                    onPressed: () {
                      Get.dialog(
                        ConfirmDialog(
                          icon: Icon(
                            Icons.delete,
                            size: 26,
                            color: Get.theme.colorScheme.primary,
                          ),
                          body:
                              'Tem certeza que deseja deletar as contas selecionadas?',
                          onConfirm: controller.deleteBills,
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: controller.clearSelectedBills,
                    icon: const Icon(Icons.clear),
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
                          color: controller.remainingBalance < 0
                              ? Get.theme.colorScheme.error
                              : null),
                      _buildValueCard(
                        title: 'totalUnpaid'.tr,
                        value: controller.selectedMonth?.totalUnpaid ?? 0,
                        position: 1,
                        size: size,
                        color: const Color.fromARGB(255, 87, 131, 206),
                      ),
                      _buildValueCard(
                        title: 'balanceOfMonth'.tr,
                        value: controller.selectedMonth?.balance ?? 0,
                        position: 2,
                        size: size,
                        color: Get.theme.colorScheme.secondary,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'billsOfMonth'.tr,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          DropdownButton<String>(
                            underline: Container(),
                            icon: const Icon(Icons.expand_more),
                            value: 'showAll',
                            items: const [
                              DropdownMenuItem(
                                value: 'showAll',
                                child: Text('Exibir tudo'),
                              ),
                              DropdownMenuItem(
                                value: 'unpaid',
                                child: Text('Não pagas'),
                              ),
                            ],
                            onChanged: (value) {},
                          )
                        ],
                      ),
                      ...controller.categories
                          .map((e) => CategoryItem(
                              onTap: (bill, categoryController) {
                                controller.clearSelectedBills();
                                return showModalBottomSheet(
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
                                              bill.status == EBillStatus.paid.id
                                                  ? Icons.highlight_off
                                                  : Icons.check_circle_outline,
                                              color:
                                                  Get.theme.colorScheme.primary,
                                            ),
                                            onTap: () async {
                                              await controller
                                                  .toggleBillStatus(bill);
                                              await categoryController
                                                  .getBills();
                                              Get.back();
                                            },
                                          ),
                                          ListTile(
                                            title: Text('edit'.tr),
                                            leading: Icon(
                                              Icons.edit,
                                              color:
                                                  Get.theme.colorScheme.primary,
                                            ),
                                            onTap: () async {
                                              Get.back();
                                              await Get.toNamed(
                                                  Routes.registerBill,
                                                  arguments: {
                                                    'categoryId':
                                                        bill.categoryId,
                                                    'bill': bill,
                                                    'selectedMonth': controller
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
                                              color:
                                                  Get.theme.colorScheme.primary,
                                            ),
                                            onTap: () async {
                                              Get.back();
                                              Get.dialog(
                                                ConfirmDialog(
                                                  icon: Icon(Icons.delete,
                                                      color: Get.theme
                                                          .colorScheme.primary),
                                                  body: 'wantDeleteBill'.tr,
                                                  onConfirm: () {
                                                    controller.deleteBill(bill,
                                                        categoryController);
                                                  },
                                                ),
                                              );
                                              // await controller.selectMonth();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              category: e,
                              addBillToCategory: controller.addBillToCategory,
                              month: controller.selectedMonth))
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
                  fontSize: 28,
                  color: Get.theme.colorScheme.onPrimary,
                ),
              ),
              Row(
                children: [
                  controller.isValuesVisible
                      ? Text(
                          AppHelpers.formatCurrency(value),
                          style: const TextStyle(
                            fontSize: 38,
                          ),
                        )
                      : Container(
                          color: Colors.white,
                          width: Get.size.width * .3,
                          height: 1,
                        ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: controller.toggleValuesVisibility,
                      child: controller.isValuesVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  )
                ],
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
