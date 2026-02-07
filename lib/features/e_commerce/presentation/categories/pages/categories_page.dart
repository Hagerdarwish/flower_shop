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
import 'package:flower_shop/features/orders/presentation/manager/cart_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_intent.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final AllCategoriesCubit bloc = getIt<AllCategoriesCubit>();

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().doIntent(GetAllCartsIntent());
    bloc.doIntent(GetAllCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  return const Expanded(child: ShimmerGridLoading());
                }

                if (products.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Text(
                        LocaleKeys.noProductsfound.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  );
                }

                return Expanded(
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 17,
                          childAspectRatio: 0.70,
                        ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductItemCard(
                        product: product,
                        onTap: () {
                          context.push(
                            RouteNames.productDetails,
                            extra: product.id,
                          );
                        },
                      );
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
