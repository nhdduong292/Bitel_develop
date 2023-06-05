class CancelServiceInforModel {
  String? _operationCode;
  String? _customer;
  int? _idType;
  String? _idNumber;
  String? _serviceNumber;
  String? _phone;
  String? _email;
  String? _product;
  String? _requestDate;
  String? _cancelDate;
  String? _account;

  CancelServiceInforModel();
  CancelServiceInforModel.fromJson(Map<String, dynamic> json) {
    _operationCode = json['operationCode'];
    _customer = json['customer'];
    _idType = json['idType'];
    _idNumber = json['idNumber'];
    _serviceNumber = json['serviceNumber'];
    _phone = json['phone'];
    _email = json['email'];
    _product = json['product'];
    _requestDate = json['requestDate'];
    _cancelDate = json['cancelDate'];
    _account = json['account'];
  }

  String get account => _account ?? "---";

  String get product => _product ?? "---";

  String get phone => _phone ?? "---";

  String get customer => _customer ?? "---";

  String get operationCode => _operationCode ?? "---";

  int get idType => _idType ?? 0;

  String get serviceNumber => _serviceNumber ?? "---";

  String get email => _email ?? "---";

  String get requestDate => _requestDate ?? "---";

  String get cancelDate => _cancelDate ?? "---";

  String get idNumber => _idNumber ?? "";
}
