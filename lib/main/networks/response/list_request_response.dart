import 'package:bitel_ventas/main/networks/model/request_model.dart';

class ListRequestResponse{
  int total = 0;
  int totalPage = 0;
  int currentPage = 0;
  int pageSize = 0;
  List<RequestModel> list =[];

  ListRequestResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPage = json['totalPage'];
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    list = (json['data'] as List)
        .map((postJson) => RequestModel.fromJson(postJson))
        .toList();
  }
}