import '../../core/theme/dark/dark_colors.dart';
import '../../data/services/theme_service.dart';
import '../../global/widgets/confirm_dialog.dart';
import 'preferences_controller.dart';
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
            title: Text('preferences'.tr),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTile(
                    title: 'balanceOfMonth'.tr,
                    subtitle: 'changeBalance'.tr,
                    icon: Icons.monetization_on,
                    onTap: controller.changeBalance,
                  ),
                  _buildTile(
                    title: 'Escolher categorias',
                    subtitle:
                        'Selecione as categorias que façam sentido para seu uso',
                    icon: Icons.category,
                    onTap: controller.chooseCategories,
                  ),
                  _buildTile(
                    title: 'Modo Escuro',
                    subtitle: 'Alterna entre modo escuro e claro',
                    icon: Icons.dark_mode,
                    haveSwitch: true,
                    switchValue: appTheme.isDark,
                    toggleSwitch: controller.toggleTheme,
                  ),
                  _buildTile(
                    title: 'copyBills'.tr,
                    subtitle: 'copyBillsToTheNextMonth'.tr,
                    icon: Icons.copy,
                    haveSwitch: true,
                    switchValue: controller.copyBills,
                    toggleSwitch: controller.toggleCopyBills,
                  ),
                  _buildTile(
                    title: 'biometry'.tr,
                    subtitle: 'enableBiometry'.tr,
                    icon: Icons.fingerprint,
                    haveSwitch: true,
                    switchValue: controller.biometryEnabled,
                    toggleSwitch: controller.toggleBiometry,
                  ),
                  _buildTile(
                    title: 'Backup dos dados',
                    subtitle: 'Utilize para exportar ou importar dados',
                    icon: Icons.save,
                    onTap: () {
                      Get.bottomSheet(
                        Wrap(
                          children: [
                            ListTile(
                              tileColor: Get.theme.colorScheme.surface,
                              leading: Icon(Icons.upload,
                                  color: Get.theme.colorScheme.primary),
                              title: const Text('Exportar dados'),
                              onTap: () {
                                Get.back();
                                Get.dialog(
                                  ConfirmDialog(
                                    icon: Icon(
                                      Icons.save,
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                    body:
                                        'Tem certeza que deseja exportar os dados?',
                                    onConfirm: () => controller.exportDb(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                                tileColor: Get.theme.colorScheme.surface,
                                leading: Icon(Icons.download,
                                    color: Get.theme.colorScheme.primary),
                                title: const Text('Importar dados'),
                                onTap: () {
                                  Get.back();
                                  Get.dialog(
                                    ConfirmDialog(
                                      icon: Icon(
                                        Icons.download,
                                        color: Get.theme.colorScheme.primary,
                                      ),
                                      body:
                                          'Ao importar dados, os dados atuais serão excluídos, tem certeza que deseja continuar?',
                                      onConfirm: controller.importDb,
                                    ),
                                  );
                                }),
                          ],
                        ),
                      );
                    },
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
    bool isVisible = true,
  }) {
    return Visibility(
      visible: isVisible,
      child: ListTile(
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
      ),
    );
  }
}
