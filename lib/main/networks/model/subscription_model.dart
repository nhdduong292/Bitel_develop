class SubscriptionModel{
  String? _subId;
  String? _isdn;
  String? _account;
  String? _password;
  String? _speed;
  String? _productCode;
  String? _pricePlan;
  String? _localPricePlan;

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

  String get localPricePlan => _localPricePlan ?? "";

  String get pricePlan => _pricePlan ?? "";

  String get productCode => _productCode ?? "";

  String get speed => _speed ?? "";

  String get password => _password ?? "";

  String get account => _account ?? "";

  String get isdn => _isdn ?? "";

  String get subId => _subId ?? "";
}