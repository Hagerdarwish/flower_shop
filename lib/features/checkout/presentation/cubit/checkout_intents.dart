import 'package:flower_shop/features/checkout/domain/models/address_model.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';

class CheckoutIntents {}

class GetAllCheckoutIntents extends CheckoutIntents {}

class GetAddressIntent extends CheckoutIntents {}

class CashOrderIntent extends CheckoutIntents {}

class CreditOrderIntent extends CheckoutIntents {}

class SelectAddressIntent extends CheckoutIntents {
  final AddressModel address;
  SelectAddressIntent(this.address);
}

class PlaceOrderIntent extends CheckoutIntents {}

class ChangePaymentMethodIntent extends CheckoutIntents {
  final PaymentMethod method;
  ChangePaymentMethodIntent(this.method);
}

class ToggleGiftIntent extends CheckoutIntents {
  final bool isGift;
  ToggleGiftIntent(this.isGift);
}

class UpdateGiftNameIntent extends CheckoutIntents {
  final String name;
  UpdateGiftNameIntent(this.name);
}

class UpdateGiftPhoneIntent extends CheckoutIntents {
  final String phone;
  UpdateGiftPhoneIntent(this.phone);
}

class ResetOrderIntent extends CheckoutIntents {}
