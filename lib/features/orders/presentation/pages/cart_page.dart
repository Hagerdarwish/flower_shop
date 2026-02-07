import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_intent.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_states.dart';
import 'package:flower_shop/features/orders/presentation/widgets/cart_item_widget.dart';
import 'package:flower_shop/features/orders/presentation/widgets/total_price_section.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    final cartCubit = BlocProvider.of<CartCubit>(context);
    cartCubit.doIntent(GetAllCartsIntent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 50,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          iconSize: 20,
          onPressed: () {
            context.push(RouteNames.home);
          },
        ),
        title: Row(
          children: [
            Text(
              LocaleKeys.cart.tr(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.blackColor,
                fontSize: 20,
              ),
            ),
            BlocBuilder<CartCubit, CartStates>(
              builder: (context, state) {
                final itemCount = state.cart?.data?.numOfCartItems ?? 0;
                return Text(
                  '  ($itemCount ${LocaleKeys.items.tr()})',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.grey,
                    fontSize: 20,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: AppColors.grey),
                const SizedBox(width: 3),
                Text(
                  "${LocaleKeys.deliverTo.tr()} 2XVP+XC - Sheikh Zayed",
                  style: Theme.of(context).textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_down, color: AppColors.blackColor),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<CartCubit, CartStates>(
                builder: (context, state) {
                  final isLoading = state.cart?.status == Status.loading;
                  final carts = state.cart?.data?.cart?.cartItems ?? [];
                  if (!isLoading && carts.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          LocaleKeys.noProductsfound.tr(),
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: AppColors.blackColor,
                                fontSize: 16,
                              ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: isLoading ? 3 : carts.length,
                          itemBuilder: (context, index) {
                            final item = isLoading ? null : carts[index]!;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              child: CartItemWidget(
                                cartModel: item,
                                isLoading: isLoading,
                              ),
                            );
                          },
                        ),
                      ),
                      TotalPriceSection(isLoading: isLoading),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
