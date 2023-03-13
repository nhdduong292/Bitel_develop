class WorkOrderModel{
  int? _id;
  int? _idRequest;
  String? _woType;
  String? _creationDate;
  String? _expectedDate;
  String? _result;
  String? _reason;
  String? _note;
  String? _status;
  String? _cableBoxCode;
  String? _teamCode;
  String? _teamName;
  String? _staffCode;
  String? _staffName;

  WorkOrderModel();
  WorkOrderModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _idRequest = json['idRequest'];
    _woType = json['woType'];
    _creationDate = json['creationDate'];
    _expectedDate = json['expectedDate'];
    _result = json['result'];
    _reason = json['reason'];
    _note = json['note'];
    _status = json['status'];
    _cableBoxCode = json['cableBoxCode'];
    _teamCode = json['teamCode'];
    _teamCode = json['teamName'];
    _staffCode = json['staffCode'];
    _staffCode = json['staffName'];
  }

  String get staffName => _staffName ?? "";

  String get staffCode => _staffCode ?? "";

  String get teamName => _teamName ?? "";

  String get teamCode => _teamCode ?? "";

  String get cableBoxCode => _cableBoxCode ?? "";

  String get status => _status ?? "";

  String get note => _note ?? "";

  String get reason => _reason ?? "";

  String get result => _result ?? "";

  String get expectedDate => _expectedDate ?? "";

  String get creationDate => _creationDate ?? "";

  String get woType => _woType ?? "";

  int get idRequest => _idRequest ?? 0;

  int get id => _id ?? 0;
}