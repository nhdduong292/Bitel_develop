class StaffModel {
  int? staffId;
  String? staffCode;
  String? name;

  StaffModel();

  StaffModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staffId'];
    name = json['name'];
    staffCode = json['staffCode'];
    name = json['name'];
  }
}
