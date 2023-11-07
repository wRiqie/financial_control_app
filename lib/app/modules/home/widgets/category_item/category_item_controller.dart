import 'package:expandable/expandable.dart';
import 'package:get/get.dart';

import '../../../../core/utils/helpers.dart';
import '../../../../data/models/bill_model.dart';
import '../../../../data/models/category_model.dart';
import '../../../../data/models/month_model.dart';
import '../../../../data/repository/bill_repository.dart';
import '../../home_controller.dart';

class CategoryItemController extends GetxController {
  final HomeController homeController;
  final BillRepository repository;
  final expandable = ExpandableController();
  final MonthModel? month;
  List<BillModel> bills = [];
  final CategoryModel category;
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
      category.id ?? -1,
      month?.date ?? AppHelpers.formatDateToSave(DateTime.now()),
    )
        .then((value) {
      bills = value;
      update();
    });
  }

  addBill(BillModel bill) {
    bills.add(bill);
    update();
  }

  void toggleSelectedBill(BillModel bill) =>
      homeController.toggleSelectedBill(bill);

  void toggleSelectedBills() {
    for (var bill in bills) {
      toggleSelectedBill(bill);
    }
  }

  bool selected(BillModel bill) => homeController.selectedBills.contains(bill);

  @override
  void onReady() {
    super.onReady();
    getBills();
  }
}
