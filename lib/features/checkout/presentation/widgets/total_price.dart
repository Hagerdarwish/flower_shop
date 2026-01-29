import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/app/core/widgets/custom_button.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TotalPriceSection extends StatelessWidget {
  const TotalPriceSection({super.key, this.isLoading = false});
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        // Use CheckoutCubit state values
        final subTotal = state.subTotal;
        final deliveryFee = state.deliveryFee;
        final total = state.total;

        return Skeletonizer(
          enabled: isLoading,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.subTotal.tr(),
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "${subTotal.toStringAsFixed(0)}\$",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.deliveryFee.tr(),
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "$deliveryFee\$",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Divider(color: AppColors.white70, thickness: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.total.tr(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    "${total.toStringAsFixed(0)}\$",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
            ],
          ),
        );
      },
    );
  }
}
