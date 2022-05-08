import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/data/repository/category_repository.dart';
import 'package:financial_control_app/app/data/repository/month_repository.dart';
import 'package:mocktail/mocktail.dart';

class CategoryRepositoryMock extends Mock implements CategoryRepository {}

class MonthRepositoryMock extends Mock implements MonthRepository {}

class BillRepositoryMock extends Mock implements BillRepository {}