import 'package:flutter/cupertino.dart';

class AddCategoryStep {
  final String title;
  final Widget child;
  final IconData indicatorIcon;
  final bool Function() isDone;

  AddCategoryStep({
    required this.title,
    required this.child,
    required this.indicatorIcon,
    required this.isDone,
  });
}
