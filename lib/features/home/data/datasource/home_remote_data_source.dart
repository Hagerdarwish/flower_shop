import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/data/models/response/home_response.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResult<HomeResponse>?> getHomeData();
}