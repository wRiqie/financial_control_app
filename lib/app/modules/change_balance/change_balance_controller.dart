import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/core/values/contants.dart';
import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChangeBalanceController extends GetxController {
  final MonthRepository repository;
  final box = GetStorage(Constants.storageName);
  final args = Get.arguments;
  final formKey = GlobalKey<FormState>();
  final balanceController = TextEditingController();
  Month? month;
  bool? firstTime;

  ChangeBalanceController(this.repository);

  saveBalance() async {
    if (formKey.currentState!.validate()) {
      if(firstTime != null && firstTime!) {
        Get.toNamed(Routes.selectCategories);
        return;
      }

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
        box.write(Constants.firstTimeOpen, false);
        Get.offAllNamed(Routes.dashboard);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    month = args?['month'];
    firstTime = args?['firstTime'];
    if (month != null) {
      balanceController.text = AppHelpers.formatCurrency(month!.balance ?? 0);
    } else {
      balanceController.text = AppHelpers.formatCurrency(0);
    }
  }
}
