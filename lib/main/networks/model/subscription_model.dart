class SubscriptionModel{
  String? implementBy;
  String? codeEnding;
  String? isdnAccount;
  String? vatService;
  String? installationDate;
  String? installationAddress;
  String? password;
  String? service;
  String? line;
  String? promotion;
  String? technology;
  String? servicePlan;
  String? typeOfSub;

  SubscriptionModel();
  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    implementBy = json['implementBy'];
    codeEnding = json['codeEnding'];
    isdnAccount = json['isdnAccount'];
    vatService = json['vatService'];
    installationDate = json['installationDate'];
    installationAddress = json['installationAddress'];
    password = json['password'];
    service = json['service'];
    line = json['line'];
    promotion = json['promotion'];
    technology = json['technology'];
    servicePlan = json['servicePlan'];
    typeOfSub = json['typeOfSub'];
  }
}