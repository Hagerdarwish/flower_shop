import 'package:dio/dio.dart';
import 'package:flower_shop/app/core/values/api_constants.dart';
import 'package:flower_shop/features/auth/data/models/response/logout_response_model.dart';
import 'package:flower_shop/features/auth/data/models/response/signup_dto.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';
import 'package:flower_shop/features/checkout/data/models/response/cash_order_response.dart';
import 'package:flower_shop/features/e_commerce/data/models/response/product_details_response.dart';
import 'package:flower_shop/features/edit_profile/data/models/request/editprofile_request/edit_profile_request.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/features/home/data/models/response/home_response.dart';
import 'package:flower_shop/features/orders/data/models/paymentRequest.dart';
import 'package:flower_shop/features/orders/data/models/paymentResonse.dart';
import 'package:flower_shop/features/orders/data/models/user_carts_dto.dart';
import 'package:flower_shop/features/main_profile/data/models/response/profile_response.dart';
import 'package:retrofit/retrofit.dart';
import '../../../features/addresses/data/models/address_request.dart';
import '../../../features/addresses/data/models/address_response.dart';
import '../../../features/addresses/data/models/get_address_response.dart';
import '../../../features/addresses/data/models/response/add_address_response_model.dart';
import '../../../features/addresses/data/models/response/address_model.dart';
import '../../../features/auth/data/models/request/change-password-request-models/change-password-request-model.dart';
import '../../../features/auth/data/models/request/forget_password_request_model/forget_password_request_model.dart';
import '../../../features/auth/data/models/request/reset_password_request_model/reset_password_request_model.dart';
import '../../../features/auth/data/models/request/verify_reset_code_request_model/verify_reset_code_request.dart';
import '../../../features/auth/data/models/response/change-password-response-models/change-password-response-model.dart';
import '../../../features/auth/data/models/response/forget_password_response_model/forget_password_response_model.dart';
import '../../../features/auth/data/models/response/reset_password_response_model/reset_password_response_model.dart';
import '../../../features/auth/data/models/response/verify_reset_code_response_model/verify_reset_code_response_model.dart';
import '../../../features/checkout/data/models/response/address_check_out_response.dart';
import '../../../features/e_commerce/data/models/response/all_categories_dto.dart';
import '../../../features/e_commerce/data/models/response/products_response.dart';
import '../values/app_endpoint_strings.dart';
part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

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
    @Query(ApiConstants.occasion) String? occasion,
    @Query(ApiConstants.category) String? category,
    @Query(ApiConstants.search) String? search,
  });

  @GET(AppEndpointString.allCategories)
  Future<HttpResponse<AllCategoriesDto>> getAllCategories();

  @GET(AppEndpointString.home)
  Future<HttpResponse<HomeResponse>> getHomeData();

  @GET(AppEndpointString.productDetails)
  Future<HttpResponse<ProductDetailsResponse>> getProductDetails(
    @Path(ApiConstants.id) String productId,
  );

  @GET(AppEndpointString.cartPage)
  Future<HttpResponse<UserCartsDto>> getUserCarts();

  @POST(AppEndpointString.cartPage)
  Future<HttpResponse<UserCartsDto>> addProductToCart(
    @Body() Map<String, dynamic> body,
  );

  @DELETE('${AppEndpointString.cartPage}/{${ApiConstants.id}}')
  Future<HttpResponse<UserCartsDto>> deleteCartItem(
    @Path(ApiConstants.id) String cartItemId,
  );

  @PUT('${AppEndpointString.cartPage}/{${ApiConstants.id}}')
  Future<HttpResponse<UserCartsDto>> updateCartItemQuantity(
    @Path(ApiConstants.id) String cartItemId,
    @Body() Map<String, dynamic> body,
  );

  @PATCH(AppEndpointString.changePassword)
  Future<HttpResponse<ChangePasswordResponse>> changePassword(
    @Body() ChangePasswordRequest request,
  );

  @GET(AppEndpointString.profileData)
  Future<HttpResponse<ProfileResponse>> getProfileData(
    @Header(ApiConstants.authorization) String token,
  );

  @PUT(AppEndpointString.editProfile)
  Future<HttpResponse<EditProfileResponse>> editProfile({
    @Header(ApiConstants.authorization) required String token,
    @Body() required EditProfileRequest request,
  });

  @MultiPart()
  @PUT(AppEndpointString.uploadPhoto)
  Future<HttpResponse<EditProfileResponse>> uploadPhoto({
    @Header(ApiConstants.authorization) required String token,
    @Part(name: ApiConstants.photo) required MultipartFile photo,
  });

  @GET(AppEndpointString.logout)
  Future<HttpResponse<LogoutResponse>> logout({
    @Header(ApiConstants.authorization) required String token,
  });

  @POST(AppEndpointString.cashOrder)
  Future<HttpResponse<CashOrderResponse>> cashOrder(
    @Header("Authorization") String token,
  );

  @GET(AppEndpointString.addresses)
  Future<HttpResponse<AddressCheckOutResponse>> address(
    @Header("Authorization") String token,
  );

  @POST(AppEndpointString.checkout)
  Future<HttpResponse<PaymentResponse>> checkoutOrder({
    @Header("Authorization") required String token,
    @Query("url") required String returnUrl,
    @Body() PaymentRequest? request,
  });

  @PATCH(AppEndpointString.addAddress)
  Future<HttpResponse<AddAddressResponse>> addAddress({
    @Header("Authorization") required String token,
    @Body() required AddressModel request,
  });

  @GET(AppEndpointString.addresses)
  Future<HttpResponse<GetAddressResponse>> getAddresses({
    @Header("Authorization") required String token,
  });

  @DELETE(AppEndpointString.addresses + '/{id}')
  Future<HttpResponse<AddressResponse>> deleteAddress({
    @Header("Authorization") required String token,
    @Path('id') required String addressId,
  });

  @PATCH(AppEndpointString.addresses + '/{id}')
  Future<HttpResponse<AddressResponse>> editAddress({
    @Header("Authorization") required String token,
    @Path('id') required String addressId,
    @Body() required AddressModel request,
  });
}
