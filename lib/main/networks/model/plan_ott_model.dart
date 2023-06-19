import 'package:bitel_ventas/main/networks/model/sub_ott_model.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class PlanOttModel {
  String? _ottService;
  String? _ottName;
  List<SubOTTModel>? _listSubOtt;
  ExpandableController? controller;
  TextEditingController? textController;
  FocusNode? focusNode;
  String? errorText;
  bool isSuccess = false;
  String? isdn;

  PlanOttModel();

  PlanOttModel.fromJson(Map<String, dynamic> json) {
    _ottService = json['ottService'];
    _ottName = json['ottName'];
    if (json['listSubOtt'] != null) {
      _listSubOtt = (json['listSubOtt'] as List)
          .map((item) => SubOTTModel.fromJson(item))
          .toList();
    }
  }

  String get ottService {
    return _ottService ?? '---';
  }

  String get ottName {
    return _ottName ?? '---';
  }

  List<SubOTTModel> get listSubOtt {
    return _listSubOtt ?? [];
  }
}
