import 'package:financial_control_app/app/routes/pages.dart';

import '../../data/models/category.dart';
import 'select_categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCategoriesPage extends GetView<SelectCategoriesController> {
  const SelectCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione suas categorias'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.addCategory);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            child: const Text('Confirmar'),
            onPressed: controller.confirm,
          ),
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
      title: Text(category.translateName?.tr ?? category.name),
      secondary: Icon(
        category.icon,
        color: Color(category.color),
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
