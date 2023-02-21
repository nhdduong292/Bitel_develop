class ReasonModel{
  int? id;
  String? objectType;
  String? content;
  int? index;
  String? active;
  String? createdDate;
  String? updatedDate;
  String? createdBy;
  String? updatedBy;


  ReasonModel();

  ReasonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    objectType = json['objectType'];
    content = json['content'];
    index = json['index'];
    active = json['active'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
  }
}