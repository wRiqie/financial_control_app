class Bill {
  late String id;
  late String title;
  late double value;
  int? portion;
  int? maxPortion;
  late DateTime dueDate;
  late int status;

  Bill({
    required this.id,
    required this.title,
    required this.value,
    this.portion,
    this.maxPortion,
    required this.dueDate,
    required this.status,
  });
}