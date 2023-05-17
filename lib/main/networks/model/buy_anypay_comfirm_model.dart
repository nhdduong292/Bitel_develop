class BuyAnyPayGeneralModel {
  String? _code;
  String? _idType;
  String? _idNumber;
  String? _name;
  double? _balance;
  double? _amountMin;
  double? _amountMax;

  BuyAnyPayGeneralModel();
  BuyAnyPayGeneralModel.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _idNumber = json['idNumber'];
    _name = json['name'];
    _idType = json['idType'];
    _balance = json['balance'];
    _amountMin = json['amountMin'];
    _amountMax = json['amountMax'];
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

  double get balance {
    return _balance ?? 0;
  }

  double get amountMin {
    return _amountMin ?? 0;
  }

  double get amountMax {
    return _amountMax ?? 0;
  }
}
