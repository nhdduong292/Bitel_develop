class SearchClearDebtModel {
  int? total;
  int? totalPage;
  int? currentPage;
  int? pageSize;
  dynamic data;

  SearchClearDebtModel();
  SearchClearDebtModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPage = json['totalPage'];
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    data = json['data']['data'];
  }
}
