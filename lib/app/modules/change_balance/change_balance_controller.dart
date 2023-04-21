import '../../core/utils/helpers.dart';
import '../../core/values/constants.dart';
import '../../data/models/month.dart';
import '../../data/repository/month_repository.dart';
import '../../routes/pages.dart';
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
        Get.toNamed(Routes.selectCategories);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    month = args?['month'];
    firstTime = args?['firstTime'];
    balanceController.text = AppHelpers.formatCurrency(month?.balance ?? 0);
  }
}
