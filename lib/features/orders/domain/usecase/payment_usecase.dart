import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/data/models/paymentResonse.dart';
import 'package:flower_shop/features/orders/domain/repos/orders_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentUsecase {
  final OrdersRepo ordersRepo;
  PaymentUsecase(this.ordersRepo);

  Future<ApiResult<PaymentResponse>> call({
    String? street,
    String? phone,
    String? city,
    String? lat,
    String? long,
    required String token,
    required String returnUrl,
  }) async {
    return await ordersRepo.payment(
      returnUrl: returnUrl,
      token: token,
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
    );
  }
}
