import 'dart:io';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';
import 'package:flower_shop/features/main_profile/data/models/response/profile_response.dart';

abstract class ProfileremoteDataSource {
  Future<ApiResult<ProfileResponse>> getProfile();
}
