import '../enums/bill_status_enum.dart';

class BillModel {
  late String id;
  late int categoryId;
  late String title;
  late num value;
  int? portion;
  int? maxPortion;
  late int dueDate;
  late int status;
  late String date;

  BillModel({
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

  BillModel.fromMap(Map<String, dynamic> map) {
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

extension BillExtension on List<BillModel> {
  double get leftPrice {
    var leftBills = where((e) => e.status != EBillStatus.paid.id);
    double price = 0;
    for (var bill in leftBills) {
      price += bill.value;
    }
    return price;
  }

  double get totalPrice {
    double price = 0;
    for (var bill in this) {
      price += bill.value;
    }
    return price;
  }

  double get percentage {
    double paidValue = 0;
    double totalValue = totalPrice;
    var paidBills = where((e) => e.status == EBillStatus.paid.id);
    for (var paidBill in paidBills) {
      paidValue += paidBill.value;
    }

    return ((paidValue * 100) / (totalValue != 0 ? totalValue : 1)) / 100;
  }
}
