class Month {
  late String date;
  num? totalPrice;
  num? pricePaid;

  Month({
    required this.date,
    this.totalPrice,
    this.pricePaid,
  });

  Month.fromMap(Map<String, dynamic> map) {
    date = map['date'];
    totalPrice = map['totalPrice'];
    pricePaid = map['pricePaid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'totalPrice': totalPrice,
      'pricePaid': pricePaid,
    };
  }
}