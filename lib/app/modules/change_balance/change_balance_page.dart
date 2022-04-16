import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/core/values/images.dart';
import 'package:financial_control_app/app/modules/change_balance/change_balance_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChangeBalancePage extends GetView<ChangeBalanceController> {
  const ChangeBalancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          controller.month != null ? AppBar(title: Text('balance'.tr)) : null,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: controller.saveBalance,
                child: Text('concluded'.tr),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'enterBalanceOfMonth'.tr,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Get.theme.colorScheme.primary),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text('balance'.tr),
                TextFormField(
                  controller: controller.balanceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'enterMonthValue'.tr;
                    } else {
                      if (double.tryParse(value) == 0) {
                        return 'valueMonthCannotBeZero'.tr;
                      }
                      if (value == AppHelpers.formatCurrency(0)) {
                        return 'valueMonthCannotBeZero'.tr;
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'balanceOfMonthDescription'.tr,
                  style: const TextStyle(fontSize: 14, color: DarkColors.grey),
                ),
                const SizedBox(
                  height: 60,
                ),
                Opacity(
                  opacity: .65,
                  child: SvgPicture.asset(
                    AppImages.balance,
                    width: Get.size.width * .75,
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
