class RequestModel {
  int id = 0;
  String? service;
  String? identityType;
  String? technology;
  String? idNumber;
  String? code;
  String? name;
  String? phone;
  String? province;
  String? district;
  String? precinct;
  String? address;
  String? status;
  String? teamCode;
  String? staffCode;
  String? line;
  String? isdnAccount;
  String? createdDate;
  String? updatedDate;
  String? createdBy;
  String? updatedBy;


  RequestModel();

  RequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    identityType = json['identityType'];
    technology = json['technology'] ?? "";
    idNumber = json['idNumber'];
    code = json['code'] ?? "";
    name = json['name'];
    phone = json['phone'];
    province = json['province'];
    district = json['district'];
    precinct = json['precinct'];
    address = json['address'];
    status = json['status'];
    teamCode = json['teamCode'] ?? "";
    staffCode = json['staffCode'] ?? "";
    // line = json['line'];
    isdnAccount = json['isdnAccount'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    createdBy = json['createdBy'] ?? "";
    updatedBy = json['updatedBy'] ?? "";
  }
}
