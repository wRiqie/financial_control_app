import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/category_model.dart';
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
              Get.toNamed(Routes.addCategory)?.then((value) {
                controller.getCategories();
              });
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
              // : SingleChildScrollView(
              //     child: Column(
              //       children: controller.categoryOptions
              //           .map((e) => categoryOption(e))
              //           .toList(),
              //     ),
              //   ),
              : ReorderableListView.builder(
                  itemCount: controller.categoryOptions.length,
                  onReorder: (oldIndex, newIndex) {
                    if (kDebugMode) {
                      print(newIndex);
                    }
                  },
                  itemBuilder: (context, index) {
                    var category = controller.categoryOptions[index];
                    return categoryOption(Key('$index'), category);
                  },
                ),
        ),
      ),
    );
  }

  Widget categoryOption(Key key, CategoryModel category) {
    return CheckboxListTile(
      key: key,
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
