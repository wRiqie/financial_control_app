import 'package:financial_control_app/app/data/models/statistic_data.dart';
import 'package:get/get.dart';

class StatisticsController extends GetxController {
  List<StatisticData> datas = [
    StatisticData(x: 'Jul', y: 90),
    StatisticData(x: 'Aug', y: 10),
    StatisticData(x: 'Sep', y: 30),
    StatisticData(x: 'Oct', y: 20),
    StatisticData(x: 'Nov', y: 50),
    StatisticData(x: 'Dez', y: 60),
  ];
}