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
          title: const Text(
            'Register a Bill',
          ),
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
                  onPressed: () {},
                  child: const Text('Concluded'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.transparent,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.addBill,
                  child: Text(
                    'Add other bill',
                    style: TextStyle(color: Get.theme.colorScheme.primary),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(BorderSide(
                        width: 3, color: Get.theme.colorScheme.primary)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0),
                  ),
                ),
              ),
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
                        label: 'Title',
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'Please enter a title';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTextFormField(
                        controller: controller.totalValueController,
                        label: 'Total value',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter(),
                        ],
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'Please enter a total value';
                          }

                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTextFormField(
                        controller: controller.dueDateController,
                        label: 'Due date',
                        validator: (value) {
                          if (value != null) {
                            var toInt = int.tryParse(value);
                            if (toInt == null) {
                              return 'Please enter a valid due date';
                            } else if (toInt > 31 || toInt < 1) {
                              return 'Please enter a valid due date';
                            }
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTextFormField(
                        controller: controller.portionController,
                        label: 'Current portion',
                        enabled: controller.havePortions,
                        validator: (value) {
                          if (!controller.havePortions) {
                            return null;
                          }
                          if (value != null) {
                            var toInt = int.tryParse(value);
                            if (toInt == null) {
                              return 'Please enter a valid portion';
                            } else {
                              var toIntMaxPortion = int.tryParse(
                                  controller.maxPortionController.text);
                              if (toIntMaxPortion != null &&
                                  toIntMaxPortion < toInt) {
                                return 'Current portion cannot be greater than total';
                              } else if (toInt < 1) {
                                return 'Please enter a valid portion';
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
                        label: 'Quantity of parcels',
                        enabled: controller.havePortions,
                        validator: (value) {
                          if (!controller.havePortions) {
                            return null;
                          }
                          if (value != null) {
                            var toInt = int.tryParse(value);
                            if (toInt == null) {
                              return 'Please enter a valid total portion';
                            } else {
                              var toIntPortion = int.tryParse(
                                  controller.portionController.text);
                              if (toIntPortion != null &&
                                  toIntPortion > toInt) {
                                return 'Current portion cannot be greater than total';
                              } else if (toInt < 1) {
                                return 'Please enter a valid total portion';
                              }
                            }
                          }
                          return null;
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                          value: controller.havePortions,
                          onChanged: (value) {
                            controller.togglePortion(value);
                          },
                        ),
                        Text(
                          'Do you have parcels',
                          style: TextStyle(
                            color: Get.theme.colorScheme.onBackground,
                          ),
                        )
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
      decoration: InputDecoration(
        label: Text(label),
      ),
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }
}
