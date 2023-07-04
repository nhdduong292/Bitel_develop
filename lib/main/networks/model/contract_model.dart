import 'package:bitel_ventas/main/networks/model/sub_ott_model.dart';

class ContractModel {
  int? _contractId;
  String? _contractNo;
  String? _signDate;
  String? _billCycleFrom;
  String? _billCycleFromCharging;
  int? _status;
  String? _account;
  String? _operationCode;
  String? _identityType;
  String? _idNumber;
  String? _fullNameCus;
  String? _phone;
  String? _productName;
  String? _promotionName;
  String? _language;
  int? _numOfSubscriber;
  String? _changeNotification;
  String? _printBill;
  String? _currency;
  String? _provinceName;
  String? _province;
  String? _districtName;
  String? _district;
  String? _precinctName;
  String? _precinct;
  String? _address;
  List<SubOTTModel>? _subOtts;

  ContractModel();
  ContractModel.fromJson(Map<String, dynamic> json) {
    _contractId = json['contractId'];
    _contractNo = json['contractNo'];
    _signDate = json['signDate'];
    _billCycleFrom = json['billCycleFrom'];
    _billCycleFromCharging = json['billCycleFromCharging'];
    _status = json['status'];
    _operationCode = json['operationCode'];
    _identityType = json['identityType'];
    _idNumber = json['idNumber'];
    _fullNameCus = json['fullNameCus'];
    _phone = json['phone'];
    _productName = json['productName'];
    _promotionName = json['promotionName'];
    _account = json['account'];
    _language = json['language'];
    _numOfSubscriber = json['numOfSubscriber'];
    _changeNotification = json['changeNotification'];
    _printBill = json['printBill'];
    _currency = json['currency'];
    _provinceName = json['provinceName'];
    _province = json['province'];
    _districtName = json['districtName'];
    _district = json['district'];
    _precinctName = json['precinctName'];
    _precinct = json['precinct'];
    _address = json['address'];
    if (json['subOtts'] != null) {
      _subOtts = (json['subOtts'] as List)
          .map((e) => SubOTTModel.fromJson(e))
          .toList();
    }
  }

  String get promotionName => _promotionName ?? "";

  String get account => _account ?? "";

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

  String get operationCode => _operationCode ?? "---";

  set operationCode(String value) {
    _operationCode = value;
  }

  int get status => _status ?? 0;

  String get billCycleFromCharging => _billCycleFromCharging ?? "";

  set billCycleFromCharging(String value) {
    _billCycleFromCharging = value;
  }

  String get billCycleFrom => _billCycleFrom ?? "";

  String get signDate => _signDate ?? "";

  set signDate(String value) {
    _signDate = value;
  }

  String get contractNo => _contractNo ?? "";

  set contractNo(String value) {
    _contractNo = value;
  }

  int get contractId => _contractId ?? 0;

  String get identityType => _identityType ?? "";

  set identityType(String value) {
    _identityType = value;
  }

  String get idNumber => _idNumber ?? "";

  set idNumber(String value) {
    _idNumber = value;
  }

  String get language => _language ?? "";

  int get numOfSubscriber => _numOfSubscriber ?? 0;

  String get changeNotification => _changeNotification ?? "";

  String get printBill => _printBill ?? "";

  String get currency => _currency ?? "";

  String get provinceName => _provinceName ?? "";

  String get province => _province ?? "";

  String get districtName => _districtName ?? "";

  String get district => _district ?? "";

  String get precinctName => _precinctName ?? "";

  String get precinct => _precinct ?? "";

  String get address => _address ?? "";

  List<SubOTTModel> get subOtts => _subOtts ?? [];
}
