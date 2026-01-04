import 'package:dio/dio.dart';
import 'package:flower_shop/features/auth/data/models/response/signup_dto.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/product_details_response.dart';
import 'package:flower_shop/features/home/data/models/response/home_response.dart';
import 'package:retrofit/retrofit.dart';
import '../../../features/auth/data/models/request/forget_password_request_model/forget_password_request_model.dart';
import '../../../features/auth/data/models/request/reset_password_request_model/reset_password_request_model.dart';
import '../../../features/auth/data/models/request/verify_reset_code_request_model/verify_reset_code_request.dart';
import '../../../features/auth/data/models/response/forget_password_response_model/forget_password_response_model.dart';
import '../../../features/auth/data/models/response/reset_password_response_model/reset_password_response_model.dart';
import '../../../features/auth/data/models/response/verify_reset_code_response_model/verify_reset_code_response_model.dart';
import '../../../features/e_commerce/data/models/response/all_categories_dto.dart';
import '../../../features/e_commerce/data/models/response/products_response.dart';
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
    @Body() ResetPasswordRequest request,
  );

  @GET(AppEndpointString.getProduct)
  Future<HttpResponse<ProductsResponse>> getProducts({
    @Query("occasion") String? occasion,
    @Query("category") String? category,
  });

  @GET(AppEndpointString.allCategories)
  Future<HttpResponse<AllCategoriesDto>> getAllCategories();

  @GET(AppEndpointString.home)
  Future<HttpResponse<HomeResponse>> getHomeData();

  @GET(AppEndpointString.productDetails)
  Future<HttpResponse<ProductDetailsResponse>> getProductDetails(
    @Path('id') String productId,
  );
}
