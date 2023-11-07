import '../../../../core/utils/helpers.dart';
import '../../../../data/models/month_model.dart';
import '../../../../data/models/month_data_model.dart';
import '../../../../data/repository/month_repository.dart';
import 'package:get/get.dart';

class MonthTabController extends GetxController {
  final MonthRepository repository;
  bool isLoading = false;
  MonthModel? currentMonth;
  num totalPrice = 0;
  List<MonthDataModel> datas = [];
  List<MonthModel> months = [];

  MonthTabController(this.repository);

  void getLastMonths() {
    isLoading = true;
    repository.getLastMonths().then((value) {
      datas.clear();
      months = value;
      for (var month in value.reversed) {
        var monthNumber = AppHelpers.revertDateFromSave(month.date).month;
        var statisticData = MonthDataModel(
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
    MonthModel? previousMonth = isFirstMonth
        ? null
        : months[months.indexOf(currentMonth ?? MonthModel(date: '')) + 1];
    if (previousMonth != null) {
      return (previousMonth.totalPrice ?? 0) > (currentMonth?.totalPrice ?? 0);
    }
    return false;
  }

  num get balanceDifferencePercentage {
    bool isFirstMonth = months.length <= 1;
    MonthModel? previousMonth = isFirstMonth
        ? null
        : months[months.indexOf(currentMonth ?? MonthModel(date: '')) + 1];
    if (previousMonth != null) {
      var difference =
          (currentMonth?.balance ?? 0) - (previousMonth.balance ?? 0);
      return (difference * 100) / (previousMonth.balance ?? 1);
    }
    return 0;
  }

  String get caption {
    bool isFirstMonth = months.length <= 1;
    MonthModel? previousMonth = isFirstMonth
        ? null
        : months[months.indexOf(currentMonth ?? MonthModel(date: '')) + 1];
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
