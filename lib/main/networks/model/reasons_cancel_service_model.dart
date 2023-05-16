class ReasonCancelServiceModel {
  int? id;
  String? content;

  ReasonCancelServiceModel();

  ReasonCancelServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
  }
}
