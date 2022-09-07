import 'package:financial_control_app/app/data/enums/bill_status_enum.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/modules/home/home_controller.dart';
import 'package:financial_control_app/app/modules/home/widgets/category_item/category_item_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks/mocks.dart';

void main() {
  late CategoryItemController controller;

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
    controller = CategoryItemController(
      homeController: HomeController(
        CategoryRepositoryMock(),
        MonthRepositoryMock(),
        BillRepositoryMock(),
      ),
      repository: BillRepositoryMock(),
      category: Category(
        id: 1,
      ),
      month: null,
    );

    controller.bills = _bills;
  });

  tearDown(() {
    controller.dispose();
  });

  group('Price and Percentage |', () {
    test('deve calcular preço restante', () {
      var leftPrice = controller.bills.leftPrice;
      expect(leftPrice, 300);
    });

    test('deve calcular preço total', () {
      var totalPrice = controller.bills.totalPrice;
      expect(totalPrice, 400);
    });

    test('deve calcular porcentagem', () {
      var percentage = controller.bills.percentage;
      expect(percentage, 0.25);
    });
  });

  group('Bills management', () {
    test('deve adicionar conta a lista de contas', () {
      controller.bills.clear();
      final fakeBill = Bill(
        id: '',
        categoryId: 1,
        title: '',
        value: 20,
        dueDate: 10,
        status: 1,
        date: '',
      );
      when(() =>
              controller.repository.getBillsByCategoryIdAndDate(any(), any()))
          .thenAnswer(
        (_) async => [fakeBill],
      );
      controller.getBills();

      expect(controller.bills.length, 1);
      expect(controller.bills.totalPrice, 20);
      expect(controller.bills.leftPrice, 20);
      expect(controller.bills.percentage, 0);
    });
  });
}
