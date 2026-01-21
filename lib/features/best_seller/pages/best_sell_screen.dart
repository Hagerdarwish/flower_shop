import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/best_seller/menager/best_seller_intent.dart';
import 'package:flower_shop/features/home/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/features/best_seller/best_seller_card/best_seller_card.dart';
import 'package:flower_shop/features/best_seller/menager/best_sell_cubit.dart';
import 'package:flower_shop/features/best_seller/menager/best_sell_state.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';

class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  @override
  void initState() {
    super.initState();
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
                  final product = items[index];
                  return BestSellerCard(
                    product: product,
                    onTap: () {},
                    onAddToCart: () {},
                  );
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
