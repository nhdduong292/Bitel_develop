class GoogleDetectRequest {
  final List<GoogleRequestItem> requests = [];

  void addRequest(GoogleRequestItem item) {
    requests.add(item);
  }
}

class GoogleRequestItem {
  GoogleImage? image;

  List<GoogleFeature>features = [];

  void setFeatures(List<GoogleFeature> features) {
    this.features = features;
  }

  void setImage(GoogleImage image) {
    this.image = image;
  }
}

class GoogleImage {
  String? content;

  void setContent(String content) {
    this.content = content;
  }
}

class GoogleFeature {
  String? type;

  void setType(String type) {
    this.type = type;
  }


}
enum Type {
  TEXT_DETECTION
}
