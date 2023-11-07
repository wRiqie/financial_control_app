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
  final box = GetStorage(Constants.storageName);
  List<CategoryModel> categoryOptions = [];
  bool isLoading = false;

  SelectCategoriesController(this.repository);

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
