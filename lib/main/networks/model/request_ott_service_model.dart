class RequestOTTServiceModel {
  String? ottService;
  String? ottCode;
  String? isdn;
  List<int>? promotionIds;

  RequestOTTServiceModel(
      {required this.ottService,
      required this.ottCode,
      required this.isdn,
      required this.promotionIds});

  Map<String, dynamic> toJson() {
    return {
      'ottService': ottService,
      'ottCode': ottCode,
      'isdn': isdn,
      'promotionIds': promotionIds,
    };
  }
}
