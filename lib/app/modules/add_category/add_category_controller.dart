import 'package:financial_control_app/app/data/models/add_category_step_model.dart';
import 'package:financial_control_app/app/data/models/category_model.dart';
import 'package:financial_control_app/app/data/services/snackbar_service.dart';
import 'package:financial_control_app/app/modules/add_category/widgets/select_color_dialog_widget.dart';
import 'package:financial_control_app/app/modules/add_category/widgets/select_icon_dialog_widget.dart';
import 'package:financial_control_app/app/modules/add_category/widgets/selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repository/category_repository.dart';

class AddCategoryController extends GetxController {
  final CategoryRepository _categoryRepository;

  bool nameIsFilled = false;

  final nameController = TextEditingController();
  // final iconController = IconController();
  Color? selectedColor;
  IconData? selectedIcon;

  bool isLoading = false;

  AddCategoryController(this._categoryRepository);

  List<AddCategoryStepModel> get steps => [
        AddCategoryStepModel(
          title: 'Nome',
          indicatorIcon: Icons.category,
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Digite o nome da categoria',
            ),
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          isDone: () => nameIsFilled,
        ),
        AddCategoryStepModel(
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
                ? '#${(selectedColor?.value.toRadixString(16) ?? '')}'
                : 'Nenhuma cor selecionada',
            onTap: () {
              Get.focusScope?.unfocus();
              pickColor();
            },
          ),
          isDone: () => selectedColor != null,
        ),
        AddCategoryStepModel(
          title: 'Ícone',
          indicatorIcon: Icons.insert_emoticon,
          child: SelectorWidget(
            prefixWidget: Icon(
              selectedIcon ?? Icons.insert_emoticon,
              color: Get.theme.colorScheme.onBackground,
            ),
            title: 'Selecione um icone',
            subtitle: selectedIcon != null
                ? 'N° ${(selectedIcon?.codePoint.toString() ?? '')}'
                : 'Nenhum icone selecionado',
            onTap: () {
              Get.focusScope?.unfocus();
              pickIcon();
            },
          ),
          isDone: () => selectedIcon != null,
        ),
        AddCategoryStepModel(
          title: 'Concluído',
          indicatorIcon: Icons.done,
          child: Container(),
          isDone: () =>
              selectedColor != null && selectedIcon != null && nameIsFilled,
        ),
      ];

  void pickColor() async {
    var result = await Get.dialog<Color>(
      const SelectColorDialogWidget(),
    );

    if (result != null) {
      selectedColor = result;
      update();
    }
  }

  void pickIcon() async {
    var result = await Get.dialog<IconData>(SelectIconDialogWidget(
      color: selectedColor,
    ));

    if (result != null) {
      selectedIcon = result;
      update();
    }
  }

  bool checkFields() {
    if (!nameIsFilled) {
      ErrorSnackbar(
          title: 'Campos não preenchidos',
          message: 'Por favor, preencha o campo nome da categoria');
      return false;
    } else if (selectedColor == null) {
      ErrorSnackbar(
        title: 'Campos não preenchidos',
        message: 'Por favor, selecione uma cor',
      );
    } else if (selectedIcon == null) {
      ErrorSnackbar(
        title: 'Campos não preenchidos',
        message: 'Por favor, selecione um ícone',
      );
    }
    return true;
  }

  void finish() async {
    if (!checkFields()) return;

    isLoading = true;
    update();

    final category = CategoryModel(
      iconCodePoint: selectedIcon!.codePoint,
      color: selectedColor!.value,
      name: nameController.text,
      selected: true,
    );

    await _categoryRepository.saveCategory(category);

    isLoading = false;
    update();

    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(() {
      if (nameController.text.trim().isNotEmpty) {
        nameIsFilled = true;
      } else {
        nameIsFilled = false;
      }
      update();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    // iconController.dispose();
    super.dispose();
  }
}
