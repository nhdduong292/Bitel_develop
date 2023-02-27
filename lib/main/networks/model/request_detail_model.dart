import 'package:bitel_ventas/main/networks/model/contract_model.dart';
import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/networks/model/subscription_model.dart';
import 'package:bitel_ventas/main/networks/model/work_order_model.dart';

class RequestDetailModel{
  int id = 0;
  String? service;
  String? technology;
  String? line;
  String? isdnAccount;
  String? team;
  String? status;
  String? province;
  String? district;
  String? precinct;
  String? address;
  CustomerModel? customerModel;
  SubscriptionModel? subscriptionModel;
  ContractModel? contractModel;
  List<WorkOrderModel> listWO = [];

  RequestDetailModel();

  RequestDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    technology = json['technology'];
    line = json['line'];
    isdnAccount = json['isdnAccount'];
    status = json['status'];
    status = json['status'];
    province = json['province'];
    district = json['district'];
    precinct = json['precinct'];
    address = json['address'];
    customerModel = CustomerModel.fromJson(json['customer']);
    subscriptionModel = SubscriptionModel.fromJson(json['subscription']);
    contractModel = ContractModel.fromJson(json['contract']);

    listWO = (json['workOrder'] as List)
        .map((postJson) => WorkOrderModel.fromJson(postJson))
        .toList();
  }

}