import 'google_detect_annotation.dart';

class GoogleDetectItem {
  GoogleDetectAnnotation? fullTextAnnotation;

  GoogleDetectItem.fromJson(Map<String, dynamic> json) {
    fullTextAnnotation =
        GoogleDetectAnnotation.fromJson(json['fullTextAnnotation']);
  }
}
