import 'package:financial_control_app/app/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'travels_controller.dart';

class TravelsPage extends GetView<TravelsController> {
  const TravelsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viagens'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.addTravel);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            children: [],
          ),
        ),
      )),
    );
  }
}
