import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/ui_helper/assets/images.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/app/core/ui_helper/style/font_style.dart';
import 'package:flower_shop/app/core/widgets/show_snak_bar.dart';
import 'package:flower_shop/features/orders/domain/models/user_carts_model.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_intent.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.cartModel,
    this.isLoading = false,
  });
  final CartItemsModel? cartModel;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      ignoreContainers: false,
      enabled: isLoading,
      child: Container(
        height: 117,
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grey),
        ),
        child: isLoading
            ? Row(
                children: [
                  Container(width: 96, height: 100, color: AppColors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 16,
                          width: 120,
                          color: AppColors.grey,
                        ),
                        const SizedBox(height: 8),
                        Container(height: 12, width: 80, color: AppColors.grey),
                        const Spacer(),
                        Container(height: 14, width: 60, color: AppColors.grey),
                      ],
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 96,
                      height: 100,
                      color: const Color(0xFFF7E9EE),
                      child: Image.network(
                        cartModel!.product!.imgCover.toString(),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartModel!.product!.title.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 16,
                                          color: AppColors.blackColor,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    ('${cartModel!.product!.quantity.toString()} ${cartModel!.product!.title.toString()}'),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                BlocProvider.of<CartCubit>(context).doIntent(
                                  DeleteCartItemIntent(
                                    cartItemId: cartModel!.product!.id
                                        .toString(),
                                  ),
                                );
                                showAppSnackbar(
                                  context,
                                  LocaleKeys.productDeletedSuccessfully.tr(),
                                );
                              },
                              iconSize: 16,
                              icon: ImageIcon(
                                AssetImage(Assets.delete),
                                size: 16,
                                color: AppColors.red,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '${LocaleKeys.egp.tr()} ${cartModel?.product?.priceAfterDiscount}',
                              style: AppStyles.black14bold,
                            ),
                            const SizedBox(width: 8),

                            Text(
                              '${cartModel?.price}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                BlocProvider.of<CartCubit>(context).doIntent(
                                  UpdateCartItemQuantityIntent(
                                    cartItemId: cartModel!.product!.id
                                        .toString(),
                                    quantity: cartModel!.quantity!,
                                    increase: false,
                                  ),
                                );
                                showAppSnackbar(
                                  context,
                                  cartModel!.quantity! > 1
                                      ? LocaleKeys.productUpdated.tr()
                                      : LocaleKeys.productDeletedSuccessfully
                                            .tr(),
                                );
                              },
                              icon: Icon(
                                Icons.minimize,
                                color: AppColors.blackColor,
                                size: 14,
                              ),
                            ),
                            Text(
                              cartModel!.quantity.toString(),
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.blackColor,
                                  ),
                            ),
                            IconButton(
                              onPressed: () {
                                BlocProvider.of<CartCubit>(context).doIntent(
                                  UpdateCartItemQuantityIntent(
                                    cartItemId: cartModel!.product!.id
                                        .toString(),
                                    quantity: cartModel!.quantity!,
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
                                size: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
