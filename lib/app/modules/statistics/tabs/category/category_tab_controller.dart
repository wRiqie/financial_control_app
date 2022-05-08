import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/data/enums/category_enum.dart';
import 'package:financial_control_app/app/data/models/category_data.dart';
import 'package:financial_control_app/app/data/repository/bill_repository.dart';
import 'package:financial_control_app/app/data/repository/category_repository.dart';
import 'package:get/get.dart';

class CategoryTabController extends GetxController {
  final BillRepository billRepository;
  final CategoryRepository categoryRepository;
  bool isLoading = false;
  List<CategoryData> datas = [];

  CategoryTabController(this.billRepository, this.categoryRepository);

  void loadDatas() async {
    isLoading = true;
    List<CategoryData> categoriesToAdd = [];
    await Future.forEach<ECategory>(ECategory.values, (category) async {
      num totalValue = await billRepository.getBillsTotalPriceOfMonthCategory(
        category.id,
        AppHelpers.formatDateToSave(DateTime.now()),
      );
      categoriesToAdd.add(
        CategoryData(
          x: AppHelpers.categoryResolver(category.id),
          y: totalValue * 1,
          color: CategoryExtension.color(category.id),
        ),
      );
    });
    datas = categoriesToAdd;
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }
}
