import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/models/statistic_data.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:get/get.dart';

class StatisticsController extends GetxController {
  final MonthRepository repository;
  bool isLoading = false;
  List<StatisticData> datas = [];

  StatisticsController(this.repository);

  void getLastMonths() {
    isLoading = true;
    repository.getLastMonths().then((months) {
      datas.clear();
      for (var month in months.reversed) {
        var monthNumber = AppHelpers.revertDateFromSave(month.date).month;
        var statisticData = StatisticData(
          x: AppHelpers.monthResolver(monthNumber),
          y: (month.totalPrice ?? 0.0),
        );
        datas.add(statisticData);
      }
      isLoading = false;
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    getLastMonths();
  }
}
