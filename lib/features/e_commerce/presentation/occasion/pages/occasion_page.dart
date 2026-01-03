import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/app/core/widgets/default_error_widget.dart';
import 'package:flower_shop/app/core/widgets/product_item_card.dart';
import 'package:flower_shop/features/e_commerce/presentation/occasion/pages/shimmer_grid_loading.dart';
import 'package:flower_shop/features/home/domain/models/occasion_model.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/occasion_cubit.dart';
import '../manager/occasion_event.dart';
import '../manager/occasion_state.dart';

class OccasionPage extends StatelessWidget {
  final List<OccasionModel> occasions;

  const OccasionPage({super.key, required this.occasions});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<OccasionCubit>()
            ..doIntent(LoadInitialEvent(initialOccasion: occasions[0].id)),
      child: DefaultTabController(
        length: occasions.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.occasions.tr()),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Builder(
                builder: (context) {
                  return TabBar(
                    isScrollable: true,
                    tabs: occasions
                        .map((occasion) => Tab(text: occasion.name))
                        .toList(),
                    tabAlignment: TabAlignment.start,
                    onTap: (index) {
                      context.read<OccasionCubit>().doIntent(
                        TabChangedEvent(occasions[index].id ?? ""),
                      );
                    },
                    padding: EdgeInsets.zero,
                  );
                },
              ),
            ),
          ),

          body: BlocBuilder<OccasionCubit, OccasionState>(
            builder: (context, state) {
              final status = state.products.status;
              if (status == Status.loading) {
                return const ShimmerGridLoading();
              }
              if (status == Status.error) {
                return DefaultErrorWidget(
                  message: state.products.error,
                  onRetry: () {
                    context.read<OccasionCubit>().doIntent(
                      TabChangedEvent(state.selectedItem),
                    );
                  },
                );
              }

              final List<ProductModel> items = state.products.data ?? [];

              if (items.isEmpty) {
                return Center(child: Text(LocaleKeys.no_products_found.tr()));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: MediaQuery.of(context).size.height * .3,
                ),
                itemBuilder: (context, index) {
                  final product = items[index];
                  return ProductItemCard(product: product, onAddToCart: () {});
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
