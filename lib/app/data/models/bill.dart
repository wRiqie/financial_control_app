class Bill {
  late String id;
  late int categoryId;
  late String title;
  late num value;
  int? portion;
  int? maxPortion;
  late int dueDate;
  late int status;
  late String date;

  Bill({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.value,
    this.portion,
    this.maxPortion,
    required this.dueDate,
    required this.status,
    required this.date,
  });

  Bill.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    categoryId = map['categoryId'];
    title = map['title'];
    value = map['value'];
    portion = map['portion'];
    maxPortion = map['maxPortion'];
    dueDate = map['dueDate'];
    status = map['status'];
    date = map['date'].toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'value': value,
      'portion': portion,
      'maxPortion': maxPortion,
      'dueDate': dueDate,
      'status': status,
      'date': date,
    };
  }
}
