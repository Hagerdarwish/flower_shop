import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/api_result_picker.dart';
import 'package:flower_shop/features/home/domain/models/occasion_model.dart';
import 'package:flower_shop/features/home/domain/repos/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOccasionsUseCase {
  final HomeRepo _repo;
  GetOccasionsUseCase(this._repo);

  Future<ApiResult<List<OccasionModel>>> call() async {
    final result = await _repo.getHomeData();
    return result.pick((home) => home.occasions ?? []);
  }
}
