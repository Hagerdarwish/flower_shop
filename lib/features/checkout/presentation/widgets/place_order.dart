
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderButton extends StatelessWidget {
  final CheckoutState state;
  const PlaceOrderButton({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: state.isLoading || state.selectedAddress == null
            ? null
            : () {
                context.read<CheckoutCubit>().doIntent(CashOrderIntent());
              },
        child: state.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                'place_order'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
