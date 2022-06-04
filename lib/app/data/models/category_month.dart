class CategoryMonth {
  late String id;
  late int categoryId;
  late String month;
  late num value;

  CategoryMonth({
    required this.categoryId,
    required this.month,
    this.value = 0.0,
  }) {
    id = month + categoryId.toString();
  }

  CategoryMonth.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    categoryId = map['categoryId'];
    month = map['month'];
    value = map['value'];
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'categoryId': categoryId,
        'month': month,
        'value': value,
      };
}
