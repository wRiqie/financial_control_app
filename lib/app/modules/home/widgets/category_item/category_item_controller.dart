import 'package:expandable/expandable.dart';
import 'package:get/get.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/models/bill.dart';
import '../../../../data/models/category.dart';
import '../../../../data/models/month.dart';
import '../../../../data/repository/bill_repository.dart';
import '../../home_controller.dart';

class CategoryItemController extends GetxController {
  final HomeController homeController;
  final BillRepository repository;
  final expandable = ExpandableController();
  final Month? month;
  List<Bill> bills = [];
  final Category category;
  final args = Get.arguments;

  CategoryItemController({
    required this.repository,
    required this.category,
    required this.homeController,
    this.month,
  });

  getBills() {
    repository
        .getBillsByCategoryIdAndDate(
      category.id,
      month?.date ?? AppHelpers.formatDateToSave(DateTime.now()),
    )
        .then((value) {
      bills = value;
      update();
    });
  }

  addBill(Bill bill) {
    bills.add(bill);
    update();
  }

  void toggleSelectedBill(Bill bill) => homeController.toggleSelectedBill(bill);

  void toggleSelectedBills() {
    for (var bill in bills) {
      toggleSelectedBill(bill);
    }
  }

  bool selected(Bill bill) => homeController.selectedBills.contains(bill);

  @override
  void onReady() {
    super.onReady();
    getBills();
  }
}
