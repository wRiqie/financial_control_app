import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/data/provider/database_provider.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:get/get.dart';

class BillService extends GetxService {
  final monthRepository = MonthRepository(DatabaseProvider.db);
  final repository = BillRepository(DatabaseProvider.db);
  DateTime selectedDate = DateTime.now();
  Month? selectedMonth;

  Future<Month> selectMonth() async {
    var month = await monthRepository.getMonthByDate(AppHelpers.formatDateToSave(selectedDate));
    if(month != null){
      selectedMonth = month;
    }
    var monthToAdd = Month(date: AppHelpers.formatDateToSave(selectedDate),);
    selectedMonth = monthToAdd;
    await monthRepository.saveMonth(monthToAdd);
    return monthToAdd;
  }

  Future<List<Bill>> getBills(int categoryId) {
    return repository.getBillsByCategoryIdAndDate(categoryId, AppHelpers.formatDateToSave(selectedDate));
  }

  Future<BillService> init() async {
    return this;
  }
}
