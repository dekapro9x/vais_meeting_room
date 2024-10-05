import 'package:app_base_flutter/common/log_utils.dart';
import 'package:app_base_flutter/configs/get_it/get_it.dart';
import 'package:app_base_flutter/configs/global_config.dart';
import 'package:app_base_flutter/configs/storages/app_prefs.dart';
import 'package:app_base_flutter/models/response_api/error_response.dart';
import 'package:app_base_flutter/networks/rest_client.dart';
import 'package:dio/dio.dart' ;
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart' hide Headers;


@lazySingleton
class DataRepository implements RestClient {
  final dio = Dio();
  RestClient? _client;
  final _appPrefs = getIt<AppPrefStorage>();
  DataRepository() {
    if (kDebugMode) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
    dio.options.contentType = Headers.jsonContentType;
    dio.options.responseType = ResponseType.json;
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';

    // Thêm cấu hình cho Dio header:
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = (await _appPrefs.getToken()) ?? 'TOKEN_USER_LOGIN';
      logWithColor('Session Token Phiên làm việc của User Login: $token', red);
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['Content-Type'] = 'application/json';
      options.headers['Accept'] = 'application/json';
      return handler.next(options);
    }));

    // Middleware Error Handling:
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          final _errorResponse = ErrorResponse.fromJson(error.response?.data);
          final _error = DioException(
            requestOptions: RequestOptions(path: ''),
            response: error.response,
            error: _errorResponse.toJson(),
          );
          return handler.reject(_error);
        },
      ),
    );
    _client = RestClient(dio, baseUrl: GlobalConfigs.kBaseUrl);
  }

  @override
  Future<HttpResponse<dynamic>> refundStatus({required FormData refundRequest}) {
    return _client!.refundStatus(
      refundRequest: refundRequest,
    );
  }
}
