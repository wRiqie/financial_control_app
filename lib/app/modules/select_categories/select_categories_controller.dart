import 'package:financial_control_app/app/core/values/constants.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/data/repository/category_repository.dart';
import 'package:financial_control_app/app/data/services/snackbar_service.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SelectCategoriesController extends GetxController {
  final CategoryRepository repository;
  final SnackbarService snackService;
  final box = GetStorage(Constants.storageName);
  List<Category> categoryOptions = [];
  bool isLoading = false;

  SelectCategoriesController(this.repository, {required this.snackService});

  void getCategories() {
    isLoading = true;
    repository.getAllCategories().then((value) {
      categoryOptions = value;
      isLoading = false;
      update();
    });
  }

  void toogleCategory(Category category, bool value) {
    category.selected = value;
    update();
  }

  void confirm() async {
    final selectedCategories =
        categoryOptions.where((e) => e.selected).toList();

    if (selectedCategories.isEmpty) {
      snackService.showSnackbar(
        title: 'Atenção',
        subtitle: 'Selecione pelo menos uma categoria',
        backgroundColor: Get.theme.colorScheme.error,
        textColor: Get.theme.colorScheme.onError,
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
