import 'package:flutter/Material.dart';

class CategoryData {
  int id;
  String name;
  double totalPrice;
  Color color;
  IconData icon;

  CategoryData({
    required this.id,
    required this.name,
    required this.totalPrice,
    required this.color,
    required this.icon,
  });
}
