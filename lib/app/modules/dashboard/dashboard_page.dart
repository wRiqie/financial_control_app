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
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 28,), label: '', tooltip: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up, size: 28,), label: '', tooltip: 'Statistics'),
          ],
        ),
      ),
      body: Obx(
        () => controller.pages[controller.index.value],
      ),
    );
  }
}
