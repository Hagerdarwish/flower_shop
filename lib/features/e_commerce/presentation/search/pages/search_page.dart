import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/app/core/widgets/product_item_card.dart';
import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_cubit.dart';
import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_intent.dart';
import 'package:flower_shop/features/e_commerce/presentation/search/manager/products_search_states.dart';
import 'package:flower_shop/features/home/presentation/widgets/search_text_field.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  late final ProductsSearchCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = getIt<ProductsSearchCubit>();
  }

  @override
  void dispose() {
    _controller.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ProductsSearchCubit>(
        create: (context) => _cubit,
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: Column(
            children: [
              SearchTextField(
                controller: _controller,
                readOnly: false,
                onChanged: (value) {
                  if (value.trim().isNotEmpty) {
                    _cubit.doIntent(
                      GetProductsByIdIntent(search: value.trim()),
                    );
                  }
                },
                prefixOnTap: () {
                  final keyword = _controller.text.trim();
                  if (keyword.isNotEmpty) {
                    _cubit.doIntent(GetProductsByIdIntent(search: keyword));
                  }
                },
                icon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () => context.push(RouteNames.home),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.grey),
                      ),
                      child: Icon(
                        Icons.close_outlined,
                        size: 14,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 14),

              Expanded(
                child: BlocBuilder<ProductsSearchCubit, ProductsSearchStates>(
                  builder: (context, state) {
                    final products = state.products;

                    if (_controller.text.isEmpty) {
                      return Center(
                        child: Text(
                          LocaleKeys.initialSearchMsg.tr(),
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontSize: 14, color: AppColors.pink),
                        ),
                      );
                    }
                    if (products?.status == Status.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (products?.status == Status.success &&
                        (products?.data?.toList())!.isEmpty) {
                      return Center(
                        child: Text(
                          LocaleKeys.noProductsfound.tr(),
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontSize: 14, color: AppColors.grey),
                        ),
                      );
                    }

                    if (products?.status == Status.success &&
                        products?.data != null) {
                      return GridView.builder(
                        itemCount: products?.data?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 17,
                              childAspectRatio: 0.70,
                            ),
                        itemBuilder: (BuildContext context, int index) {
                          final product = products?.data?[index];
                          return ProductItemCard(
                            onTap: () {
                              context.push(
                                RouteNames.productDetails,
                                extra: product.id,
                              );
                            },
                            product: product!,
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
