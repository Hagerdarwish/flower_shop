import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodSection extends StatelessWidget {
  final CheckoutState state;
  const PaymentMethodSection({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'payment_method'.tr(),
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
              RadioListTile<PaymentMethod>(
                value: PaymentMethod.cash,
                groupValue: state.paymentMethod,
                activeColor: Colors.pink,
                onChanged: (val) =>
                    context.read<CheckoutCubit>().changePaymentMethod(val!),
                title: Text('cash_on_delivery'.tr()),
              ),
              RadioListTile<PaymentMethod>(
                value: PaymentMethod.card,
                groupValue: state.paymentMethod,
                activeColor: Colors.pink,
                onChanged: (val) =>
                    context.read<CheckoutCubit>().changePaymentMethod(val!),
                title: Text('credit_card'.tr()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
