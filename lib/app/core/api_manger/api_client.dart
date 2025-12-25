import 'package:dio/dio.dart';
import 'package:flower_shop/features/auth/data/models/response/signup_dto.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:retrofit/retrofit.dart';
import '../values/app_endpoint_strings.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: AppEndpointString.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(AppEndpointString.signup)
  Future<HttpResponse<SignupDto>> signUp(@Body() Map<String, dynamic> body);

  @POST(AppEndpointString.loginEndpoint)
  Future<HttpResponse<LoginResponse>> login(@Body() LoginRequest loginRequest);

  }
