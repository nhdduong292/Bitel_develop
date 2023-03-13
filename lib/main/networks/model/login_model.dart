class LoginModel{
  String? _token;
  String? _tokenType;
  LoginModel();
  LoginModel.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
    _tokenType = json['tokenType'];
  }

  String get tokenType => _tokenType ?? "";

  String get token => _token ?? "";
}