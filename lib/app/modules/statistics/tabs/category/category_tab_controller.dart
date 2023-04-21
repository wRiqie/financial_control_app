import '../../../../core/utils/helpers.dart';
import '../../../../data/enums/category_enum.dart';
import '../../../../data/models/category_data.dart';
import '../../../../data/repository/bill_repository.dart';
import '../../../../data/repository/category_repository.dart';
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
    final categories = await categoryRepository.getSelectedCategories();
    for (var category in categories) {
      num totalValue = await billRepository.getBillsTotalPriceOfMonthCategory(
        category.id,
        AppHelpers.formatDateToSave(DateTime.now()),
      );
      categoriesToAdd.add(
        CategoryData(
          id: category.id,
          name: CategoryExtension.getById(category.id).name.tr,
          totalPrice: totalValue * 1,
          color: CategoryExtension.color(category.id),
        ),
      );
    }
    datas = categoriesToAdd;
    isLoading = false;
    update();
  }

  num calcPercent(num price) {
    num totalPrice = datas.map((e) => e.totalPrice).reduce((v, e) => v + e);
    return (price * 100) / (totalPrice > 0 ? totalPrice : 1);
  }

  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }
}
