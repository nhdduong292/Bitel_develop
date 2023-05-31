class CheckPaymentChangePlanModel {
  int? _prepaidMonth;
  double? _paymentCurrentInvoice;
  double? _prepaidMoney;
  double? _discount;
  double? _totalAmount;

  CheckPaymentChangePlanModel();
  CheckPaymentChangePlanModel.fromJson(Map<String, dynamic> json) {
    _prepaidMonth = json['prepaidMonth'];
    _paymentCurrentInvoice = json['paymentCurrentInvoice'];
    _prepaidMoney = json['prepaidMoney'];
    _discount = json['discount'];
    _totalAmount = json['totalAmount'];
  }

  int get prepaidMonth {
    return _prepaidMonth ?? 0;
  }

  double get prepaidMoney {
    return _prepaidMoney ?? 0;
  }

  double get paymentCurrentInvoice {
    return _paymentCurrentInvoice ?? 0;
  }

  double get discount {
    return _discount ?? 0;
  }

  double get totalAmount {
    return _totalAmount ?? 0;
  }
}
