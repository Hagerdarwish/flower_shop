import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/app/core/widgets/product_item_card.dart';
import 'package:flower_shop/features/best_seller/menager/best_seller_intent.dart';
import 'package:flower_shop/features/home/presentation/widgets/search_text_field.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/features/best_seller/menager/best_sell_cubit.dart';
import 'package:flower_shop/features/best_seller/menager/best_sell_state.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:go_router/go_router.dart';

class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().doIntent(GetAllCartsIntent());
    context.read<BestSellerCubit>().doIntent(LoadBestSellersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        elevation: 0,
        title: SearchTextField(),
      ),
      body: BlocBuilder<BestSellerCubit, BestSellerState>(
        builder: (context, state) {
          final productsResource = state.products;

          switch (productsResource.status) {
            case Status.initial:
            case Status.loading:
              return const Center(child: CircularProgressIndicator());

            case Status.success:
              final items = productsResource.data ?? [];
              if (items.isEmpty) {
                return Center(child: Text(LocaleKeys.no_products_found.tr()));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  final bestSeller = state.products.data?[index];
                  return bestSeller != null
                      ? ProductItemCard(
                          product: bestSeller.toProductModel(),
                          onTap: () {
                            context.push(
                              RouteNames.productDetails,
                              extra: bestSeller.id,
                            );
                          },
                        )
                      : const SizedBox.shrink();
                },
              );

            case Status.error:
              return Center(child: Text(productsResource.message ?? 'Error'));
          }
        },
      ),
    );
  }
}
