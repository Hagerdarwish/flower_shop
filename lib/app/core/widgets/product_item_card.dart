import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../ui_helper/color/colors.dart';
import '../ui_helper/style/font_style.dart';

class ProductItemCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onAddToCart;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  const ProductItemCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    this.onTap,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    final originalPrice = product.price ?? 0;
    final priceAfterDiscount = product.priceAfterDiscount;

    final hasOldPrice = originalPrice > (priceAfterDiscount ?? 0);

    final discountPercentage = originalPrice > 0
        ? ((originalPrice - priceAfterDiscount!.toInt()) / originalPrice) * 100
        : 0;

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
            Expanded(
              child: ClipRRect(
                child: AspectRatio(
                  aspectRatio: 1.15,
                  child: Container(
                    color: const Color(0xFFF7E9EE),
                    child: Image.network(
                      product.imgCover.toString(),
                      fit: BoxFit.fill,
                      errorBuilder: (_, __, ___) =>
                          const Center(child: Icon(Icons.image_not_supported)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.font12BlackBold,
                  ),
                  const SizedBox(height: 6),

                  // Prices
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'EGP ${_format(priceAfterDiscount)}',
                        style: AppStyles.black14bold,
                      ),
                      const SizedBox(width: 8),
                      if (hasOldPrice)
                        Text(
                          _format(originalPrice),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const SizedBox(width: 8),

                      // if (product.discountPercent != null &&
                      //     product.discountPercent! > 0)
                      if (discountPercentage > 0)
                      Text(
                        '${discountPercentage.round()} %',
                        style: AppStyles.green14regular,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Button
            SizedBox(
              width: double.infinity,
              height: 30,
              child: ElevatedButton.icon(
                onPressed: onAddToCart,
                icon: const Icon(Icons.shopping_cart_outlined, size: 20),
                label: Text(
                  LocaleKeys.addToCard.tr(),
                  style: AppStyles.white13medium,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pink,
                  foregroundColor: Colors.white,
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

  String _format(final v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(2);
}
