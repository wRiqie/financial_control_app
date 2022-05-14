import 'package:financial_control_app/app/data/enums/bill_status_enum.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/modules/home/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late HomeController controller;
  setUp(() {
    controller = HomeController(
      CategoryRepositoryMock(),
      MonthRepositoryMock(),
      BillRepositoryMock(),
    );
  });
  tearDown(() {
    controller.dispose();
  });

  group('Previous month bills |', () {
    test('deve carregar todas as contas do mês passado', (() async {
      List<Bill> bills = [
        Bill(
            id: '',
            categoryId: 1,
            title: '',
            value: 10,
            dueDate: 100,
            status: EBillStatus.paid.id,
            date: ''),
        Bill(
            id: '',
            categoryId: 1,
            title: '',
            value: 10,
            dueDate: 100,
            portion: 3,
            maxPortion: 3,
            status: EBillStatus.paid.id,
            date: ''),
      ];
      when(() => controller.billRepository.getBillsByDate(any()))
          .thenAnswer((_) async => bills);
      when(() => controller.billRepository.saveAllBills(any()))
          .thenAnswer((_) async {});

      List<Bill> savedBills =
          await controller.loadAndCopyPreviousMonthBills(copy: true);

      expect(savedBills.length, 1);
      expect(savedBills[0].status, EBillStatus.pendent.id);
      expect(savedBills[0].portion, null);
    }));

    test('deve carregar contas parceladas do mês passado', () async {
      List<Bill> bills = [
        Bill(
            id: '',
            categoryId: 1,
            title: '',
            value: 10,
            dueDate: 100,
            status: EBillStatus.paid.id,
            date: ''),
        Bill(
            id: '',
            categoryId: 1,
            title: '',
            value: 10,
            dueDate: 100,
            portion: 3,
            maxPortion: 3,
            status: EBillStatus.paid.id,
            date: ''),
        Bill(
            id: '',
            categoryId: 1,
            title: '',
            value: 10,
            dueDate: 100,
            portion: 1,
            maxPortion: 3,
            status: EBillStatus.paid.id,
            date: ''),
      ];
      when(() => controller.billRepository.getBillsByDate(any()))
          .thenAnswer((_) async => bills);
      when(() => controller.billRepository.saveAllBills(any()))
          .thenAnswer((_) async {});

      List<Bill> savedBills =
          await controller.loadAndCopyPreviousMonthBills(copy: false);

      expect(savedBills.length, 1);
      expect(savedBills[0].portion, 2);
      expect(savedBills[0].maxPortion, 3);
      expect(savedBills[0].status, EBillStatus.pendent.id);
    });
  });

  test('Deve retornar o mês anterior', () {
    controller.selectedDate = DateTime(2022, 2, 1);
    expect(controller.previousMonthDate, '01-2022');

    controller.selectedDate = DateTime(2022, 1, 1);
    expect(controller.previousMonthDate, '12-2021');
  });
}
