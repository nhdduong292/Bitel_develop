import 'package:flutter/material.dart';

class SearchRequestProvider extends ChangeNotifier{
  bool _isRefresh = false;

  bool get isRefresh => _isRefresh;

  void setRefresh(bool value) {
    _isRefresh = value;
    notifyListeners();
  }
}