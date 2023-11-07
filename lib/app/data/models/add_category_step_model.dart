import 'package:flutter/cupertino.dart';

class AddCategoryStepModel {
  final String title;
  final Widget child;
  final IconData indicatorIcon;
  final bool Function() isDone;

  AddCategoryStepModel({
    required this.title,
    required this.child,
    required this.indicatorIcon,
    required this.isDone,
  });
}
