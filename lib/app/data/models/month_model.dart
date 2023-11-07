class MonthModel {
  late String date;
  num? totalPrice;
  num? balance;
  num? totalUnpaid;

  MonthModel({
    required this.date,
    this.totalPrice,
    this.balance,
    this.totalUnpaid,
  });

  MonthModel.fromMap(Map<String, dynamic> map) {
    date = map['date'];
    totalPrice = map['totalPrice'];
    balance = map['balance'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'totalPrice': totalPrice,
      'balance': balance,
    };
  }
}
