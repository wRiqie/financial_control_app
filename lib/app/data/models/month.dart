class Month {
  late String date;
  num? totalPrice;
  num? balance;
  num? totalUnpaid;

  Month({
    required this.date,
    this.totalPrice,
    this.balance,
    this.totalUnpaid,
  });

  Month.fromMap(Map<String, dynamic> map) {
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