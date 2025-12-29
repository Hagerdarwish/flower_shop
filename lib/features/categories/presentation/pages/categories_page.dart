import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/features/categories/presentation/manager/all_categories_cubit.dart';
import 'package:flower_shop/features/categories/presentation/manager/all_categories_intent.dart';
import 'package:flower_shop/features/categories/presentation/manager/all_categories_states.dart';
import 'package:flower_shop/features/categories/presentation/widgets/categories_tab_view.dart';
import 'package:flower_shop/features/categories/presentation/widgets/search_with_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});
  final bloc = getIt<AllCategoriesCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AllCategoriesCubit>(
        create: (context) => bloc..doIntent(GetAllCategoriesEvent()),
        child: BlocBuilder<AllCategoriesCubit, AllCategoriesStates>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: 40),
                SearchWithFilter(),
                CategoriesTabView(),
              ],
            );
          },
        ),
      ),
    );
  }
}
