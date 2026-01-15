import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/data/datasource/orders_remote_datasource.dart';
import 'package:flower_shop/features/orders/data/mappers/user_carts_dto_mapper.dart';
import 'package:flower_shop/features/orders/data/models/user_carts_dto.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flower_shop/features/orders/domain/repos/orders_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRepo)
class OrdersRepoImpl implements OrdersRepo {
  OrdersRemoteDatasource ordersDatasource;
  OrdersRepoImpl(this.ordersDatasource);
  @override
  Future<ApiResult<UserCartsModel>> getUserCarts() async {
    ApiResult<UserCartsDto> response = await ordersDatasource.getUserCarts();

    switch (response) {
      case SuccessApiResult<UserCartsDto>():
        UserCartsDto dto = response.data;
        UserCartsModel cartsModel = dto.toUserCartsModel();
        return SuccessApiResult<UserCartsModel>(data: cartsModel);
      case ErrorApiResult<UserCartsDto>():
        return ErrorApiResult<UserCartsModel>(error: response.error);
    }
  }
}
