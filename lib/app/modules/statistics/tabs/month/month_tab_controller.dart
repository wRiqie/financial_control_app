import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/data/models/month_data.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:get/get.dart';

class MonthTabController extends GetxController {
  final MonthRepository repository;
  bool isLoading = false;
  Month? currentMonth;
  num totalPrice = 0;
  List<MonthData> datas = [];
  List<Month> months = [];

  MonthTabController(this.repository);

  void getLastMonths() {
    isLoading = true;
    repository.getLastMonths().then((value) {
      datas.clear();
      months = value;
      for (var month in value.reversed) {
        var monthNumber = AppHelpers.revertDateFromSave(month.date).month;
        var statisticData = MonthData(
          x: AppHelpers.monthResolver(monthNumber),
          y: (month.totalPrice ?? 0.0),
        );
        datas.add(statisticData);
      }
      currentMonth = months.first;
      setTotalPrice();
      isLoading = false;
      update();
    });
  }

  void setTotalPrice() {
    totalPrice = currentMonth?.totalPrice ?? 0;
  }

  bool get totalPriceDecreased {
    bool isFirstMonth = months.length <= 1;
    Month? previousMonth = isFirstMonth
        ? null
        : months[months.indexOf(currentMonth ?? Month(date: '')) + 1];
    if (previousMonth != null) {
      return (previousMonth.totalPrice ?? 0) > (currentMonth?.totalPrice ?? 0);
    }
    return false;
  }

  num get balanceDifferencePercentage {
    bool isFirstMonth = months.length <= 1;
    Month? previousMonth = isFirstMonth
        ? null
        : months[months.indexOf(currentMonth ?? Month(date: '')) + 1];
    if (previousMonth != null) {
      var difference =
          (currentMonth?.balance ?? 0) - (previousMonth.balance ?? 0);
      return (difference * 100) / (previousMonth.balance ?? 1);
    }
    return 0;
  }

  String get caption {
    bool isFirstMonth = months.length <= 1;
    Month? previousMonth = isFirstMonth
        ? null
        : months[months.indexOf(currentMonth ?? Month(date: '')) + 1];
    return (totalPriceDecreased ? 'youSaved'.tr : 'youSpent'.tr) +
        ' ' +
        (totalPriceDecreased
            ? AppHelpers.formatCurrency(
                (previousMonth?.totalPrice ?? 0) - totalPrice)
            : AppHelpers.formatCurrency(
                totalPrice - (previousMonth?.totalPrice ?? 0))) +
        ' ' +
        'comparedLastMonth'.tr;
  }

  @override
  void onInit() {
    super.onInit();
    getLastMonths();
  }
}
