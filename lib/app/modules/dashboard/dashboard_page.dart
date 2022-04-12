import 'package:financial_control_app/app/modules/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.changePage(index);
          },
          currentIndex: controller.index.value,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home, size: 28,), label: '', tooltip: 'home'.tr),
            BottomNavigationBarItem(
                icon: const Icon(Icons.trending_up, size: 28,), label: '', tooltip: 'statistics'.tr),
          ],
        ),
      ),
      body: Obx(
        () => controller.pages[controller.index.value],
      ),
    );
  }
}
