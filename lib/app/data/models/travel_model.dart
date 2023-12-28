class TravelModel {
  String id;
  String? title;
  num totalValue;
  int totalDays;

  TravelModel({
    required this.id,
    this.title,
    this.totalValue = 0.0,
    this.totalDays = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'totalValue': totalValue,
      'totalDays': totalDays,
    };
  }

  factory TravelModel.fromMap(Map<String, dynamic> map) {
    return TravelModel(
      id: map['id'],
      title: map['title'],
      totalValue: map['totalValue'],
      totalDays: map['totalDays'],
    );
  }
}
