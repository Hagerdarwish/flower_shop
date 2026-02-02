import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/widgets/show_snak_bar.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/payment_method.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_intent.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_states.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceOrderButton extends StatelessWidget {
  final CheckoutState state;
  const PlaceOrderButton({required this.state, super.key});

  Future<void> _openUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentState = context.watch<PaymentCubit>().state;
    final isLoading = paymentState.paymentResponse?.isLoading ?? false;

    return BlocListener<PaymentCubit, PaymentStates>(
      listenWhen: (prev, curr) => prev.paymentResponse != curr.paymentResponse,
      listener: (context, state) {
        final res = state.paymentResponse;
        if (res != null && res.isSuccess && res.data?.session?.url != null) {
          _openUrl(res.data!.session!.url!);
        }

        if (res != null && res.isError) {
          showAppSnackbar(context, res.error!);
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),

          onPressed: isLoading
              ? null
              : () {
                  final paymentMethod = state.paymentMethod;

                  if (paymentMethod == null) {
                    showAppSnackbar(context, 'select_payment_method');
                    return;
                  }

                  if (paymentMethod == PaymentMethod.card) {
                    context.read<PaymentCubit>().doIntent(
                      ExecutePaymentIntent(
                        returnUrl: 'flower://payment-success',
                        street: state.selectedAddress?.street,
                        phone: state.selectedAddress?.phone,
                        city: state.selectedAddress?.city,
                        lat: state.selectedAddress?.lat.toString(),
                        long: state.selectedAddress?.long.toString(),
                      ),
                    );
                  } else {
                    context.read<CheckoutCubit>().doIntent(PlaceOrderIntent());
                  }
                },
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  LocaleKeys.place_order.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
