import 'package:bitel_ventas/main/networks/model/request_model.dart';

class ListRequestResponse{
  int? total;
  int? totalPage;
  int? currentPage;
  int? pageSize;
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