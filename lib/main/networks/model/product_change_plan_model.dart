import 'package:bitel_ventas/main/networks/model/product_model.dart';

class ProductChangePlanModel {
  ProductModel? _currentPlan;
  List<ProductModel>? _newPlan;

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
  }

  ProductModel get currentPlan {
    return _currentPlan ?? ProductModel();
  }

  List<ProductModel> get newPlan {
    return _newPlan ?? [];
  }
}
