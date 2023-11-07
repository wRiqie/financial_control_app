import 'package:flutter/Material.dart';

class CategoryDataModel {
  int id;
  String name;
  double totalPrice;
  Color color;
  IconData icon;

  CategoryDataModel({
    required this.id,
    required this.name,
    required this.totalPrice,
    required this.color,
    required this.icon,
  });
}
