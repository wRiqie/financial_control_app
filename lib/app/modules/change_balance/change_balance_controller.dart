import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeBalanceController extends GetxController {
  final MonthRepository repository;
  final args = Get.arguments;
  final formKey = GlobalKey<FormState>();
  final balanceController = TextEditingController();
  Month? month;

  ChangeBalanceController(this.repository);

  saveBalance() async {
    if (formKey.currentState!.validate()) {
      if (month != null) {
        month!.balance =
            AppHelpers.revertCurrencyFormat(balanceController.text);
        await repository.saveMonth(month!);
        Get.back();
      } else {
        var monthToAdd = Month(
          date: AppHelpers.formatDateToSave(DateTime.now()),
          balance: AppHelpers.revertCurrencyFormat(balanceController.text),
        );
        await repository.saveMonth(monthToAdd);
        Get.offAllNamed(Routes.dashboard);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    month = args['month'];
    if (month != null) {
      balanceController.text = AppHelpers.formatCurrency(month!.balance ?? 0);
    }
  }
}
