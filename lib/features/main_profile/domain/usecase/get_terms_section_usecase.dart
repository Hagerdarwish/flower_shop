import 'package:flower_shop/features/main_profile/domain/models/about_and_terms_model.dart';
import 'package:flower_shop/features/main_profile/domain/repos/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTermsSectionUsecase {
  final ProfileRepo _repo;
  GetTermsSectionUsecase(this._repo);

  Future<List<AboutAndTermsModel>> call() async {
    return await _repo.getTerms();
  }
}
