import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class DeliveryTimeWidget extends StatelessWidget {
  const DeliveryTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.access_time, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.instant.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                LocaleKeys.arrive_by_datetime.tr(),
                style: const TextStyle(color: AppColors.green, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        InkWell(
          child: Text(
            LocaleKeys.schedule.tr(),
            style: const TextStyle(
              color: AppColors.pink,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
