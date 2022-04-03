import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/modules/change_balance/change_balance_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChangeBalancePage extends GetView<ChangeBalanceController> {
  const ChangeBalancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: controller.month != null
          ? AppBar(title: const Text('Balance'))
          : null,
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
                child: const Text('Concluded'),
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
                  'Please\nEnter a balance of the month',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Get.theme.colorScheme.primary),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text('Balance'),
                TextFormField(
                  controller: controller.balanceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Please enter a month value';
                    } else if (value == AppHelpers.formatCurrency(0)) {
                      return 'The value of the month cannot be zero';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Balance of the month would be the budget available for the month\'s bills',
                  style: TextStyle(
                    fontSize: 14,
                    color: DarkColors.grey
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
