import 'package:injectable/injectable.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/domain/models/home_model.dart';
import 'package:flower_shop/features/home/domain/repos/home_repo.dart';

@injectable
class HomeUsecase{
  final HomeRepo _homeRepo;
  HomeUsecase(this._homeRepo);
  Future<ApiResult<HomeModel>>call() async{
    return await _homeRepo.getHomeData();
  }
}