import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/categories/presentation/manager/all_categories_cubit.dart';
import 'package:flower_shop/features/categories/presentation/manager/all_categories_intent.dart';
import 'package:flower_shop/features/categories/presentation/manager/all_categories_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCategoriesList extends StatelessWidget {
  const AllCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AllCategoriesCubit>(context);
    return BlocBuilder<AllCategoriesCubit, AllCategoriesStates>(
      builder: (context, state) {
        if (bloc.categoriesList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.pink),
          );
        }
        return SizedBox(
          height: 40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: bloc.categoriesList.length,
            separatorBuilder: (_, __) => const SizedBox(width: 24),
            itemBuilder: (context, index) {
              final isSelected = index == bloc.selectedIndex;
              final categoryName = bloc.categoriesList[index].name ?? "";
              return GestureDetector(
                onTap: () {
                  bloc.doIntent(SelectCategoryEvent(selectedIndex: index));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      categoryName,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: isSelected ? Colors.pink : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 6),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 2,
                      width: isSelected ? _textWidth(categoryName) : 0,
                      color: Colors.pink,
                    ),
                  ],
                ),
              );
            },
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
}
