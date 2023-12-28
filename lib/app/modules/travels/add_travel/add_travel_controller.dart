import 'package:financial_control_app/app/data/models/travel_model.dart';
import 'package:financial_control_app/app/modules/travels/add_travel/steps/travel_days_value_step.dart';
import 'package:financial_control_app/app/modules/travels/add_travel/steps/travel_title_step.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddTravelController extends GetxController {
  late TravelModel travel;

  List<Widget> steps = [
    const TravelTitleStep(),
    const TravelDaysValueStep(),
  ];

  final currentStepIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTravel();
  }

  void _loadTravel() {
    travel = TravelModel(id: const Uuid().v4());
  }

  void setTitle(String title) {
    travel.title = title;
  }

  void setDays(int days) {
    travel.totalDays = days;
  }

  void setTotalValue(num value) {
    travel.totalValue = value;
  }

  void goToNextStep() {
    if (currentStepIndex.value < (steps.length - 1)) {
      currentStepIndex.value++;
    } else {
      print(travel);
      Get.back();
    }
  }
}
