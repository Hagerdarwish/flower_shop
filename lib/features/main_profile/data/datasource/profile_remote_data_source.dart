import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/data/models/response/profile_response.dart';
import 'package:flower_shop/features/main_profile/data/models/about_and_terms_dto.dart';

abstract class ProfileremoteDataSource {
  Future<ApiResult<ProfileResponse>> getProfile(String token);

  Future<List<AboutAndTermsDto>> getAboutData();

  Future<List<AboutAndTermsDto>> getTerms();
}
