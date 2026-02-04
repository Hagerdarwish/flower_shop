import 'package:flower_shop/features/main_profile/data/models/response/orders_response.dart';
import 'package:flower_shop/features/main_profile/presentation/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OrdersList extends StatelessWidget {
  final List<Order> orders;
  const OrdersList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(child: Text("no_orders_found".tr()));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return CustomOrderItem(order: orders[index]);
      },
    );
  }
}
