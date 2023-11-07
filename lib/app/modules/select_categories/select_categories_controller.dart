import 'package:financial_control_app/app/data/repository/bill_repository.dart';

import '../../core/values/constants.dart';
import '../../data/models/category_model.dart';
import '../../data/repository/category_repository.dart';
import '../../data/services/snackbar_service.dart';
import '../../routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SelectCategoriesController extends GetxController {
  final CategoryRepository repository;
  final BillRepository _billRepository;

  final box = GetStorage(Constants.storageName);
  List<CategoryModel> categoryOptions = [];
  bool isLoading = false;

  SelectCategoriesController(this.repository, this._billRepository);

  void getCategories() {
    isLoading = true;
    repository.getAllCategories().then((value) {
      categoryOptions = value;
      isLoading = false;
      update();
    });
  }

  void toogleCategory(CategoryModel category, bool value) {
    category.selected = value;
    update();
  }

  void editCategory(CategoryModel category) async {
    await Get.toNamed(Routes.addCategory, arguments: category);
    getCategories();
  }

  void deleteCategory(int id) async {
    isLoading = true;
    update();
    await repository.deleteCategory(id);
    await _billRepository.deleteBillsByCategoryId(id);
    isLoading = false;
    update();

    getCategories();
  }

  void confirm() async {
    final selectedCategories =
        categoryOptions.where((e) => e.selected).toList();

    if (selectedCategories.isEmpty) {
      ErrorSnackbar(
        title: 'Atenção',
        message: 'Selecione pelo menos uma categoria',
        icon: const Icon(Icons.error),
      );
      return;
    }

    await repository.saveCategories(categoryOptions);
    await box.write(Constants.firstTimeOpen, false);
    Get.offAllNamed(Routes.dashboard);
  }

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }
}
