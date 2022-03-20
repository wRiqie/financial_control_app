class Bill {
  late String id;
  late int categoryId;
  late String title;
  late double value;
  int? portion;
  int? maxPortion;
  late int dueDate;
  late int status;

  Bill({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.value,
    this.portion,
    this.maxPortion,
    required this.dueDate,
    required this.status,
  });
}