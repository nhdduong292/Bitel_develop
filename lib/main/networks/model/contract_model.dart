class ContractModel{
  int? _contractId;
  String? _contractNo;
  String? _signDate;
  int? _billCycleFrom;
  String? _billCycleFromCharging;
  int? _status;
  String? _operationCode;
  String? _fullNameCus;
  String? _phone;
  String? _productName;
  String? _promotionName;

  ContractModel();
  ContractModel.fromJson(Map<String, dynamic> json) {
    _contractId = json['contractId'];
    _contractNo = json['contractNo'];
    _signDate = json['signDate'];
    _billCycleFrom = json['billCycleFrom'];
    _billCycleFromCharging = json['billCycleFromCharging'];
    _status = json['status'];
    _operationCode = json['operationCode'];
    _fullNameCus = json['fullNameCus'];
    _phone = json['phone'];
    _productName = json['productName'];
    _promotionName = json['promotionName'];
  }

  String get promotionName => _promotionName ?? "";

  set promotionName(String value) {
    _promotionName = value;
  }

  String get productName => _productName ?? "";

  set productName(String value) {
    _productName = value;
  }

  String get phone => _phone ?? "";

  set phone(String value) {
    _phone = value;
  }

  String get fullNameCus => _fullNameCus ?? "";

  set fullNameCus(String value) {
    _fullNameCus = value;
  }

  String get operationCode => _operationCode ?? "";

  set operationCode(String value) {
    _operationCode = value;
  }

  int get status => _status ?? 0;


  String get billCycleFromCharging => _billCycleFromCharging ?? "";

  set billCycleFromCharging(String value) {
    _billCycleFromCharging = value;
  }

  int get billCycleFrom => _billCycleFrom ?? 0;

  String get signDate => _signDate ?? "";

  set signDate(String value) {
    _signDate = value;
  }

  String get contractNo => _contractNo ?? "";

  set contractNo(String value) {
    _contractNo = value;
  }

  int get contractId => _contractId ?? 0;

}