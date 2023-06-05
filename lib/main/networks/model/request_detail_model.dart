import 'package:bitel_ventas/main/networks/model/contract_model.dart';
import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/networks/model/subscription_model.dart';
import 'package:bitel_ventas/main/networks/model/work_order_model.dart';
import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestDetailModel {
  int? _id;
  String? _code;
  String? _service;
  String? _technology;
  String? _line;
  String? _isdnAccount;
  String? _team;
  String? _status;
  String? _province;
  String? _district;
  String? _precinct;
  String? _address;
  String? _provinceName;
  String? _districtName;
  String? _precinctName;
  CustomerModel? _customerModel;
  SubscriptionModel? _subscriptionModel;
  String? _actionType;
  ContractModel? _contractModel;
  List<WorkOrderModel>? _listWO;

  RequestDetailModel();

  RequestDetailModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _code = json['code'];
    _service = json['service'];
    _technology = json['technology'];
    _line = json['line'];
    _isdnAccount = json['isdnAccount'];
    _status = json['status'];
    _province = json['province'];
    _district = json['district'];
    _precinct = json['precinct'];
    _address = json['address'];
    _provinceName = json['provinceName'];
    _districtName = json['districtName'];
    _precinctName = json['precinctName'];
    _actionType = json['actionType'];
    if (json['customer'] != null) {
      _customerModel = CustomerModel.fromJson(json['customer']);
    }
    if (json['subscription'] != null) {
      _subscriptionModel = SubscriptionModel.fromJson(json['subscription']);
    }
    if (json['contract'] != null) {
      _contractModel = ContractModel.fromJson(json['contract']);
    }
    if (json['workOrder'] != null) {
      _listWO = (json['workOrder'] as List)
          .map((postJson) => WorkOrderModel.fromJson(postJson))
          .toList();
    }
  }

  String get service => _service ?? "";

  set service(String value) {
    _service = value;
  }

  CustomerModel get customerModel => _customerModel ?? CustomerModel();

  set customerModel(CustomerModel value) {
    _customerModel = value;
  }

  List<WorkOrderModel> get listWO => _listWO ?? [];
  //
  // set listWO(List<WorkOrderModel> value) {
  //   _listWO = value;
  // }

  ContractModel get contractModel => _contractModel ?? ContractModel();

  set contractModel(ContractModel value) {
    _contractModel = value;
  }

  SubscriptionModel get subscriptionModel =>
      _subscriptionModel ?? SubscriptionModel();
  //
  // set subscriptionModel(SubscriptionModel value) {
  //   _subscriptionModel = value;
  // }

  String get technology => _technology ?? "";

  set technology(String value) {
    _technology = value;
  }

  String get line => _line ?? "";

  set line(String value) {
    _line = value;
  }

  String get isdnAccount => _isdnAccount ?? "";

  set isdnAccount(String value) {
    _isdnAccount = value;
  }

  String get team => _team ?? "";

  set team(String value) {
    _team = value;
  }

  String get status => _status ?? "";

  set status(String value) {
    _status = value;
  }

  String get province => _province ?? "";

  set province(String value) {
    _province = value;
  }

  String get district => _district ?? "";

  set district(String value) {
    _district = value;
  }

  String get precinct => _precinct ?? "";

  set precinct(String value) {
    _precinct = value;
  }

  String get address => _address ?? "";

  set address(String value) {
    _address = value;
  }

  int get id => _id ?? 0;

  String getInstalAddress() {
    return "$address, $_precinctName, $_districtName, $_provinceName";
  }

  String get precinctName => _precinctName ?? "";

  String get districtName => _districtName ?? "";

  String get provinceName => _provinceName ?? "";

  String get code => _code ?? "";

  String get actionType => _actionType ?? "";

  String getActionType(BuildContext context) {
    if (actionType == ActionType.type_00) {
      return AppLocalizations.of(context)!.textConnectNewSubscriber;
    } else if (actionType == ActionType.type_90) {
      return AppLocalizations.of(context)!.textCancelService;
    } else {
      return '---';
    }
  }

  String getStatus(BuildContext context) {
    if (_status == null) {
      return "";
    } else {
      if (_status == RequestStatus.CREATE_REQUEST) {
        return AppLocalizations.of(context)!.textCreateRequest;
      } else if (_status == RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY) {
        return AppLocalizations.of(context)!.textCreateRequestWithout;
      } else if (_status == RequestStatus.SURVEY_OFFLINE_SUCCESSFULLY) {
        return AppLocalizations.of(context)!.textSurveyOfflineSuccess;
      } else if (_status == RequestStatus.CONTRACTING) {
        return AppLocalizations.of(context)!.textContracting;
      } else if (_status == RequestStatus.DEPLOYING) {
        return AppLocalizations.of(context)!.textDeploying;
      } else if (_status == RequestStatus.COMPLETE) {
        return AppLocalizations.of(context)!.textComplete;
      } else if (_status == RequestStatus.CANCEL) {
        return AppLocalizations.of(context)!.textCancel;
      }
      return "";
    }
  }
}
