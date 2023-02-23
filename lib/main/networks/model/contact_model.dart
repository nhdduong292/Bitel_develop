class ContactModel{
  int? id;
  String? identityType;
  String? idNumber;
  String? firstname;
  String? lastName;
  String? nationality;
  String? sex;
  String? dateOfBirth;
  String? expiredDate;
  String? phoneNumber;
  String? email;
  String? address;
  String? note;

  ContactModel();

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    identityType = json['identityType'];
    idNumber = json['idNumber'];
    firstname = json['firstname'];
    lastName = json['lastName'];
    nationality = json['nationality'];
    sex = json['sex'];
    dateOfBirth = json['dateOfBirth'];
    expiredDate = json['expiredDate'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    note = json['note'];
  }

  @override
  String toString() {
    return 'ContactModel{id: $id, identityType: $identityType, idNumber: $idNumber, firstname: $firstname, lastName: $lastName, nationality: $nationality, sex: $sex, dateOfBirth: $dateOfBirth, expiredDate: $expiredDate, phoneNumber: $phoneNumber, email: $email, address: $address, note: $note}';
  }
}