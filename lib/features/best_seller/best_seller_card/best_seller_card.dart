import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/app/core/ui_helper/style/font_style.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_intent.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellerCard extends StatelessWidget {
  final BestSellerModel product;
  final VoidCallback onAddToCart;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  const BestSellerCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    this.onTap,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount =
        product.priceAfterDiscount != null &&
        product.priceAfterDiscount! < (product.price ?? 0);

    final price = product.priceAfterDiscount ?? product.price ?? 0;
    final oldPrice = hasDiscount ? product.price : null;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            AspectRatio(
              aspectRatio: 1.15,
              child: Container(
                color: const Color(0xFFF7E9EE),
                child: Image.network(
                  product.imgCover ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.font12BlackBold,
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Text('EGP $price', style: AppStyles.black14bold),
                      const SizedBox(width: 8),
                      if (oldPrice != null)
                        Text(
                          oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 32,
              child: ElevatedButton.icon(
                onPressed: () {
                  BlocProvider.of<CartCubit>(context).doIntent(
                    AddProductToCartIntent(
                      productId: product.id.toString(),
                      quantity: 1,
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                label: Text(
                  LocaleKeys.addToCard.tr(),
                  style: AppStyles.white13medium,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pink,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
