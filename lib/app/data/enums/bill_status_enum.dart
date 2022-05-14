enum EBillStatus {
  overdue,
  pendent,
  paid,
}

extension BillStatusExtension on EBillStatus {
  static final _status = [
    {'id': 0, 'status': EBillStatus.overdue},
    {'id': 1, 'status': EBillStatus.pendent},
    {'id': 2, 'status': EBillStatus.paid},
  ];

  int get id => 
      _status.firstWhere((e) => e['status'] == this)['id'] as int;

  static EBillStatus getById(int id) =>
      _status.firstWhere((e) => e['id'] == id)['status'] as EBillStatus;
}
