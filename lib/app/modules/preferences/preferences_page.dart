import 'package:financial_control_app/app/core/theme/dark/dark_colors.dart';
import 'package:financial_control_app/app/modules/preferences/preferences_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreferencesPage extends GetView<PreferencesController> {
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreferencesController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Preferences'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTile(
                    title: 'Balance of Month',
                    subtitle: 'Change the balance value for selected month',
                    icon: Icons.monetization_on,
                    onTap: controller.changeBalance,
                  ),
                  _buildTile(
                    title: 'Copy bills',
                    subtitle: 'Copy bills to the next month',
                    icon: Icons.copy,
                    haveSwitch: true,
                    switchValue: controller.copyBills,
                    toggleSwitch: controller.toogleCopyBills,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTile({
    required String title,
    String? subtitle,
    required IconData icon,
    VoidCallback? onTap,
    bool haveSwitch = false,
    Function(bool)? toggleSwitch,
    bool switchValue = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Get.theme.colorScheme.primary,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          subtitle != null
              ? Text(
                  subtitle,
                  style: const TextStyle(color: DarkColors.grey, fontSize: 12),
                )
              : Container(),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      trailing: haveSwitch
          ? Switch(
              value: switchValue,
              onChanged: toggleSwitch,
              activeColor: Get.theme.colorScheme.primary,
            )
          : Icon(
              Icons.arrow_forward_ios,
              color: Get.theme.colorScheme.primary,
            ),
      onTap: haveSwitch ? null : onTap,
    );
  }
}