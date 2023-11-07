import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:financial_control_app/app/data/models/category_model.dart';

class CategoryTileWidget extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(bool? value) toggleSelected;

  const CategoryTileWidget({
    Key? key,
    required this.category,
    required this.onEdit,
    required this.onDelete,
    required this.toggleSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: Get.theme.colorScheme.primary.withOpacity(.2),
            foregroundColor: Get.theme.colorScheme.primary,
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: Get.theme.colorScheme.error.withOpacity(.2),
            foregroundColor: Get.theme.colorScheme.error,
            icon: Icons.delete,
          ),
        ],
      ),
      child: CheckboxListTile(
        title: Text(category.translateName?.tr ?? category.name),
        secondary: Icon(
          category.icon,
          color: Color(category.color),
        ),
        value: category.selected,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: toggleSelected,
        activeColor: Get.theme.colorScheme.primary,
      ),
    );
  }
}
