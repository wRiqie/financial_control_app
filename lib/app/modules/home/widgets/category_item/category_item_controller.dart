import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/enums/bill_status_enum.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:get/get.dart';

class CategoryItemController extends GetxController {
  final BillRepository repository;
  List<Bill> bills = [];
  final Category category;
  final args = Get.arguments;

  CategoryItemController(this.repository, this.category);

  double get percentage {
    double paidValue = 0;
    double totalValue = totalPrice;
    var paidBills = bills.where((e) => e.status == EBillStatus.paid.id);
    for (var paidBill in paidBills) {
      paidValue += paidBill.value;
    }

    return ((paidValue * 100) / (totalValue != 0 ? totalValue : 1)) / 100;
  }

  double get leftPrice {
    var leftBills = bills.where((e) => e.status != EBillStatus.paid.id);
    double price = 0;
    for (var bill in leftBills) {
      price += bill.value;
    }
    return price;
  }

  double get totalPrice {
    double price = 0;
    for (var bill in bills) {
      price += bill.value;
    }
    return price;
  }

  getBills() {
    repository
        .getBillsByCategoryIdAndDate(
      category.id,
      AppHelpers.formatDateToSave(DateTime.now()),
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

  @override
  void onReady() {
    super.onReady();
    getBills();
  }
}
