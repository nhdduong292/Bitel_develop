import 'package:bitel_ventas/main/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RequestModel {
  int? _id;
  String? _service;
  String? _identityType;
  String? _technology;
  String? _idNumber;
  String? _code;
  String? _name;
  String? _phone;
  String? _province;
  String? _district;
  String? _precinct;
  String? _address;
  String? _status;
  String? _teamCode;
  String? _staffCode;
  String? _line;
  String? _isdnAccount;
  String? _createdDate;
  String? _updatedDate;
  String? _createdBy;
  String? _updatedBy;
  String? _provinceName;
  String? _districtName;
  String? _precinctName;


  RequestModel();

  RequestModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _service = json['service'];
    _identityType = json['identityType'];
    _technology = json['technology'];
    _idNumber = json['idNumber'];
    _code = json['code'];
    _name = json['name'];
    _phone = json['phone'];
    _province = json['province'];
    _district = json['district'];
    _precinct = json['precinct'];
    _address = json['address'];
    _status = json['status'];
    _teamCode = json['teamCode'];
    _staffCode = json['staffCode'];
    // line = json['line'];
    _isdnAccount = json['isdnAccount'];
    _createdDate = json['createdDate'];
    _updatedDate = json['updatedDate'];
    _createdBy = json['createdBy'];
    _updatedBy = json['updatedBy'];
    _provinceName = json['provinceName'];
    _districtName = json['districtName'];
    _precinctName = json['precinctName'];

  }

  String get updatedBy => _updatedBy ?? "";

  set updatedBy(String value) {
    _updatedBy = value;
  }

  String get createdBy => _createdBy ?? "";

  set createdBy(String value) {
    _createdBy = value;
  }

  String get updatedDate => _updatedDate ?? "";

  set updatedDate(String value) {
    _updatedDate = value;
  }

  String get createdDate => _createdDate ?? "";

  set createdDate(String value) {
    _createdDate = value;
  }

  String get isdnAccount => _isdnAccount ?? "";

  set isdnAccount(String value) {
    _isdnAccount = value;
  }

  String get line => _line ?? "";

  set line(String value) {
    _line = value;
  }

  String get staffCode => _staffCode ?? "";

  set staffCode(String value) {
    _staffCode = value;
  }

  String get teamCode => _teamCode ?? "";

  set teamCode(String value) {
    _teamCode = value;
  }

  String getStatus(BuildContext context){

    if(_status == null) {
      return "";
    } else {
      if(_status == RequestStatus.CREATE_REQUEST){
        return AppLocalizations.of(context)!.textCreateRequest;
      } else if(_status == RequestStatus.CREATE_REQUEST_WITHOUT_SURVEY){
        return AppLocalizations.of(context)!.textCreateRequestWithout;
      } else if(_status == RequestStatus.SURVEY_OFFLINE_SUCCESSFULLY){
        return AppLocalizations.of(context)!.textSurveyOfflineSuccess;
      } else if(_status == RequestStatus.CONNECTED){
        return AppLocalizations.of(context)!.textConnected;
      } else if(_status == RequestStatus.DEPLOYING){
        return AppLocalizations.of(context)!.textDeploying;
      } else if(_status == RequestStatus.COMPLETE){
        return AppLocalizations.of(context)!.textComplete;
      } else if(_status == RequestStatus.CANCEL){
        return AppLocalizations.of(context)!.textCancel;
      }
      return "";
    }
  }

  set status(String value) {
    _status = value;
  }

  String get address => _address ?? "";

  set address(String value) {
    _address = value;
  }

  String get precinct => _precinct ?? "";

  set precinct(String value) {
    _precinct = value;
  }

  String get district => _district ?? "";

  set district(String value) {
    _district = value;
  }

  String get province => _province ?? "";

  set province(String value) {
    _province = value;
  }

  String get phone => _phone ?? "";

  set phone(String value) {
    _phone = value;
  }

  String get name => _name ?? "";

  set name(String value) {
    _name = value;
  }

  String get code => _code ?? "";

  set code(String value) {
    _code = value;
  }

  String get idNumber => _idNumber ?? "";

  set idNumber(String value) {
    _idNumber = value;
  }

  String get technology => _technology ?? "";

  set technology(String value) {
    _technology = value;
  }

  String get identityType => _identityType ?? "";

  set identityType(String value) {
    _identityType = value;
  }

  String get service => _service ?? "";

  set service(String value) {
    _service = value;
  }

  int get id => _id?? 0;

  set id(int value) {
    _id = value;
  }

  String getInstalAddress(){
    return "$address, $precinctName, $districtName, $provinceName";
  }

  String get precinctName => _precinctName ?? "";

  String get districtName => _districtName ?? "";

  String get provinceName => _provinceName ?? "";
}
