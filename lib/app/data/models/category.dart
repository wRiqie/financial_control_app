import 'package:flutter/cupertino.dart';

class Category {
  final int id;
  final String name;
  final String? translateName;
  final int iconCodePoint;
  final int color;
  int sortOrder;
  bool selected;

  Category({
    this.id = 0,
    this.name = '',
    this.translateName,
    this.selected = false,
    required this.iconCodePoint,
    required this.color,
    this.sortOrder = 0,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
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
