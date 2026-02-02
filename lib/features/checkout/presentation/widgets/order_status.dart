import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/features/orders/presentation/manager/paymentcubit/payment_states.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class OrderStatusSection extends StatelessWidget {
  final CheckoutState? checkoutState;
  final PaymentStates? paymentState;

  const OrderStatusSection({this.checkoutState, this.paymentState, super.key});

  @override
  Widget build(BuildContext context) {
    String? statusText;
    Color? statusColor;

    // First, check cash order
    if (checkoutState != null &&
        checkoutState!.order.isSuccess &&
        checkoutState!.order.data != null) {
      final order = checkoutState!.order.data!;
      if (order.isDelivered) {
        statusText = LocaleKeys.delivered.tr();
        statusColor = Colors.green;
      } else if (order.isPaid) {
        statusText = LocaleKeys.paid.tr();
        statusColor = Colors.blue;
      } else {
        statusText = LocaleKeys.pending.tr();
        statusColor = Colors.orange;
      }
    }

    // If no cash order, check card payment success
    if ((statusText == null || statusColor == null) &&
        paymentState != null &&
        paymentState!.paymentResponse?.isSuccess == true) {
      statusText = LocaleKeys.paid.tr(); // Card payment means paid
      statusColor = Colors.blue;
    }

    if (statusText == null || statusColor == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.order_status.tr(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            statusText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }
}
