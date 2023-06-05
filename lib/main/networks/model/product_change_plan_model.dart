import 'package:bitel_ventas/main/networks/model/product_model.dart';

class ProductChangePlanModel {
  ProductModel? _currentPlan;
  List<ProductModel>? _newPlan;
  String? _contractType;

  ProductChangePlanModel();

  ProductChangePlanModel.fromJson(Map<String, dynamic> json) {
    if (json['currentPlan'] != null) {
      _currentPlan = ProductModel.fromJson(json['currentPlan']);
    }
    if (json['newPlan'] != null) {
      _newPlan = (json['newPlan'] as List)
          .map((postJson) => ProductModel.fromJson(postJson))
          .toList();
    }
    _contractType = json['contractType'];
  }

  ProductModel get currentPlan {
    return _currentPlan ?? ProductModel();
  }

  List<ProductModel> get newPlan {
    return _newPlan ?? [];
  }

  String get contractType {
    return _contractType ?? '';
  }
}
