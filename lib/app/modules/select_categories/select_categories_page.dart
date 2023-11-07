import 'package:financial_control_app/app/core/utils/dialog_helper.dart';
import 'package:financial_control_app/app/data/services/snackbar_service.dart';
import 'package:financial_control_app/app/modules/select_categories/widget/category_tile_widget.dart';
import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
              : SingleChildScrollView(
                  child: Column(
                    children: controller.categoryOptions
                        .map(
                          (e) => CategoryTileWidget(
                            category: e,
                            onEdit: () => controller.editCategory(e),
                            onDelete: () =>
                                controller.deleteCategory(context, e.id ?? 0),
                            toggleSelected: (value) =>
                                controller.toogleCategory(e, value ?? false),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
      ),
    );
  }
}
