import 'package:financial_control_app/app/data/models/month.dart';
import 'package:financial_control_app/app/modules/statistics/tabs/month/month_tab_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  late MonthTabController controller;
  setUp(() {
    controller = MonthTabController(MonthRepositoryMock());
  });

  tearDown(() {
    controller.dispose();
  });

  group('Total price decreased |', () {
    test('deve retornar true', () {
      controller.lastMonth = Month(date: '10-3', totalPrice: 200);
      controller.months = [
        controller.lastMonth!,
        Month(date: '10-2', totalPrice: 300),
      ];

      expect(controller.totalPriceDecreased, true);
    });

    test('deve retornar false', () {
      controller.lastMonth = Month(date: '10-2', totalPrice: 300);
      controller.months = [
        Month(date: '10-3', totalPrice: 300),
        Month(date: '10-2', totalPrice: 300),
      ];

      expect(controller.totalPriceDecreased, false);
    });
  });

  test('deve retornar diferença de saldo em porcentagem', () {
    controller.lastMonth = Month(date: '10-3', balance: 110);
    controller.months = [
      controller.lastMonth!,
      Month(date: '10-2', balance: 100),
    ];

    expect(controller.balanceDifferencePercentage, 10);
  });
}
