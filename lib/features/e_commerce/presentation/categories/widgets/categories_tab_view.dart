import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_cubit.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_intent.dart';
import 'package:flower_shop/features/e_commerce/presentation/categories/manager/all_categories_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTabView extends StatefulWidget {
  const CategoriesTabView({super.key});

  @override
  State<CategoriesTabView> createState() => _CategoriesTabViewState();
}

class _CategoriesTabViewState extends State<CategoriesTabView>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCategoriesCubit, AllCategoriesStates>(
      builder: (context, state) {
        final cubit = context.watch<AllCategoriesCubit>();
        final categories = cubit.categoriesList;

        if (_tabController == null ||
            _tabController!.length != categories.length) {
          _tabController?.dispose();
          _tabController = TabController(
            length: categories.length,
            vsync: this,
            initialIndex: cubit.selectedIndex,
          );

          _tabController!.addListener(() {
            if (!_tabController!.indexIsChanging) {
              cubit.doIntent(
                SelectCategoryEvent(selectedIndex: _tabController!.index),
              );
            }
          });
        }

        return SizedBox(
          height: 40,
          child: TabBar(
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            isScrollable: true,
            labelPadding: const EdgeInsets.only(right: 24),
            splashFactory: NoSplash.splashFactory,
            indicator: const BoxDecoration(),
            labelColor: AppColors.pink,
            unselectedLabelColor: AppColors.white70,
            dividerColor: Colors.transparent,
            labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
            tabs: List.generate(categories.length, (index) {
              final isSelected = index == cubit.selectedIndex;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    categories[index].name ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isSelected ? AppColors.pink : AppColors.white70,
                    ),
                  ),
                  const SizedBox(height: 6),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 3,
                    width: _textWidth(categories[index].name ?? ''),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.pink : AppColors.white70,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  double _textWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(fontSize: 14)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.size.width;
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
