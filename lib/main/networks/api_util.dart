import 'package:bitel_ventas/main/networks/response/base_response.dart';
import 'package:bitel_ventas/main/utils/shared_preference.dart';
import 'package:dio/dio.dart';
import 'api_interceptors.dart';

class ApiUtil {
  Dio? dio;
  static ApiUtil? _mInstance;
  CancelToken? cancelToken;

  static ApiUtil? getInstance() {
    _mInstance ??= ApiUtil();
    return _mInstance;
  }

  ApiUtil() {
    if (dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = 60000;
      dio!.options.receiveTimeout = 60000;
      dio!.interceptors.add(ApiInterceptors());
    }
    cancelToken ??= CancelToken();
  }

  void get(
      {required String url,
      Map<String, dynamic> params = const {},
      required Function(BaseResponse response) onSuccess,
      required Function(dynamic error) onError,
      bool isCancel = false}) async{
    String token = await SharedPreferenceUtil.getToken();
    if (token.isNotEmpty) {
      dio!.options.headers['Authorization'] = 'Bearer ${token}';
    }
    dio!.get(url, queryParameters: params).then((res) {
      if (onSuccess != null) onSuccess(getBaseResponse(res));
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  Future<void> getPDF({
    required String url,
    Map<String, dynamic> params = const {},
    required Function(Response success) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    String token = await SharedPreferenceUtil.getToken();
    if (token.isNotEmpty) {
      dio!.options.headers['Authorization'] = 'Bearer ${token}';
    }
    dio!.get(url, queryParameters: params).then((res) {
      if (onSuccess != null) onSuccess(res);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  Future<void> put({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic> params = const {},
    String contentType = Headers.jsonContentType,
    required Function(BaseResponse response) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    String token = await SharedPreferenceUtil.getToken();
    if (token.isNotEmpty) {
      dio!.options.headers['Authorization'] = 'Bearer ${token}';
    }
    dio!
        .put(
      url,
      queryParameters: params,
      data: body,
      options:
          Options(responseType: ResponseType.json, contentType: contentType),
    )
        .then((res) {
      if (onSuccess != null) onSuccess(getBaseResponse(res));
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  void post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic> params = const {},
    bool isDetect = false,
    String contentType = Headers.jsonContentType,
    required Function(BaseResponse response) onSuccess,
    required Function(dynamic error) onError,
  }) async{
    String token = await SharedPreferenceUtil.getToken();
    if (!isDetect) {
      if(token.isNotEmpty) {
        dio!.options.headers['Authorization'] = 'Bearer ${token}';
      }
    } else {
      dio!.options.headers['Authorization'] = 'Bearer AIzaSyDyzsELhb6aZYiMPL5NB3AZj8m7HUVFogo';
    }
    dio!
        .post(
      url,
      queryParameters: params,
      data: body,
      options:
          Options(responseType: ResponseType.json, contentType: contentType),
    )
        .then((res) {
      if (onSuccess != null) onSuccess(getBaseResponse(res));
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  BaseResponse getBaseResponse(Response response) {
    return BaseResponse.success(
        data: response.data,
        code: response.statusCode,
        message: response.statusMessage,
        status: response.data['status']);
  }
}
