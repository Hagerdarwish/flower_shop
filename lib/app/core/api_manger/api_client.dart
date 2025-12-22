import 'package:dio/dio.dart';
import 'package:flower_shop/features/auth/data/models/signup_dto.dart';
import 'package:retrofit/retrofit.dart';
import '../values/app_endpoint_strings.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: AppEndpointString.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(AppEndpointString.signup)
  Future<HttpResponse<SignupDto>> signUp(@Body() Map<String, dynamic> body);
}
