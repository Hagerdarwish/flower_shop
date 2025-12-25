import 'package:dio/dio.dart';
import 'package:flower_shop/features/auth/data/models/response/signup_dto.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../features/auth/data/models/request/forget_password_request_model/forget_password_request_model.dart';
import '../../../features/auth/data/models/request/reset_password_request_model/reset_password_request_model.dart';
import '../../../features/auth/data/models/request/verify_reset_code_request_model/verify_reset_code_request.dart';
import '../../../features/auth/data/models/response/forget_password_response_model/forget_password_response_model.dart';
import '../../../features/auth/data/models/response/reset_password_response_model/reset_password_response_model.dart';
import '../../../features/auth/data/models/response/verify_reset_code_response_model/verify_reset_code_response_model.dart';
import '../values/app_endpoint_strings.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: AppEndpointString.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(AppEndpointString.signup)
  Future<HttpResponse<SignupDto>> signUp(@Body() Map<String, dynamic> body);

  @POST(AppEndpointString.loginEndpoint)
  Future<HttpResponse<LoginResponse>> login(@Body() LoginRequest loginRequest);


  @POST(AppEndpointString.sendEmail)
  Future<HttpResponse<ForgotPasswordResponse>> forgotPassword(
      @Body() ForgotPasswordRequest request,
      );

  @POST(AppEndpointString.verifyResetCode)
  Future<HttpResponse<VerifyResetCodeResponse>> verifyResetCode(
      @Body() VerifyResetCodeRequest request,
      );

  @PUT(AppEndpointString.resetPassword)
  Future<HttpResponse<ResetPasswordResponse>> resetPassword(
      @Body() ResetPasswordRequest request);
  }
