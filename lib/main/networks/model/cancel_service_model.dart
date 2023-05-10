import 'package:bitel_ventas/main/networks/model/product_model.dart';

class CancelServiceModel {
  bool? _isDebt;
  double? _debt;
  bool? _isPenalty;
  ProductModel? _product;
  int? _commitmentMonth;
  String? _cancelDate;
  double? _totalPenalty;
  int? _cancelOrderId;

  CancelServiceModel();
  CancelServiceModel.fromJson(Map<String, dynamic> json) {
    _isDebt = json['isDebt'];
    _debt = json['debt'];
    _isPenalty = json['isPenalty'];

    if (json['product'] != null) {
      _product = ProductModel.fromJson(json['product']);
    }

    _commitmentMonth = json['commitmentMonth'];
    _cancelDate = json['cancelDate'];
    _totalPenalty = json['totalPenalty'];
    _cancelOrderId = json['cancelOrderId'];
  }

  bool get isDebt => _isDebt ?? false;

  double get debt => _debt ?? 0;

  bool get isPenalty => _isPenalty ?? false;

  ProductModel get product => _product ?? ProductModel();

  int get commitmentMonth => _commitmentMonth ?? 0;

  String get cancelDate => _cancelDate ?? "---";

  double get totalPenalty => _totalPenalty ?? 0;

  int get cancelOrderId => _cancelOrderId ?? 0;
}
