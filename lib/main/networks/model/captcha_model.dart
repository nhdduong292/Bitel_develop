class CaptchaModel {
  String? action;
  String? base64Img;
  String? imgString;

  CaptchaModel();
  CaptchaModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    base64Img = json['base64Img'];
    imgString = json['imgString'];
  }
}
