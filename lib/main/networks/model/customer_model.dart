class CustomerModel {
  int? custId;
  String? firstName;
  String? fullName;
  String? telFax;
  int? type;
  String? idNumber;
  String? areaCode;
  String? province;
  String? district;
  String? precinct;
  String? street;
  String? streetName;
  String? streetBlock;
  String? streetBlockName;
  String? home;
  String? nationality;
  String? sex;
  String? birthDate;
  String? email;
  String? address;
  String? idIssueDate;
  String? idExpireDate;
  String? notes;

  CustomerModel();
  CustomerModel.fromJson(Map<String, dynamic> json) {
    custId = json['custId'];
    firstName = json['firstName'];
    fullName = json['fullName'];
    telFax = json['telFax'];
    type = json['type'];
    idNumber = json['idNumber'];
    areaCode = json['areaCode'];
    province = json['province'];
    district = json['district'];
    precinct = json['precinct'];
    street = json['street'];
    streetName = json['streetName'];
    streetBlock = json['streetBlock'];
    streetBlockName = json['streetBlockName'];
    home = json['home'];
    nationality = json['nationality'];
    sex = json['sex'];
    birthDate = json['birthDate'];
    email = json['email'];
    address = json['address'];
    idIssueDate = json['idIssueDate'];
    idExpireDate = json['idExpireDate'];
    notes = json['notes'];
  }
}
