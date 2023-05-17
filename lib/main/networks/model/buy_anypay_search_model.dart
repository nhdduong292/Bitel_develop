class BuyAnyPaySearchModel {
  String? _saleOrderId;
  String? _saleOrderCode;
  String? _status;
  double? _totalToPay;
  int? _quantity;
  String? _saleOrderDate;
  BuyAnyPaySearchModel();
  BuyAnyPaySearchModel.fromJson(Map<String, dynamic> json) {
    _saleOrderId = json['saleOrderId'];
    _saleOrderCode = json['saleOrderCode'];
    _status = json['status'];
    _totalToPay = json['totalToPay'];
    _quantity = json['quantity'];
    _saleOrderDate = json['saleOrderDate'];
  }

  String get saleOrderId {
    return _saleOrderId ?? '---';
  }

  String get saleOrderCode {
    return _saleOrderCode ?? '---';
  }

  String get status {
    return _status ?? '---';
  }

  String get saleOrderDate {
    return _saleOrderDate ?? '---';
  }

  double get totalToPay {
    return _totalToPay ?? 0;
  }

  int get quantity {
    return _quantity ?? 0;
  }
}
