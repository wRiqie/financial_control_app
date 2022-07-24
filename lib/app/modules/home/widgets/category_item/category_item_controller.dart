import 'package:expandable/expandable.dart';
import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/modules/home/home_controller.dart';
import 'package:get/get.dart';

class CategoryItemController extends GetxController {
  final homeController = Get.find<HomeController>();
  final BillRepository repository;
  final expandable = ExpandableController();
  final Month? month;
  List<Bill> bills = [];
  final Category category;
  final args = Get.arguments;

  CategoryItemController(this.repository, this.category, this.month);

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
