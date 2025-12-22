import 'package:dio/dio.dart';
import 'package:flower_shop/app/features/auth/data/models/request/reset_code_request_model/reset_code_request_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/auth/data/models/request/forget_password_request_model/forget_password_request_model.dart';
import '../../features/auth/data/models/request/reset_password_request_model/reset_password_request_model.dart';
import '../../features/auth/data/models/response/forget_password_response_model/forget_password_response_model.dart';
import '../../features/auth/data/models/response/reset_code_response_model/reset_code_response_model.dart';
import '../../features/auth/data/models/response/reset_password_response_model/reset_password_response_model.dart';
import '../values/app_endpoint_strings.dart';
part 'api_client.g.dart';

@RestApi(baseUrl:AppEndpointString.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(AppEndpointString.sendEmail)
  Future<HttpResponse<ForgotPasswordResponse>> forgotPassword(
      @Body() ForgotPasswordRequest request,
      );

  @POST(AppEndpointString.resetCode)
  Future<HttpResponse<ResetCodeResponse>> verifyResetCode(
      @Body() ResetCodeRequest request,
      );
  @POST(AppEndpointString.changePassword)
  Future<HttpResponse<ResetPasswordResponse>> resetPassword(
      @Body() ResetPasswordRequest request,
      );



}