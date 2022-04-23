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

  static EBillStatus getById(int id) {
    return _status.firstWhere((e) => e['id'] == id)['status'] as EBillStatus;
  }
}