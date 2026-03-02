import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/e_commerce/domain/models/sort_type.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_cubit.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_intent.dart';
import 'sort_radio_tile.dart';

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  SortType? selectedSort;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AllCategoriesCubit>();
    selectedSort = cubit.selectedSort;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 150,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  LocaleKeys.sortBy.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomSortTile(
              title: LocaleKeys.lowestPrice.tr(),
              isSelected: selectedSort == SortType.lowestPrice,
              onTap: () => setState(() => selectedSort = SortType.lowestPrice),
            ),
            CustomSortTile(
              title: LocaleKeys.highestPrice.tr(),
              isSelected: selectedSort == SortType.highestPrice,
              onTap: () => setState(() => selectedSort = SortType.highestPrice),
            ),
            CustomSortTile(
              title: LocaleKeys.newest.tr(),
              isSelected: selectedSort == SortType.newest,
              onTap: () => setState(() => selectedSort = SortType.newest),
            ),
            CustomSortTile(
              title: LocaleKeys.oldest.tr(),
              isSelected: selectedSort == SortType.oldest,
              onTap: () => setState(() => selectedSort = SortType.oldest),
            ),
            CustomSortTile(
              title: LocaleKeys.discount.tr(),
              isSelected: selectedSort == SortType.discount,
              onTap: () => setState(() => selectedSort = SortType.discount),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.filter_list),
                label: Text(
                  LocaleKeys.filter.tr(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (selectedSort != null) {
                    context.read<AllCategoriesCubit>().doIntent(
                      ApplySortEvent(selectedSort!),
                    );
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
