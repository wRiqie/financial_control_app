import 'package:financial_control_app/app/data/enums/category_enum.dart';
import 'package:financial_control_app/app/data/models/category.dart';
import 'package:financial_control_app/app/modules/select_categories/select_categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCategoriesPage extends GetView<SelectCategoriesController> {
  const SelectCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione suas categorias'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          child: const Text('Confirmar'),
          onPressed: controller.confirm,
        ),
      ),
      body: SafeArea(
        child: GetBuilder<SelectCategoriesController>(
          builder: (_) => controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                child: Column(
                    children: controller.categoryOptions
                        .map((e) => categoryOption(e))
                        .toList(),
                  ),
              ),
        ),
      ),
    );
  }

  Widget categoryOption(Category category) {
    return CheckboxListTile(
      title: Text(CategoryExtension.getById(category.id).name.tr),
      secondary: Icon(
        CategoryExtension.icon(category.id),
        color: CategoryExtension.color(category.id),
      ),
      value: category.selected,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (value) {
        controller.toogleCategory(category, value ?? false);
      },
      activeColor: Get.theme.colorScheme.primary,
    );
  }
}
