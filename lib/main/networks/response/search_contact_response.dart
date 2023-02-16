import 'package:bitel_ventas/main/networks/model/contact_model.dart';

class SearchContactResponse{
  int? total;
  int? totalPage;
  int? currentPage;
  int? pageSize;
  List<ContactModel> list =[];

  SearchContactResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPage = json['totalPage'];
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    list = (json['data'] as List)
        .map((postJson) => ContactModel.fromJson(postJson))
        .toList();
  }
}