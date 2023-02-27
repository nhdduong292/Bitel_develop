class WorkOrderModel{
  int? id;
  int? idRequest;
  String? woType;
  String? creationDate;
  String? expectedDate;
  String? result;
  String? reason;
  String? note;
  String? status;
  String? cableBoxCode;
  String? teamCode;
  String? staffCode;

  WorkOrderModel();
  WorkOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idRequest = json['idRequest'];
    woType = json['woType'];
    creationDate = json['creationDate'];
    expectedDate = json['expectedDate'];
    result = json['result'];
    reason = json['reason'];
    note = json['note'];
    status = json['status'];
    cableBoxCode = json['cableBoxCode'];
    teamCode = json['teamCode'];
    staffCode = json['staffCode'];
  }
}