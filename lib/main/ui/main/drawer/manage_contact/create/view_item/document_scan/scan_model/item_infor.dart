import 'dart:ui';

class InformationCus {
  String type;
  String? content;
  Rect? rect;

  InformationCus({required this.type});

  String getContent() {
    if (content != null) {
      return content!;
    }
    return '';
  }
}
