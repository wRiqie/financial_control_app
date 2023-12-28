import 'package:financial_control_app/app/core/mixin/validators_mixin.dart';
import 'package:financial_control_app/app/modules/travels/add_travel/add_travel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TravelTitleStep extends StatefulWidget {
  const TravelTitleStep({Key? key}) : super(key: key);

  @override
  State<TravelTitleStep> createState() => _TravelTitleStepState();
}

class _TravelTitleStepState extends State<TravelTitleStep>
    with ValidatorsMixin {
  final controller = Get.find<AddTravelController>();

  final formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();

  @override
  void dispose() {
    titleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _handleContinue,
        child: const Icon(Icons.arrow_forward),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Qual será a viagem?',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Digite abaixo um nome para sua viagem. ex: Viagem RJ 2023',
              style: TextStyle(color: Get.theme.colorScheme.onBackground),
            ),
            Form(
              key: formKey,
              child: TextFormField(
                controller: titleCtrl,
                validator: isNotEmpty,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleContinue() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    controller.setTitle(titleCtrl.text);
    controller.goToNextStep();
  }
}
