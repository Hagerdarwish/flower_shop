import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_intent.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_states.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../app/core/ui_helper/color/colors.dart';
import '../../../../../app/core/widgets/custom_button.dart';
import '../../../../../app/core/widgets/show_snak_bar.dart';
import '../manger/product_details_cubit/product_details_cubit.dart';
import 'images_slider.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({super.key});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartCubit>(context).doIntent(GetAllCartsIntent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartStates>(
      listener: (context, state) {
        final cartResource = state.cart;
        if (cartResource != null) {
          if (cartResource.status == Status.success &&
              state.lastAction == CartAction.adding) {
            showAppSnackbar(context, LocaleKeys.productAddedToCart.tr());
            BlocProvider.of<CartCubit>(context).resetAction();
          } else if (cartResource.status == Status.error &&
              state.lastAction == CartAction.adding) {
            showAppSnackbar(
              context,
              cartResource.error.toString(),
              backgroundColor: AppColors.red,
            );
            BlocProvider.of<CartCubit>(context).resetAction();
          }
        }
      },
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          final resource = state.resource;
          if (resource.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.pink),
            );
          }
          if (resource.isError) {
            return Center(
              child: Text(resource.error ?? LocaleKeys.an_error_occurred),
            );
          }
          final product = resource.data!;
          return BlocBuilder<CartCubit, CartStates>(
            builder: (context, cartState) {
              final cartCubit = context.read<CartCubit>();
              final cartModel = cartCubit.cartsList.firstWhere(
                (item) => item.product?.id == product.id,
                orElse: () => CartItemsModel(),
              );

              final bool inCart = cartModel.id != null;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ImageSlider(context, product, state.selectedImageIndex),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () => context.pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "EGP${product.priceAfterDiscount}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: Colors.pink),
                              ),
                              const SizedBox(width: 8),
                              if (product.priceAfterDiscount != product.price)
                                Text(
                                  "EGP ${product.price}",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            LocaleKeys.allPricesIncludeTax,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            product.title,
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(color: Colors.black),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                          ),
                          const SizedBox(height: 120),

                          inCart
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        BlocProvider.of<CartCubit>(
                                          context,
                                        ).doIntent(
                                          UpdateCartItemQuantityIntent(
                                            cartItemId: cartModel.product!.id
                                                .toString(),
                                            quantity: cartModel.quantity!,
                                            increase: false,
                                          ),
                                        );
                                        showAppSnackbar(
                                          context,
                                          cartModel.quantity! > 1
                                              ? LocaleKeys.productUpdated.tr()
                                              : LocaleKeys
                                                    .productDeletedSuccessfully
                                                    .tr(),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.minimize,
                                        color: AppColors.blackColor,
                                        size: 30,
                                      ),
                                    ),
                                    Text(
                                      cartModel.quantity.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 26,
                                            color: AppColors.blackColor,
                                          ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        BlocProvider.of<CartCubit>(
                                          context,
                                        ).doIntent(
                                          UpdateCartItemQuantityIntent(
                                            cartItemId: cartModel.product!.id
                                                .toString(),
                                            quantity: cartModel.quantity!,
                                            increase: true,
                                          ),
                                        );
                                        showAppSnackbar(
                                          context,
                                          LocaleKeys.productUpdated.tr(),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: AppColors.blackColor,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                )
                              : CustomButton(
                                  isEnabled: true,
                                  isLoading: cartState.cart?.isLoading ?? false,
                                  text: LocaleKeys.addToCard.tr(),
                                  onPressed: () {
                                    BlocProvider.of<CartCubit>(
                                      context,
                                    ).doIntent(
                                      AddProductToCartIntent(
                                        productId: product.id.toString(),
                                        quantity: 1,
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
