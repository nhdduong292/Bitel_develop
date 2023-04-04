class SubscriptionModel {
  int? _subId;
  String? _isdn;
  String? _account;
  String? _password;
  double? _speed;
  String? _productCode;
  double? _pricePlan;
  double? _localPricePlan;

  SubscriptionModel();
  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    _subId = json['subId'];
    _isdn = json['isdn'];
    _account = json['account'];
    _password = json['password'];
    _speed = json['speed'];
    _productCode = json['productCode'];
    _pricePlan = json['pricePlan'];
    _localPricePlan = json['localPricePlan'];
  }

  double get localPricePlan => _localPricePlan ?? 0;

  double get pricePlan => _pricePlan ?? 0;

  String get productCode => _productCode ?? "";

  double get speed => _speed ?? 0;

  String get password => _password ?? "";

  String get account => _account ?? "";

  String get isdn => _isdn ?? "";

  int get subId => _subId ?? 0;
}
