class Month {
  late String date;
  num? totalPrice;
  num? balance;

  Month({
    required this.date,
    this.totalPrice,
    this.balance,
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