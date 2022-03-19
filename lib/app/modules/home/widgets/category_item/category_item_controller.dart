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
        dueDate: DateTime.now().add(const Duration(days: 20),),
        status: BillStatus.pendent.index,
      ),
    ]);
  }

  @override
  void onInit() {
    super.onInit();
    getBills();
  }
}
