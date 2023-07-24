import 'package:bitel_ventas/main/networks/model/promotion_model.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';

class SubOTTModel {
  String? _ottCode;
  String? _subOttName;
  String? _status;
  String? _isdn;
  String? _description;
  double? _fee;
  bool isActive = true;
  List<PromotionModel>? _promotions;
  ExpandableController? controller;
  TextEditingController? textController;
  FocusNode? focusNode;
  String? errorText;
  bool isSuccess = false;
  String? email;

  SubOTTModel();

  SubOTTModel.fromJson(Map<String, dynamic> json) {
    if (json['promotions'] != null) {
      _promotions = (json['promotions'] as List)
          .map((item) => PromotionModel.fromJson(item))
          .toList();
    }
    _ottCode = json['ottCode'];
    _status = json['status'];
    _subOttName = json['subOttName'];
    _description = json['description'];
    _fee = json['fee'];
    _isdn = json['isdn'];

    if (_isdn != null && _isdn!.isNotEmpty) {
      isActive = true;
      isSuccess = true;
    }
  }

  List<PromotionModel> get promotions {
    return _promotions ?? [];
  }

  String get ottCode {
    return _ottCode ?? '---';
  }

  String get subOttName {
    return _subOttName ?? '---';
  }

  String get status {
    return _status ?? '---';
  }

  String get description {
    return _description ?? '---';
  }

  String get isdn {
    return _isdn ?? '---';
  }

  double get fee {
    return _fee ?? 0;
  }

  List<int> getPromotionIds() {
    List<int> promotionIds = [];
    for (var item in promotions) {
      promotionIds.add(item.proId ?? 0);
    }
    return promotionIds;
  }
}
