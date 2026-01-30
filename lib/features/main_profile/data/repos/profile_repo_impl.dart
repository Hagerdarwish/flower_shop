import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/data/mappers/about_and_terms_dto_mapper.dart';
import 'package:flower_shop/features/main_profile/data/models/response/profile_response.dart';
import 'package:flower_shop/features/main_profile/data/datasource/profile_remote_data_source.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';
import 'package:flower_shop/features/main_profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileremoteDataSource profileRemoteDataSource;

  ProfileRepoImpl({required this.profileRemoteDataSource});

  @override
  Future<ApiResult<ProfileUserModel>> getCurrentUser(String token) async {
    final result = await profileRemoteDataSource.getProfile(token);

    if (result is SuccessApiResult<ProfileResponse>) {
      final ProfileUserModel user = result.data.toDomain();

      return SuccessApiResult(data: user);
    } else if (result is ErrorApiResult<ProfileResponse>) {
      return ErrorApiResult(error: result.error);
    } else {
      return ErrorApiResult(error: 'Unknown error');
    }
  }

  @override
  Future<List<AboutAndTermsModel>> getAboutData() async {
    final dtoList = await profileRemoteDataSource.getAboutData();
    return dtoList.map((dto) => dto.toAboutAndTermsModel()).toList();
  }

  @override
  Future<List<AboutAndTermsModel>> getTerms() async {
    final dtoList = await profileRemoteDataSource.getTerms();
    return dtoList.map((dto) => dto.toAboutAndTermsModel()).toList();
  }
}
