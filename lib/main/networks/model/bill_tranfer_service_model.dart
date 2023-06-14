class BillTransferServiceModel {
  double? transferFee;
  String? province;
  String? provinceName;
  String? district;
  String? districtName;
  String? precinct;
  String? precinctName;
  String? address;
  String? oldProvince;
  String? oldProvinceName;
  String? oldDistrict;
  String? oldDistrictName;
  String? oldPrecinct;
  String? oldPrecinctName;
  String? oldAddress;

  BillTransferServiceModel();

  BillTransferServiceModel.fromJson(Map<String, dynamic> json) {
    transferFee = json['transferFee'] ?? 0;
    province = json['province'] ?? "";
    provinceName = json['provinceName'] ?? "";
    district = json['district'] ?? "";
    districtName = json['districtName'] ?? "";
    precinct = json['precinct'] ?? "";
    precinctName = json['precinctName'] ?? "";
    address = json['address'] ?? "";
    oldProvince = json['oldProvince'] ?? "";
    oldProvinceName = json['oldProvinceName'] ?? "";
    oldDistrict = json['oldDistrict'] ?? "";
    oldDistrictName = json['oldDistrictName'] ?? "";
    oldPrecinct = json['oldPrecinct'] ?? "";
    oldPrecinctName = json['oldPrecinctName'] ?? "";
    oldAddress = json['oldAddress'] ?? "";
  }

  String getInstalAddressNew() {
    return "$address, $precinctName, $districtName, $provinceName";
  }

  String getInstalAddressOld() {
    return "$oldAddress, $oldPrecinctName, $oldDistrictName, $oldProvinceName";
  }
}
