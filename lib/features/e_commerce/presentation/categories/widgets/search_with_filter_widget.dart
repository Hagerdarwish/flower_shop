import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/app/core/ui_helper/assets/images.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_cubit.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/widgets/sort_bottom_sheet.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_intent.dart';
import 'package:flower_shop/features/home/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchWithFilter extends StatefulWidget {
  const SearchWithFilter({super.key});

  @override
  State<SearchWithFilter> createState() => _SearchWithFilterState();
}

class _SearchWithFilterState extends State<SearchWithFilter> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllCategoriesCubit>(context).ecommerceUiEventStream.listen((
      EcommerceUiEvents event,
    ) {
      if (!mounted) return;
      switch (event) {
        case OnSearchTapEvent():
          context.go(RouteNames.searchPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: SearchTextField(
              onTap: () => BlocProvider.of<AllCategoriesCubit>(
                context,
              ).doUiIntent(OnSearchTapEvent()),
            ),
          ),

          const SizedBox(width: 12),

          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (sheetContext) {
                  return BlocProvider.value(
                    value: context.read<AllCategoriesCubit>(),
                    child: const SortBottomSheet(),
                  );
                },
              );
            },
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
