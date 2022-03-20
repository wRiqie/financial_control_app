import 'package:financial_control_app/app/data/enums/bill_status.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:get/get.dart';

class CategoryItemController extends GetxController {
  List<Bill> bills = [];

  void getBills() {
    bills.addAll([
      Bill(
        id: '1',
        title: 'Notebook',
        value: 100,
        portion: 9,
        maxPortion: 10,
        dueDate: 19,
        status: BillStatus.pendent.index,
        categoryId: 5
      ),
      Bill(
        id: '2',
        title: 'Carteira de motorista',
        value: 500,
        portion: 4,
        maxPortion: 5,
        dueDate: 5,
        status: BillStatus.paid.index,
        categoryId: 5
      ),
    ]);
  }

  @override
  void onInit() {
    super.onInit();
    getBills();
  }
}
