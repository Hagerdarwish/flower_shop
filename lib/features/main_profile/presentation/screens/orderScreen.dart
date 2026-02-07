import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';

import 'package:flower_shop/features/main_profile/presentation/cubit/oerdercubit/order_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/oerdercubit/order_state.dart';
import 'package:flower_shop/features/main_profile/presentation/widgets/orderList.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class Orderscreen extends StatelessWidget {
  const Orderscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("myOrders".tr()),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: AppColors.pink,
            labelColor: AppColors.pink,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "active".tr()),
              Tab(text: "completed".tr()),
            ],
          ),
        ),
        body: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            final ordersResource = state.orders;

            switch (ordersResource.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.error:
                return Center(child: Text(ordersResource.error ?? "Error"));
              case Status.success:
                final allOrders = ordersResource.data?.orders ?? [];

                final activeOrders = allOrders
                    .where((o) => o.isDelivered == false)
                    .toList();
                final completedOrders = allOrders
                    .where((o) => o.isDelivered == true)
                    .toList();

                return TabBarView(
                  children: [
                    OrdersList(orders: activeOrders),
                    OrdersList(orders: completedOrders),
                  ],
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
