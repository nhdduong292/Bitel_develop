class FindAccountModel {
  int? _subId;
  int? _custId;
  String? _typeOfService;
  String? _plan;
  String? _serviceNumber;
  bool? _active;
  int? _idType;
  String? _idNumber;
  String? _name;
  String? _phone;
  String? _account;
  String? _address;
  String? _provinceName;
  String? _districtName;
  String? _precinctName;
  String? _province;
  String? _district;
  String? _precinct;

  FindAccountModel();

  FindAccountModel.fromJson(Map<String, dynamic> json) {
    _subId = json['subId'];
    _custId = json['custId'];
    _typeOfService = json['typeOfService'];
    _plan = json['plan'];
    _serviceNumber = json['serviceNumber'];
    _active = json['active'];
    _idType = json['idType'];
    _idNumber = json['idNumber'];
    _name = json['name'];
    _phone = json['phone'];
    _account = json['account'];
    _address = json['address'];
    _provinceName = json['provinceName'];
    _districtName = json['districtName'];
    _precinctName = json['precinctName'];
    _province = json['province'];
    _district = json['district'];
    _precinct = json['precinct'];
  }

  int get subId {
    return _subId ?? 0;
  }

  int get custId {
    return _custId ?? 0;
  }

  String get typeOfService {
    return _typeOfService ?? '---';
  }

  String get plan {
    return _plan ?? '---';
  }

  String get serviceNumber {
    return _serviceNumber ?? '---';
  }

  bool get active {
    return _active ?? false;
  }

  int get idType {
    return _idType ?? 0;
  }

  String get idNumber {
    return _idNumber ?? '---';
  }

  String get name {
    return _name ?? '---';
  }

  String get phone {
    return _phone ?? '---';
  }

  String get account {
    return _account ?? '---';
  }

  String get address {
    return _address ?? '---';
  }

  String get precinct => _precinct ?? "";

  String get district => _district ?? "";

  String get province => _province ?? "";

  String get provinceName => _provinceName ?? "";

  String get districtName => _districtName ?? "";

  String get precinctName => _precinctName ?? "";

  String getInstalAddress() {
    return "$precinctName, $districtName, $provinceName";
  }
}
