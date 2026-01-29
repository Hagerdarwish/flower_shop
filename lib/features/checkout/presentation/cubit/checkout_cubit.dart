import 'package:bloc/bloc.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:flower_shop/features/checkout/domain/models/cash_order_model.dart';
import 'package:flower_shop/features/checkout/domain/usecases/get_addresss_usecase.dart';
import 'package:flower_shop/features/checkout/domain/usecases/post_cashe_order_usecase.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final GetAddressUsecase _getAddressUsecase;
  final PostCasheOrderUsecase _postOrderUsecase;
  final AuthStorage _authStorage;

  CheckoutCubit(
    this._postOrderUsecase,
    this._getAddressUsecase,
    this._authStorage,
  ) : super(CheckoutState());

  void doIntent(intent) {

    switch (intent) {
          case GetAllCheckoutIntents():
      _loadAddresses();
      break;
      case GetAddressIntent():
        _loadAddresses();
        break;
      case CashOrderIntent():
        _postOrder();
        break;
    }
  }

  Future<void> _loadAddresses() async {
    emit(state.copyWith(addresses: Resource.loading()));

    final token = await _authStorage.getToken();

    if (token == null) {
      emit(state.copyWith(addresses: Resource.error('Token not found')));
      return;
    }

    final result = await _getAddressUsecase("Bearer $token");

    switch (result) {
      case SuccessApiResult<List<AddressModel>>():
        emit(state.copyWith(addresses: Resource.success(result.data)));
        break;

      case ErrorApiResult<List<AddressModel>>():
        emit(
          state.copyWith(addresses: Resource.error(result.error.toString())),
        );
        break;
    }
  }

  Future<void> _postOrder() async {
    emit(state.copyWith(isLoading: true, error: null));

    final token = await _authStorage.getToken();
    if (token == null) {
      emit(state.copyWith(isLoading: false, error: 'Token not found'));
      return;
    }

    final result = await _postOrderUsecase("Bearer$token");

    switch (result) {
      case SuccessApiResult<CashOrderModel>():
        // You can also parse the returned order if your API gives full order info
        emit(state.copyWith(isLoading: false));

      case ErrorApiResult<CashOrderModel>():
        emit(state.copyWith(isLoading: false, error: result.error.toString()));
        break;
    }
  }


  void selectAddress(AddressModel address) {
  emit(state.copyWith(selectedAddress: address));
}

void changePaymentMethod(PaymentMethod method) {
  emit(state.copyWith(paymentMethod: method));
}

void toggleGift(bool value) {
  emit(state.copyWith(isGift: value));
}

}
