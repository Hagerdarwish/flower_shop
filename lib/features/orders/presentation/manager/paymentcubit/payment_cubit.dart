import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/orders/data/models/paymentResonse.dart';
import 'package:flower_shop/features/orders/domain/usecase/payment_usecase.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_intent.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentCubit extends Cubit<PaymentStates> {
  final PaymentUsecase _paymentUsecase;
  final AuthStorage _authStorage;

  PaymentCubit(this._paymentUsecase, this._authStorage)
    : super(PaymentStates());

  void doIntent(PaymentIntent intent) {
    if (intent is ExecutePaymentIntent) {
      _executePayment(intent);
    }
  }

  Future<void> _executePayment(ExecutePaymentIntent intent) async {
    emit(
      state.copyWith(
        paymentResponse: Resource.loading(),
        lastAction: PaymentAction.executing,
      ),
    );

    final token = await _authStorage.getToken();

    if (token == null || token.isEmpty) {
      emit(
        state.copyWith(
          paymentResponse: Resource.error('Unauthorized'),
          lastAction: PaymentAction.none,
        ),
      );
      return;
    }

    final result = await _paymentUsecase.call(
      token: token,
      returnUrl: intent.returnUrl,
      street: intent.street,
      phone: intent.phone,
      city: intent.city,
      lat: intent.lat,
      long: intent.long,
    );

    if (result is SuccessApiResult<PaymentResponse>) {
      emit(
        state.copyWith(
          paymentResponse: Resource.success(result.data),
          lastAction: PaymentAction.none,
        ),
      );
    } else if (result is ErrorApiResult<PaymentResponse>) {
      emit(
        state.copyWith(
          paymentResponse: Resource.error(result.error),
          lastAction: PaymentAction.none,
        ),
      );
    }
  }

  void resetAction() {
    emit(state.copyWith(lastAction: PaymentAction.none));
  }
}
