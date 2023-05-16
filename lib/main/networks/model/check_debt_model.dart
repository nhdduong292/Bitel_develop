class CheckDebtModel {
  bool? _isDebt;
  double? _debt;
  String? _debtInvoiceNumber;
  bool? _isPendingWo;
  String? _pendingWoType;
  String? _pendingWoStatus;

  CheckDebtModel();
  CheckDebtModel.fromJson(Map<String, dynamic> json) {
    _isDebt = json['isDebt'];
    _debt = json['debt'];
    _debtInvoiceNumber = json['debtInvoiceNumber'];
    _isPendingWo = json['isPendingWo'];
    _isPendingWo = json['isPendingWo'];
    _pendingWoType = json['pendingWoType'];
    _pendingWoStatus = json['pendingWoStatus'];
  }

  bool get isDebt {
    return _isDebt ?? false;
  }

  double get debt {
    return _debt ?? 0;
  }

  String get debtInvoiceNumber {
    return _debtInvoiceNumber ?? '---';
  }

  bool get isPendingWo {
    return _isPendingWo ?? false;
  }

  String get pendingWoType {
    return _pendingWoType ?? '---';
  }

  String get pendingWoStatus {
    return _pendingWoStatus ?? '---';
  }
}
