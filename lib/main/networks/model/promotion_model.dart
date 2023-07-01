
class PromotionModel {
  int? proId;
  String? name;
  String? description;
  String? type;
  double? fee;
  double? discount;
  String? discountType;

  PromotionModel();

  PromotionModel.fromJson(Map<String, dynamic> json) {
    proId = json['proId'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    fee = json['fee'];
    discount = json['discount'];
    discountType = json['discountType'];
  }
}
