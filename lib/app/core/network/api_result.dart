import 'package:flower_shop/features/nav_bar/domain/models/product_model.dart';

sealed class ApiResult<T> {}

class SuccessApiResult<T> extends ApiResult<T> {
  final T data;

  SuccessApiResult( {required this.data});
}

class ErrorApiResult<T> extends ApiResult<T> {
  final String error;
  ErrorApiResult({required this.error});
}
