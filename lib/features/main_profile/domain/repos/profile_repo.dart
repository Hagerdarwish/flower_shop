import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/data/models/response/orders_response.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';

abstract class ProfileRepo {
  Future<ApiResult<ProfileUserModel>> getCurrentUser(String token);

  Future<List<AboutAndTermsModel>> getAboutData();

  Future<List<AboutAndTermsModel>> getTerms();

  Future<ApiResult<OrderResponse>> getOrders({required String token});
}
