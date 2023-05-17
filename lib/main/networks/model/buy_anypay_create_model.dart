class BuyAnyPayCreateModel {
  String? _isdn;
  String? _bankCode;
  String? _code;
  String? _idNumber;
  String? _name;
  double? _amount;
  String? _idType;
  double? _discount;
  double? _total;
  String? _transactionDate;

  BuyAnyPayCreateModel();
  BuyAnyPayCreateModel.fromJson(Map<String, dynamic> json) {
    _isdn = json['isdn'];
    _bankCode = json['bankCode'];
    _code = json['code'];
    _idNumber = json['idNumber'];
    _name = json['name'];
    _amount = json['amount'];
    _idType = json['idType'];
    _discount = json['discount'];
    _total = json['total'];
    _transactionDate = json['transactionDate'];
  }

  String get code {
    return _code ?? '---';
  }

  String get idType {
    return _idType ?? '---';
  }

  String get idNumber {
    return _idNumber ?? '---';
  }

  String get name {
    return _name ?? '---';
  }

  String get isdn {
    return _isdn ?? '---';
  }

  String get transactionDate {
    return _transactionDate ?? '---';
  }

  String get bankCode {
    return _bankCode ?? '---';
  }

  double get amount {
    return _amount ?? 0;
  }

  double get total {
    return _total ?? 0;
  }

  double get discount {
    return _discount ?? 0;
  }
}
