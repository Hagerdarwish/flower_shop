
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flutter/material.dart';

class OrderStatusSection extends StatelessWidget {
  final CheckoutState state;
  const OrderStatusSection({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    if (state.order.data == null) return const SizedBox.shrink();

    final order = state.order.data!;
    String statusText;
    Color statusColor;

    if (order.isDelivered) {
      statusText = 'delivered'.tr();
      statusColor = Colors.green;
    } else if (order.isPaid) {
      statusText = 'paid'.tr();
      statusColor = Colors.blue;
    } else {
      statusText = 'pending'.tr();
      statusColor = Colors.orange;
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
            'order_status'.tr(),
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

// ---------- Order Items Section ----------

