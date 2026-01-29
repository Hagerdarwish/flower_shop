import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/address.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/delivery_time.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/gifts.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/order_status.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/payment.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/place_order.dart';
import 'package:flower_shop/features/orders/presentation/widgets/total_price_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutCubit, CheckoutState>(
      listenWhen: (prev, curr) =>
          prev.order != curr.order || prev.error != curr.error,
      listener: (context, state) {
        if (state.order.isSuccess) {
          showAppSnackbar(
            context,
            'order_success'.tr(),
            backgroundColor: AppColors.green,
          );
        }

        if (state.error != null) {
          showAppSnackbar(context, state.error!, backgroundColor: Colors.red);
        }
      },
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          final addresses = state.addresses;

          if (addresses.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (addresses.isError) {
            return Center(
              child: Text(
                addresses.error ?? 'failed_load_addresses'.tr(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (addresses.data?.isEmpty ?? true) {
            return Center(child: Text('no_addresses'.tr()));
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
                PaymentMethodSection(state: state),
                const SizedBox(height: 24),
                GiftSection(
                  isGift: state.isGift,
                  giftNameController: _giftNameController,
                  giftPhoneController: _giftPhoneController,
                  onToggle: (val) =>
                      context.read<CheckoutCubit>().toggleGift(val),
                  onNameChanged: (val) =>
                      context.read<CheckoutCubit>().updateGiftName(val),
                  onPhoneChanged: (val) =>
                      context.read<CheckoutCubit>().updateGiftPhone(val),
                ),
                const SizedBox(height: 24),

                // Place Order Button
                PlaceOrderButton(state: state),
                const SizedBox(height: 24),

                if (state.order.isSuccess) ...[
                  OrderStatusSection(state: state),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  TotalPriceSection(isLoading: false),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}




  void showAppSnackbar(
    BuildContext context,
    String message, {
    Color backgroundColor = AppColors.green,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: Theme.of(context).textTheme.labelSmall),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
  }
