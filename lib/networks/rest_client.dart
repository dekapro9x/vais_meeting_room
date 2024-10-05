import 'package:app_base_flutter/configs//global_config.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'rest_client.g.dart';

// Chạy lệnh flutter pub run build_runner build

@RestApi(baseUrl: GlobalConfigs.kBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @MultiPart()
  @POST('/orders/refund/status')
  @MultiPart()
  Future<HttpResponse<dynamic>> refundStatus({
    @Body() required FormData refundRequest,
  });
}
