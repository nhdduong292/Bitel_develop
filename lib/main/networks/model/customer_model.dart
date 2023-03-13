class CustomerModel {
  int? _custId;
  String? _firstName;
  String? _fullName;
  String? _telFax;
  String? _type;
  String? _idNumber;
  String? _areaCode;
  String? _province;
  String? _district;
  String? _precinct;
  String? _street;
  String? _streetName;
  String? _streetBlock;
  String? _streetBlockName;
  String? _home;
  String? _nationality;
  String? _sex;
  String? _birthDate;
  String? _email;
  String? _address;
  String? _idIssueDate;
  String? _idExpireDate;
  String? _notes;

  CustomerModel();
  CustomerModel.fromJson(Map<String, dynamic> json) {
    _custId = json['custId'];
    _firstName = json['firstName'];
    _fullName = json['fullName'];
    _telFax = json['telFax'];
    _type = json['type'];
    _idNumber = json['idNumber'];
    _areaCode = json['areaCode'];
    _province = json['province'];
    _district = json['district'];
    _precinct = json['precinct'];
    _street = json['street'];
    _streetName = json['streetName'];
    _streetBlock = json['streetBlock'];
    _streetBlockName = json['streetBlockName'];
    _home = json['home'];
    _nationality = json['nationality'];
    _sex = json['sex'];
    _birthDate = json['birthDate'];
    _email = json['email'];
    _address = json['address'];
    _idIssueDate = json['idIssueDate'];
    _idExpireDate = json['idExpireDate'];
    _notes = json['notes'];
  }

  String get notes => _notes ?? "";

  String get idExpireDate => _idExpireDate ?? "";

  String get idIssueDate => _idIssueDate ?? "";

  String get address => _address ?? "";

  String get email => _email ?? "";

  String get birthDate => _birthDate ?? "";

  String get sex => _sex ?? "";

  String get nationality => _nationality ?? "";

  String get home => _home ?? "";

  String get streetBlockName => _streetBlockName ?? "";

  String get streetBlock => _streetBlock ?? "";

  String get streetName => _streetName ?? "";

  String get street => _street ?? "";

  String get precinct => _precinct ?? "";

  String get district => _district ?? "";

  String get province => _province ?? "";

  String get areaCode => _areaCode ?? "";

  String get idNumber => _idNumber ?? "";

  String get type => _type ?? "";

  String get telFax => _telFax ?? "";

  String get fullName => _fullName ?? "";

  String get firstName => _firstName ?? "";

  int get custId => _custId ?? 0;

  String getInstalAddress(){
    return "$address, $precinct, $district, $province";
  }
}
