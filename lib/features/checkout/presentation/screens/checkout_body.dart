import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/widgets/show_snak_bar.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/address.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/delivery_time.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/gifts.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/order_status.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/payment.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/place_order.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/total_price.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_states.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutBody extends StatefulWidget {
  const CheckoutBody({super.key});

  @override
  State<CheckoutBody> createState() => _CheckoutBodyState();
}

class _CheckoutBodyState extends State<CheckoutBody> {
  final TextEditingController _giftNameController = TextEditingController();
  final TextEditingController _giftPhoneController = TextEditingController();

  @override
  void dispose() {
    _giftNameController.dispose();
    _giftPhoneController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listen for cash order success/errors
        BlocListener<CheckoutCubit, CheckoutState>(
          listenWhen: (prev, curr) =>
              prev.order != curr.order ||
              (prev.error != curr.error && curr.error != null),
          listener: (context, state) {
            if (state.order.isSuccess) {
              showAppSnackbar(
                context,
                LocaleKeys.order_success.tr(),
                backgroundColor: Colors.green,
              );
            }

            if (state.error != null) {
              showAppSnackbar(
                context,
                state.error!,
                backgroundColor: Colors.red,
              );
            }

            if (!state.order.isSuccess && state.order != Resource.initial()) {
              context.read<CheckoutCubit>().doIntent(ResetOrderIntent());
            }
          },
        ),

        BlocListener<PaymentCubit, PaymentStates>(
          listenWhen: (prev, curr) =>
              prev.paymentResponse != curr.paymentResponse,
          listener: (context, state) {
            final res = state.paymentResponse;
            if (res != null &&
                res.isSuccess &&
                res.data?.session?.url != null) {
              // Open Stripe session using url_launcher
              _launchURL(res.data!.session!.url!);
            }

            if (res != null && res.isError) {
              showAppSnackbar(context, res.error!, backgroundColor: Colors.red);
            }
          },
        ),
      ],
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          final addresses = state.addresses;

          if (addresses.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (addresses.isError) {
            return Center(
              child: Text(
                addresses.error ?? LocaleKeys.failed_load_addresses.tr(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (addresses.data?.isEmpty ?? true) {
            return Center(child: Text(LocaleKeys.no_addresses.tr()));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DeliveryTimeWidget(),
                const SizedBox(height: 24),

                AddressSection(state: state),
                const SizedBox(height: 24),

                PaymentMethodSection(checkoutState: state),
                const SizedBox(height: 24),

                GiftSection(
                  isGift: state.isGift,
                  giftNameController: _giftNameController,
                  giftPhoneController: _giftPhoneController,
                  onToggle: (val) => context.read<CheckoutCubit>().doIntent(
                    ToggleGiftIntent(val),
                  ),
                  onNameChanged: (val) => context
                      .read<CheckoutCubit>()
                      .doIntent(UpdateGiftNameIntent(val)),
                  onPhoneChanged: (val) => context
                      .read<CheckoutCubit>()
                      .doIntent(UpdateGiftPhoneIntent(val)),
                ),
                const SizedBox(height: 24),

                PlaceOrderButton(state: state),
                const SizedBox(height: 24),

                // Show order status for either cash or card
                BlocBuilder<PaymentCubit, PaymentStates>(
                  builder: (context, paymentState) {
                    final cardSuccess =
                        paymentState.paymentResponse?.isSuccess ?? false;
                    final cashSuccess =
                        state.order.isSuccess && state.order.data != null;

                    if (cardSuccess || cashSuccess) {
                      return Column(
                        children: const [
                          OrderStatusSection(), // You can pass state if needed
                          SizedBox(height: 16),
                          TotalPrice(), // Show totals
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
