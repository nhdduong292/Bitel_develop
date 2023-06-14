import 'dart:ffi';

class TransferServiceInforModel {
  String? _operationCode;
  String? _customer;
  int? _idType;
  String? _idNumber;
  String? _serviceNumber;
  String? _phone;
  String? _email;
  String? _requestDate;
  String? _operationDate;
  String? _account;
  String? oldAddress;
  String? oldProvinceName;
  String? oldDistrictName;
  String? oldPrecinctName;
  String? address;
  String? provinceName;
  String? districtName;
  String? precinctName;

  TransferServiceInforModel();

  TransferServiceInforModel.fromJson(Map<String, dynamic> json) {
    _operationCode = json['operationCode'] ?? "---";
    _customer = json['customer'] ?? "---";
    _idType = json['idType'] ?? 0;
    _idNumber = json['idNumber'] ?? "---";
    _serviceNumber = json['serviceNumber'] ?? "---";
    _phone = json['phone'] ?? "---";
    _email = json['email'] ?? "---";
    _requestDate = json['requestDate'] ?? "---";
    _operationDate = json['operationDate'] ?? "---";
    _account = json['account'] ?? "---";
    oldAddress = json['oldAddress'] ?? "---";
    oldProvinceName = json['oldProvinceName'] ?? "---";
    oldDistrictName = json['oldDistrictName'] ?? "---";
    oldPrecinctName = json['oldPrecinctName'] ?? "---";
    address = json['address'] ?? "---";
    provinceName = json['provinceName'] ?? "---";
    districtName = json['districtName'] ?? "---";
    precinctName = json['precinctName'] ?? "---";
  }

  String get operationCode {
    return _operationCode ?? "---";
  }

  String get customer {
    return _customer ?? "---";
  }

  int get idType {
    return _idType ?? 0;
  }

  String get idNumber {
    return _idNumber ?? "---";
  }

  String get serviceNumber {
    return _serviceNumber ?? "---";
  }

  String get phone {
    return _phone ?? "---";
  }

  String get email {
    return _email ?? "---";
  }

  String get requestDate {
    return _requestDate ?? "---";
  }

  String get operationDate {
    return _operationDate ?? "---";
  }

  String get account {
    return _account ?? "---";
  }

  String getInstalAddressNew() {
    return "$address, $precinctName, $districtName, $provinceName";
  }

  String getInstalAddressOld() {
    return "$oldAddress, $oldPrecinctName, $oldDistrictName, $oldProvinceName";
  }
}
