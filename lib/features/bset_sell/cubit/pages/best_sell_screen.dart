import 'package:flower_shop/app/core/widgets/product_item_card.dart';
import 'package:flower_shop/features/bset_sell/cubit/best_sell_cubit.dart';
import 'package:flower_shop/features/bset_sell/cubit/best_sell_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellScreen extends StatelessWidget {
  const BestSellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Best seller')),
      body: BlocBuilder<BestSellerCubit, BestSellerState>(
        builder: (context, state) {
          if (state is BestSellerLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.products.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, index) {
                final product = state.products[index];

                return ProductItemCard(
                  product: product,
                  onTap: () {
                    // navigate to product details
                  },
                  onAddToCart: () {
                    // context.read<CartCubit>().addToCart(product);
                  },
                );
              },
            );
          }

          if (state is BestSellerEmpty) {
            return const Center(child: Text('No best sellers available'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
