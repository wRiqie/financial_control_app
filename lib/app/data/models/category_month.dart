class CategoryMonth {
  late int categoryMonthId;
  late int categoryId;
  late String month;
  late num value;

  CategoryMonth({
    required this.categoryMonthId,
    required this.categoryId,
    required this.month,
    this.value = 0.0,
  });

  CategoryMonth.fromMap(Map<String, dynamic> map) {
    categoryMonthId = map['categoryMonthId'];
    categoryId = map['categoryId'];
    month = map['month'];
    value = map['value'];
  }
}
