import 'dart:convert';
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/app/core/values/paths.dart';
import 'package:flower_shop/features/main_profile/data/models/response/profile_response.dart';
import 'package:flower_shop/features/main_profile/data/datasource/profile_remote_data_source.dart';
import 'package:flower_shop/features/main_profile/data/models/about_and_terms_dto.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileremoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileremoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ApiResult<ProfileResponse>> getProfile(String token) {
    return safeApiCall(call: () => apiClient.getProfileData(token));
  }

  @override
  Future<List<AboutAndTermsDto>> getAboutData() async {
    final jsonString = await rootBundle.loadString(AppPaths.aboutJsonFile);
    final decoded = json.decode(jsonString);
    final List list = decoded[AppPaths.aboutUs];

    return list.map((e) => AboutAndTermsDto.fromJson(e)).toList();
  }

  @override
  Future<List<AboutAndTermsDto>> getTerms() async {
    final jsonString = await rootBundle.loadString(AppPaths.termsJsonFile);
    final jsonMap = json.decode(jsonString);
    final list = jsonMap[AppPaths.terms] as List;
    return list.map((e) => AboutAndTermsDto.fromJson(e)).toList();
  }
}
