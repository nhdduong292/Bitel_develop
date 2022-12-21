import 'package:dio/dio.dart';
import 'api_interceptors.dart';

class ApiUtil {
  Dio? dio;
  static ApiUtil? _mInstance;
  static ApiUtil? getInstance() {
    _mInstance ??= ApiUtil();
    return _mInstance;
  }


  ApiUtil(){
    if (dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = 60000;
      dio!.options.receiveTimeout = 20000;
      dio!.interceptors.add(ApiInterceptors());
    }
  }
  
  void get({
    required String url,
    required Map<String, dynamic> params,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }) {
    dio!.get(url, queryParameters: params).then((res) {
      if (onSuccess != null) onSuccess(res.data['data']);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  void post({required String url,
    required Map<String, dynamic> params,
    required Function(dynamic data) onSuccess,
    required Function(dynamic error) onError,
  }){
    dio!.post(url, queryParameters: params).then((res) {
      if (onSuccess != null) onSuccess(res.data['data']);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

}
