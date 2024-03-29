import 'package:flutter/cupertino.dart';

class CategoryModel {
  final int? id;
  final String name;
  final String? translateName;
  final int iconCodePoint;
  final int color;
  int sortOrder;
  bool selected;

  CategoryModel({
    this.id,
    this.name = '',
    this.translateName,
    this.selected = false,
    required this.iconCodePoint,
    required this.color,
    this.sortOrder = 0,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'] ?? '',
      translateName: map['translateName'],
      selected: map['selected'] == 1,
      color: map['color'],
      iconCodePoint: map['iconCodePoint'],
      sortOrder: map['sortOrder'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'translateName': translateName,
      'selected': selected ? 1 : 0,
      'color': color,
      'iconCodePoint': iconCodePoint,
      'sortOrder': sortOrder,
    };
  }

  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');
}
