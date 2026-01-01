import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/data/datasource/home_remote_data_source.dart';
import 'package:flower_shop/features/home/data/models/response/home_response.dart';
import 'package:flower_shop/features/home/domain/models/home_model.dart';
import 'package:flower_shop/features/home/domain/repos/home_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImp extends HomeRepo{
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepoImp(this.homeRemoteDataSource);
  @override
  Future<ApiResult<HomeModel>> getHomeData() async {
    final result =await homeRemoteDataSource.getHomeData();
    if (result is SuccessApiResult<HomeResponse>) {
      return SuccessApiResult<HomeModel>(data: result.data.toEntity());
    }
    if (result is ErrorApiResult<HomeResponse>) {
      return ErrorApiResult<HomeModel>(error: result.error);
    } else {
      return ErrorApiResult<HomeModel>(error: 'Unknown error');
    }
  }
}





