import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/main_profile/data/models/response/orders_response.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomOrderItem extends StatelessWidget {
  final Order order;
  const CustomOrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final firstItem = order.orderItems?.isNotEmpty == true
        ? order.orderItems![0]
        : null;
    final product = firstItem?.product;

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.25,
            height: screenWidth * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
              color: Colors.pink.shade50,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
              child: product?.imgCover != null
                  ? Image.network(
                      product!.imgCover!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                    )
                  : Image.asset(
                      "assets/images/flower.png",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image),
                    ),
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          // Order Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.title ??
                      "order_number".tr() + " ${order.orderNumber}",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  "egp".tr() + " ${order.totalPrice}",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueColor,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  "order_number".tr() + " ${order.orderNumber}",
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: screenWidth * 0.03),
                SizedBox(
                  width: double.infinity,
                  height: screenWidth * 0.1,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle track order
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pink,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      "track_order".tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
