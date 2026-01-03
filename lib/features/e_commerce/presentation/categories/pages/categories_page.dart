import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/app/core/widgets/product_item_card.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_cubit.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_intent.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_states.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/widgets/categories_tab_view.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/widgets/search_with_filter_widget.dart';
import 'package:flower_shop/features/e_commerce/presentation/occasion/pages/shimmer_grid_loading.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});
  final bloc = getIt<AllCategoriesCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllCategoriesCubit>(
      create: (context) => bloc..doIntent(GetAllCategoriesEvent()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const SearchWithFilter(),
            const CategoriesTabView(),
            BlocBuilder<AllCategoriesCubit, AllCategoriesStates>(
              builder: (context, state) {
                final products = state.products?.data;
                if (state.products?.status == Status.loading ||
                    products == null) {
                  return Expanded(child: const ShimmerGridLoading());
                }
                if (products.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        LocaleKeys.noProductsfound.tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.blackColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  );
                }

                return Expanded(
                  child: GridView.builder(
                    itemCount: state.products?.data?.length ?? 0,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 17,
                          childAspectRatio: 0.70,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      final product = state.products?.data?[index];
                      return product != null
                          ? ProductItemCard(
                              onTap: () {
                                context.push(
                                  RouteNames.productDetails,
                                  extra: product.id,
                                );
                              },
                              product: product,
                              onAddToCart: () {},
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
