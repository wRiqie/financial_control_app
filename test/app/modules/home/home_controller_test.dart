import 'package:financial_control_app/app/data/enums/bill_status.dart';
import 'package:financial_control_app/app/data/models/bill.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:financial_control_app/app/modules/home/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MonthRepositoryMock extends Mock implements MonthRepository {}

class BillRepositoryMock extends Mock implements BillRepository {}

void main() {
  late HomeController controller;
  setUp(() {
    controller = HomeController(MonthRepositoryMock(), BillRepositoryMock());
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
            status: BillStatus.paid.index,
            date: ''),
        Bill(
            id: '',
            categoryId: 1,
            title: '',
            value: 10,
            dueDate: 100,
            portion: 3,
            maxPortion: 3,
            status: BillStatus.paid.index,
            date: ''),
      ];
      when(() => controller.billRepository.getBillsByDate(any()))
          .thenAnswer((_) async => bills);
      when(() => controller.billRepository.saveAllBills(any()))
          .thenAnswer((_) async {});

      List<Bill> savedBills =
          await controller.loadAndCopyPreviousMonthBills(copy: true);

      expect(savedBills.length, 1);
      expect(savedBills[0].status, BillStatus.pendent.index);
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
            status: BillStatus.paid.index,
            date: ''),
        Bill(
            id: '',
            categoryId: 1,
            title: '',
            value: 10,
            dueDate: 100,
            portion: 3,
            maxPortion: 3,
            status: BillStatus.paid.index,
            date: ''),
        Bill(
            id: '',
            categoryId: 1,
            title: '',
            value: 10,
            dueDate: 100,
            portion: 1,
            maxPortion: 3,
            status: BillStatus.paid.index,
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
      expect(savedBills[0].status, BillStatus.pendent.index);
    });
  });

  test('Deve retornar o mês anterior', (){
    controller.selectedDate = DateTime(2022, 2, 1);
    expect(controller.previousMonthDate, '1-2022');

    controller.selectedDate = DateTime(2022, 1, 1);
    expect(controller.previousMonthDate, '12-2021');
  });
}
