import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:financial_control_app/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){}),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppHelpers.monthResolver(DateTime.now().month),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height * .35,
                color: Get.theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
