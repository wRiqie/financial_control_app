class TravelDayModel {
  int id;
  int day;
  String travelId;
  // USED VALUE
  num totalValue;

  TravelDayModel({
    required this.id,
    required this.day,
    required this.travelId,
    required this.totalValue,
  });

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'travelId': travelId,
      'totalValue': totalValue,
    };
  }

  factory TravelDayModel.fromMap(Map<String, dynamic> map) {
    return TravelDayModel(
      id: map['id'],
      day: map['day'],
      travelId: map['travelId'],
      totalValue: map['totalValue'],
    );
  }
}
