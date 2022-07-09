import 'package:financial_control_app/app/data/enums/bill_status_enum.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/modules/home/widgets/category_item/category_item_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  CategoryItemController _controller = CategoryItemController(
    BillRepositoryMock(),
    Category(
      id: 1,
    ),
  );
  List<Bill> _bills = [
    Bill(
      id: '1',
      categoryId: 1,
      title: 'Teste 1',
      value: 100.00,
      dueDate: 10,
      status: EBillStatus.paid.id,
      date: '12-2022',
    ),
    Bill(
      id: '2',
      categoryId: 1,
      title: 'Teste 2',
      value: 100.00,
      dueDate: 10,
      status: EBillStatus.pendent.id,
      date: '12-2022',
    ),
    Bill(
      id: '3',
      categoryId: 1,
      title: 'Teste 3',
      value: 100.00,
      dueDate: 10,
      status: EBillStatus.overdue.id,
      date: '12-2022',
    ),
    Bill(
      id: '4',
      categoryId: 1,
      title: 'Teste 4',
      value: 100.00,
      dueDate: 10,
      status: EBillStatus.overdue.id,
      date: '12-2022',
    ),
  ];

  setUp(() {
    _controller.bills = _bills;
  });

  tearDown(() {
    _controller.dispose();
  });

  group('Price and Percentage |', () {
    test('deve calcular preço restante', () {
      var leftPrice = _controller.bills.leftPrice;
      expect(leftPrice, 300);
    });

    test('deve calcular preço total', () {
      var totalPrice = _controller.bills.totalPrice;
      expect(totalPrice, 400);
    });

    test('deve calcular porcentagem', () {
      var percentage = _controller.bills.percentage;
      expect(percentage, 0.25);
    });
  });
}
