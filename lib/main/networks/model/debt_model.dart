class DebtModel {
  String? _invoiceNo;
  double? _debt;
  String? _createDate;

  DebtModel();

  DebtModel.fromJson(Map<String, dynamic> json) {
    _invoiceNo = json['invoiceNo'];
    _debt = json['debt'];
    _createDate = json['createDate'];
  }

  String get invoiceNo {
    return _invoiceNo ?? '---';
  }

  double get debt {
    return _debt ?? 10;
  }

  String get createDate {
    return _createDate ?? '';
  }
}
