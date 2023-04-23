import 'package:financial_control_app/app/data/models/add_category_step.dart';
import 'package:financial_control_app/app/modules/add_category/widgets/selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../../data/repository/category_repository.dart';

class AddCategoryController extends GetxController {
  final CategoryRepository repository;

  bool nameIsFilled = false;

  final nameController = TextEditingController();
  Color? selectedColor;
  IconData? selectedIcon;

  List<AddCategoryStep> steps = [];

  AddCategoryController(this.repository);

  void loadSteps() {
    steps.addAll([
      AddCategoryStep(
        title: 'Nome',
        indicatorIcon: Icons.category,
        child: TextField(
          controller: nameController,
          decoration:
              const InputDecoration(hintText: 'Digite o nome da categoria'),
        ),
        isDone: () => nameController.text.trim().isNotEmpty,
      ),
      AddCategoryStep(
        title: 'Cor',
        indicatorIcon: Icons.palette,
        child: SelectorWidget(
          prefixWidget: Container(
            width: 24,
            height: 24,
            child: selectedColor == null
                ? Icon(
                    Icons.palette,
                    color: Get.theme.colorScheme.onBackground,
                  )
                : null,
            decoration: BoxDecoration(
                color: selectedColor, borderRadius: BorderRadius.circular(3)),
          ),
          title: 'Selecione uma cor',
          subtitle: selectedColor != null
              ? selectedColor.toString()
              : 'Nenhuma cor selecionada',
          onTap: () {
            pickColor();
          },
        ),
        isDone: () => selectedColor != null,
      ),
      AddCategoryStep(
        title: 'Ícone',
        indicatorIcon: Icons.insert_emoticon,
        child: SelectorWidget(
          prefixWidget: Icon(
            Icons.insert_emoticon,
            color: Get.theme.colorScheme.onBackground,
          ),
          title: 'Selecione um icone',
          subtitle: selectedIcon != null
              ? selectedIcon.toString()
              : 'Nenhum icone selecionado',
        ),
        isDone: () => selectedIcon != null,
      ),
      AddCategoryStep(
        title: 'Concluído',
        indicatorIcon: Icons.done,
        child: Container(),
        isDone: () {
          return false;
        },
      ),
    ]);
  }

  void pickColor() {
    Color? selectionColor;

    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Escolha uma cor'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: const Color(0xFFFFFFFF),
              paletteType: PaletteType.hueWheel,
              onColorChanged: (value) {
                selectionColor = value;
              },
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Confirmar'),
              onPressed: () {
                selectedColor = selectionColor;
                update();

                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  void pickIcon() {}

  @override
  void onInit() {
    super.onInit();
    loadSteps();
    nameController.addListener(() {
      update();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
