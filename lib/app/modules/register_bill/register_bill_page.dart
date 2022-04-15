import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/modules/register_bill/register_bill_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterBillPage extends GetView<RegisterBillController> {
  const RegisterBillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterBillController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(
            'registerABill'.tr,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                controller.categoryIcon,
                color: Get.theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    controller.saveBill();
                  },
                  child: Text('concluded'.tr),
                ),
              ),
              controller.editingBill == null
                  ? const SizedBox(
                      height: 20,
                    )
                  : Container(),
              controller.editingBill == null
                  ? Container(
                      color: Colors.transparent,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.saveBill(add: true);
                        },
                        child: Text(
                          'addOtherBill'.tr,
                          style:
                              TextStyle(color: Get.theme.colorScheme.primary),
                        ),
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(
                              width: 3, color: Get.theme.colorScheme.primary)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          elevation: MaterialStateProperty.all(0),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextFormField(
                        controller: controller.titleController,
                        keyboardType: TextInputType.name,
                        label: 'title'.tr,
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'enterATitle'.tr;
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTextFormField(
                        controller: controller.totalValueController,
                        label: 'monthValue'.tr,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'enterAMonthValue'.tr;
                          } else if (value == AppHelpers.formatCurrency(0)) {
                            return 'valueMonthCannotBeZero'.tr;
                          }

                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTextFormField(
                        controller: controller.dueDateController,
                        label: 'dueDate'.tr,
                        validator: (value) {
                          if (value != null) {
                            var toInt = int.tryParse(value);
                            if (toInt == null) {
                              return 'enterAValidDueDate'.tr;
                            } else if (toInt > 31 || toInt < 1) {
                              return 'enterAValidDueDate'.tr;
                            }
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTextFormField(
                        controller: controller.portionController,
                        label: 'currentPortion'.tr,
                        enabled: controller.havePortions,
                        validator: (value) {
                          if (!controller.havePortions) {
                            return null;
                          }
                          if (value != null) {
                            var toInt = int.tryParse(value);
                            if (toInt == null) {
                              return 'enterAValidPortion'.tr;
                            } else {
                              var toIntMaxPortion = int.tryParse(
                                  controller.maxPortionController.text);
                              if (toIntMaxPortion != null &&
                                  toIntMaxPortion < toInt) {
                                return 'currentPortionCannotBeGreaterThanTotal'
                                    .tr;
                              } else if (toInt < 1) {
                                return 'enterAValidPortion'.tr;
                              }
                            }
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTextFormField(
                        controller: controller.maxPortionController,
                        label: 'quantityOfParcels'.tr,
                        enabled: controller.havePortions,
                        validator: (value) {
                          if (!controller.havePortions) {
                            return null;
                          }
                          if (value != null) {
                            var toInt = int.tryParse(value);
                            if (toInt == null) {
                              return 'enterAValidTotalPortion'.tr;
                            } else {
                              var toIntPortion = int.tryParse(
                                  controller.portionController.text);
                              if (toIntPortion != null &&
                                  toIntPortion > toInt) {
                                return 'currentPortionCannotBeGreaterThanTotal'
                                    .tr;
                              } else if (toInt < 1) {
                                return 'enterAValidTotalPortion'.tr;
                              }
                            }
                          }
                          return null;
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCheckboxOption(
                          toogle: controller.togglePaid,
                          label: 'alreadyPaid'.tr,
                          value: controller.paid,
                        ),
                        _buildCheckboxOption(
                          toogle: controller.togglePortion,
                          label: 'haveParcels'.tr,
                          value: controller.havePortions,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    List<TextInputFormatter>? inputFormatters,
    TextInputType keyboardType = TextInputType.number,
    bool enabled = true,
    String? Function(String? value)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        label: Text(label),
      ),
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }

  Widget _buildCheckboxOption(
      {required Function(bool? value) toogle,
      required String label,
      required bool value}) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (value) {
            toogle(value);
          },
        ),
        Text(
          label,
          style: TextStyle(
            color: Get.theme.colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}
