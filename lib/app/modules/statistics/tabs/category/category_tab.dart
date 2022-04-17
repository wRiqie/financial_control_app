import 'package:financial_control_app/app/modules/statistics/tabs/category/category_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTabPage extends GetView<CategoryTabController> {
  const CategoryTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CategoryTabController>(
        init: CategoryTabController(),
        builder: (_) {
          return Column(
            children: const [],
          );
        },
      ),
    );
  }
}
