import 'package:bitel_ventas/main/networks/model/product_model.dart';

class BillModel {
  ProductModel? _product;
  double? _speedNew;
  String? _paymentName;
  double? _fee;
  double? _installationFee;
  double? _discount;
  double? _total;

  BillModel();
  BillModel.fromJson(Map<String, dynamic> json) {
    _speedNew = json['speedNew'];
    _paymentName = json['paymentName'];
    _fee = json['fee'];
    _installationFee = json['installationFee'];
    _discount = json['discount'];
    _total = json['total'];
    if (json['product'] != null) {
      _product = ProductModel.fromJson(json['product']);
    }
  }

  ProductModel get product {
    return _product ?? ProductModel();
  }

  double get speedNew {
    return _speedNew ?? 0;
  }

  String get paymentName {
    return _paymentName ?? '---';
  }

  double get fee {
    return _fee ?? 0;
  }

  double get installationFee {
    return _installationFee ?? 0;
  }

  double get discount {
    return _discount ?? 0;
  }

  double get total {
    return _total ?? 0;
  }
}
