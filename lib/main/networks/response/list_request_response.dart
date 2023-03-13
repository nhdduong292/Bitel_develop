import 'package:bitel_ventas/main/networks/model/request_detail_model.dart';
import 'package:bitel_ventas/main/networks/model/request_model.dart';

class ListRequestResponse{
  int? total;
  int? totalPage;
  int? currentPage;
  int? pageSize;
  List<RequestDetailModel> list =[];

  ListRequestResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPage = json['totalPage'];
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    list = (json['data'] as List)
        .map((postJson) => RequestDetailModel.fromJson(postJson))
        .toList();
  }
}