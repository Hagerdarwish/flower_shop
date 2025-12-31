import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/app/core/widgets/product_item_card.dart';
import 'package:flower_shop/features/nav_bar/ui/pages/occasion/manager/occasion_cubit.dart';
import 'package:flower_shop/features/nav_bar/ui/pages/occasion/manager/occasion_event.dart';
import 'package:flower_shop/features/nav_bar/ui/pages/occasion/manager/occasion_state.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import '../../../../domain/models/product_model.dart';

class OccasionPage extends StatelessWidget {
  const OccasionPage({super.key});

  static const List<Map<String, String>> occasionsMap = [
    {"name": "Wedding", "id": "673b34c21159920171827ae0"},
    {"name": "Graduation", "id": "673b351e1159920171827ae5"},
    {"name": "Birthday", "id": "673b354b1159920171827ae8"},
    {"name": "Anniversary", "id": "673b35c01159920171827aed"},
    {"name": "New Year", "id": "673b364e1159920171827af9"},
    {"name": "Valentine's Day", "id": "673b368c1159920171827afc"},
  ];

  @override
  Widget build(BuildContext context) {
    final initialId = occasionsMap.first["id"]!;

    return BlocProvider(
      create: (_) => getIt<OccasionCubit>()
        ..doIntent(LoadInitialEvent(initialOccasion: initialId)),
      child: DefaultTabController(
        length: occasionsMap.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Occasions'),

            // ✅ Use Builder to get context under BlocProvider
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Builder(
                builder: (ctx) {
                  return TabBar(
                    isScrollable: true,
                    tabs: occasionsMap
                        .map((e) => Tab(text: e["name"]))
                        .toList(),
                    onTap: (index) {
                      final id = occasionsMap[index]["id"]!;
                      ctx.read<OccasionCubit>().doIntent(TabChangedEvent(id));
                    },
                  );
                },
              ),
            ),
          ),

          body: BlocBuilder<OccasionCubit, OccasionState>(
            builder: (context, state) {
              final status = state.products.status;

              if (status == Status.loading) {
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
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final product = items[index];
                  return ProductItemCard(
                    product: product,
                    onAddToCart: () {},
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
