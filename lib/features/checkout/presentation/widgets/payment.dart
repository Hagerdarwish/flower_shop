import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodTile extends StatelessWidget {
  final PaymentMethod value;
  final PaymentMethod? groupValue;
  final String title;
  final ValueChanged<PaymentMethod?> onChanged;

  const PaymentMethodTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<PaymentMethod>(
      value: value,
      groupValue: groupValue,
      activeColor: Colors.pink,
      onChanged: onChanged,
      title: Text(title),
    );
  }
}

class PaymentMethodSection extends StatelessWidget {
  final CheckoutState checkoutState;

  const PaymentMethodSection({super.key, required this.checkoutState});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.payment_method.tr(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              /// CASH
              PaymentMethodTile(
                value: PaymentMethod.cash,
                groupValue: checkoutState.paymentMethod,
                title: LocaleKeys.cash_on_delivery.tr(),
                onChanged: (method) {
                  context.read<CheckoutCubit>().doIntent(
                    ChangePaymentMethodIntent(method!),
                  );
                },
              ),

              /// CARD
              PaymentMethodTile(
                value: PaymentMethod.card,
                groupValue: checkoutState.paymentMethod,
                title: LocaleKeys.credit_card.tr(),
                onChanged: (method) {
                  context.read<CheckoutCubit>().doIntent(
                    ChangePaymentMethodIntent(method!),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
