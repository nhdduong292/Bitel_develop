class GoogleDetectAnnotation {
  String? _text;

  GoogleDetectAnnotation.fromJson(Map<String, dynamic> json) {
    _text = json['text'];
  }

  String get text {
    return _text ?? '';
  }
}
