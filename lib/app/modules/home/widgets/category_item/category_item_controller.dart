import 'package:financial_control_app/app/data/enums/bill_status.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/data/services/bill_service.dart';
import 'package:get/get.dart';

class CategoryItemController extends GetxController {
  List<Bill> bills = [];
  final Category category;
  final billService = Get.find<BillService>();
  final args = Get.arguments;

  CategoryItemController(this.category);

  double get percentage {
    var paidBills =
        bills.where((e) => e.status == BillStatus.paid.index).length;
    return (paidBills * 100) / (bills.isNotEmpty ? bills.length : 1);
  }

  double get leftPrice {
    var overdueBills = bills.where((e) => e.status == BillStatus.overdue.index);
    double price = 0;
    for (var bill in overdueBills) {
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
    billService.getBills(category.id).then((value) {
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
