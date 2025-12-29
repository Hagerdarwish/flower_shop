import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/app/core/widgets/product_item_card.dart';
import 'package:flower_shop/features/nav_bar/ui/pages/occasion/manager/occasion_cubit.dart';
import 'package:flower_shop/features/nav_bar/ui/pages/occasion/manager/occasion_event.dart';
import 'package:flower_shop/features/nav_bar/ui/pages/occasion/manager/occasion_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../app/config/base_state/base_state.dart';
import '../../../../domain/models/product_model.dart';
import '../manager/occasion_cubit.dart';
import '../manager/occasion_state.dart';

class OccasionPage extends StatelessWidget {
  const OccasionPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => getIt<OccasionCubit>()..doIntent(LoadInitialEvent()),
      child: Scaffold(
        body: BlocBuilder<OccasionCubit, OccasionState>(
          builder: (context, state) {
            final status = state.products.status;
            if (state == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (status == Status.error) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    state.products.error ?? 'Something went wrong',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            final List<ProductModel> items = state.products.data ?? [];

            if (items.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
              itemBuilder: (BuildContext context, int index) {
                final product =items[index];
                return ProductItemCard(product: product, onAddToCart: (){});
              },);
          },
        ),
      ),
    );
  }

}
