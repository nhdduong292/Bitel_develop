class BestFingerModel {
  int? left;
  int? right;

  BestFingerModel();
  BestFingerModel.fromJson(Map<String, dynamic> json) {
    left = json['left'];
    right = json['right'];
  }
}
