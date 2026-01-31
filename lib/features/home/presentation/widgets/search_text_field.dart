import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.controller,
    this.onTap,
    this.prefixOnTap,
    this.readOnly = true,
    this.icon,
    this.onChanged,
  });
  final void Function()? onTap;
  final void Function()? prefixOnTap;
  final TextEditingController? controller;
  final bool readOnly;
  final Widget? icon;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        // () {
        // showSearch(context: context, delegate: ProductsSearchDelegate());
        // },
        decoration: InputDecoration(
          hintText: LocaleKeys.search.tr(),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          suffixIcon: icon,
          prefixIcon: InkWell(
            onTap: prefixOnTap,
            child: Icon(
              Icons.search,
              size: 20,
              color: AppColors.grey.withAlpha(120),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minHeight: 40,
            minWidth: 40,
          ),
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
