import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/domain/models/home_model.dart';

abstract class HomeRepo {
  Future<ApiResult<HomeModel>> getHomeData();
}
