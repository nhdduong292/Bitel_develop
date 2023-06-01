import 'package:bitel_ventas/main/networks/model/customer_model.dart';
import 'package:bitel_ventas/main/networks/model/product_model.dart';

class ChangePlanInforModel {
  String? _operationCode;
  CustomerModel? _customer;
  ProductModel? _currentPlan;
  ProductModel? _newPlan;
  String? _dateOfRequest;
  String? _billCycle;
  String? _startOfNewPlan;

  ChangePlanInforModel();
  ChangePlanInforModel.fromJson(Map<String, dynamic> json) {
    _operationCode = json['operationCode'];
    if (json['customer'] != null) {
      _customer = CustomerModel.fromJson(json['customer']);
    }

    if (json['currentPlan'] != null) {
      _currentPlan = ProductModel.fromJson(json['currentPlan']);
    }

    if (json['newPlan'] != null) {
      _newPlan = ProductModel.fromJson(json['newPlan']);
    }
    _dateOfRequest = json['dateOfRequest'];
    _billCycle = json['billCycle'];
    _startOfNewPlan = json['startOfNewPlan'];
  }

  String get startOfNewPlan => _startOfNewPlan ?? "---";

  String get billCycle => _billCycle ?? "---";

  String get dateOfRequest => _dateOfRequest ?? "---";

  CustomerModel get customer => _customer ?? CustomerModel();

  String get operationCode => _operationCode ?? "---";

  ProductModel get currentPlan => _currentPlan ?? ProductModel();

  ProductModel get newPlan => _newPlan ?? ProductModel();
}
