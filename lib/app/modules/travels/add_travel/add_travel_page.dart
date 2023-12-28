import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_travel_controller.dart';

class AddTravelPage extends GetView<AddTravelController> {
  const AddTravelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova viagem'),
      ),
      body: SafeArea(
        child: Obx(
          () => controller.steps[controller.currentStepIndex.value],
        ),
      ),
    );
  }
}
