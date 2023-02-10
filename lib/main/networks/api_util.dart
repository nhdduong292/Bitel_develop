import 'package:bitel_ventas/main/networks/response/base_response.dart';
import 'package:dio/dio.dart';
import 'api_interceptors.dart';

class ApiUtil {
  Dio? dio;
  static ApiUtil? _mInstance;

  static ApiUtil? getInstance() {
    _mInstance ??= ApiUtil();
    return _mInstance;
  }

  ApiUtil() {
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

  void post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic> params = const {},
    String contentType = Headers.jsonContentType,
    required Function(BaseResponse response) onSuccess,
    required Function(dynamic error) onError,
  }) {
    dio!.post(url,
        queryParameters: params,
        data: body,
        options: Options(responseType: ResponseType.json, contentType: contentType),
    ).then((res) {
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
        status: response.data is Map<String, dynamic> ? response.data["status"] : null,
        errMessage: response.data is Map<String, dynamic> ? response.data["errorMessage"] : null);
  }
}
