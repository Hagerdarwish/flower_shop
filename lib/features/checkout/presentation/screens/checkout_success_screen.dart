import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  final String orderId;

  const CheckoutSuccessScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        leading: BackButton(
          color: AppColors.blackColor,
          onPressed: () => context.pop(),
        ),
        title: Text(
          LocaleKeys.track_order.tr(),
          style: const TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Success Icon with Ripple Effect
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.green.withValues(alpha: 0.1),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.green.withValues(alpha: 0.2),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.green,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Text(
                LocaleKeys.order_success.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              const Spacer(flex: 3),
              // Track Order Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushReplacement(
                      RouteNames.trackOrderScreen,
                      extra: orderId,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pink,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    LocaleKeys.track_order.tr(),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
