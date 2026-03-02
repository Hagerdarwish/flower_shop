import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';
import 'package:flower_shop/features/main_profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAboutSectionUsecase {
  final ProfileRepo _repo;
  GetAboutSectionUsecase(this._repo);

  Future<List<AboutAndTermsModel>> call() {
    return _repo.getAboutData();
  }
}
