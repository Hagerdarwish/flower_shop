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

  void doIntent(CheckoutIntents intent) {
    switch (intent) {
      case GetAllCheckoutIntents():
      case GetAddressIntent():
        _loadAddresses();
        break;

      case CashOrderIntent():
        _postCashOrder();
        break;

      case CreditOrderIntent():
        _postCreditOrder();
        break;

      case PlaceOrderIntent():
        _placeOrder();
        break;

      case SelectAddressIntent():
        emit(state.copyWith(selectedAddress: intent.address));
        break;

      case ChangePaymentMethodIntent():
        emit(state.copyWith(paymentMethod: intent.method));
        break;

      case ToggleGiftIntent():
        emit(state.copyWith(isGift: intent.isGift));
        break;

      case UpdateGiftNameIntent():
        emit(state.copyWith(giftName: intent.name));
        break;

      case UpdateGiftPhoneIntent():
        emit(state.copyWith(giftPhone: intent.phone));
        break;
      case ResetOrderIntent():
        emit(
          state.copyWith(
            order: Resource.initial(),
            error: null,
            isLoading: false,
          ),
        );
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

  Future<void> _postCashOrder() async {
    emit(state.copyWith(isLoading: true, error: null));

    final token = await _authStorage.getToken();
    if (token == null) {
      emit(state.copyWith(isLoading: false, error: 'Token not found'));
      return;
    }

    final result = await _postOrderUsecase("Bearer $token");

    switch (result) {
      case SuccessApiResult<CashOrderModel>():
        emit(
          state.copyWith(
            isLoading: false,
            order: Resource.success(result.data),
          ),
        );
        break;

      case ErrorApiResult<CashOrderModel>():
        emit(
          state.copyWith(
            isLoading: false,
            error: result.error.toString(),
            order: Resource.error(result.error.toString()),
          ),
        );
        break;
    }
  }

  Future<void> _postCreditOrder() async {
    // TODO: integrate credit card API
  }

  void _placeOrder() {
    if (state.paymentMethod == null) {
      emit(state.copyWith(error: 'Please select payment method'));
      return;
    }

    if (state.paymentMethod == PaymentMethod.cash) {
      doIntent(CashOrderIntent());
    } else {
      doIntent(CreditOrderIntent());
    }
  }
}
