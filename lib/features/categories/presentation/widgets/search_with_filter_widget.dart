import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/ui_helper/assets/images.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class SearchWithFilter extends StatelessWidget {
  const SearchWithFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: SizedBox(
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: LocaleKeys.search.tr(),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 64,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(Assets.imagesFilter, color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
