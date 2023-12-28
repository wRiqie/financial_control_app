import 'package:financial_control_app/app/core/mixin/validators_mixin.dart';
import 'package:financial_control_app/app/core/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../add_travel_controller.dart';

class TravelDaysValueStep extends StatefulWidget {
  const TravelDaysValueStep({Key? key}) : super(key: key);

  @override
  State<TravelDaysValueStep> createState() => _TravelDaysValueStepState();
}

class _TravelDaysValueStepState extends State<TravelDaysValueStep>
    with ValidatorsMixin {
  final controller = Get.find<AddTravelController>();

  final formKey = GlobalKey<FormState>();
  final daysCtrl = TextEditingController();
  final moneyController = TextEditingController();

  @override
  void dispose() {
    daysCtrl.dispose();
    moneyController.dispose();
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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quantos dias a viagem terá?',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Digite abaixo a quantidade dias que a viagem irá durar',
                style: TextStyle(color: Get.theme.colorScheme.onBackground),
              ),
              TextFormField(
                validator: isNotEmpty,
                controller: daysCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Ex: 10'),
                inputFormatters: [
                  AppHelpers.numberWithThousandsSeparatorFormatter()
                ],
              ),
              const SizedBox(height: 26),
              const Text(
                'Qual valor você levará para gastar?',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Digite a quantia que será destinada para os dias em que estiver viajando',
                style: TextStyle(color: Get.theme.colorScheme.onBackground),
              ),
              TextFormField(
                validator: isNotEmpty,
                controller: moneyController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: 'Ex: R\$ 10.000,00'),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleContinue() {
    if (!(formKey.currentState?.validate() ?? false)) return;

    controller.setDays(int.parse(daysCtrl.text));
    controller.setTotalValue(
      AppHelpers.revertCurrencyFormat(moneyController.text),
    );
    controller.goToNextStep();
  }
}
