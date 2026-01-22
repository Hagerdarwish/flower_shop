import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/features/home/presentation/widgets/category_item.dart';
import 'package:flower_shop/features/home/presentation/widgets/home_header.dart';
import 'package:flower_shop/features/home/presentation/widgets/home_section.dart';
import 'package:flower_shop/features/home/presentation/widgets/product_item.dart';
import 'package:flower_shop/features/nav_bar/presentation/manager/nav_cubit.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/features/home/presentation/manager/home_cubit.dart';
import 'package:flower_shop/features/home/presentation/manager/home_states.dart';
import 'package:go_router/go_router.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.06),
              const HomeHeader(),
              SizedBox(height: size.height * 0.015),

              /// Categories
              HomeSection(
                title: LocaleKeys.categories.tr(),
                onTap: () {
                  context.read<NavCubit>().updateIndex(1); // Categories tab
                },
                height: size.height * 0.12,
                resource: state.categories,
                itemBuilder: (context, category) {
                  return CategoryItem(
                    image: category.image ?? "",
                    label: category.name ?? "",
                    onTap: () {},
                  );
                },
              ),

              /// Best Sellers
              HomeSection(
                title: LocaleKeys.bestSelling.tr(),
                onTap: () {
                  context.push(RouteNames.bestSeller);

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => CatecoryScreen(
                  //       title: LocaleKeys.categories.tr(),
                  //       items: state.categories.data ?? [],
                  //       itemBuilder: (context, category) {
                  //         return CategoryItem(
                  //           image: category.image ?? "",
                  //           label: category.name ?? "",
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // );
                },
                height: size.height * 0.30,
                resource: state.bestSeller,
                itemBuilder: (context, bestSeller) {
                  return ProductItem(
                    imageUrl: bestSeller.imgCover ?? "",
                    title: bestSeller.title ?? "",
                    price: bestSeller.price?.toString(),
                    onTap: () {
                      context.push(
                        RouteNames.productDetails,
                        extra: bestSeller.id,
                      );
                    },
                  );
                },
              ),

              /// Occasions
              HomeSection(
                title: LocaleKeys.occasions.tr(),
                onTap: () {
                  context.push(
                    RouteNames.occasionPage,
                    extra: state.occasions.data ?? [],
                  );
                },
                height: size.height * 0.28,
                resource: state.occasions,
                itemBuilder: (context, occasion) {
                  return ProductItem(
                    imageUrl: occasion.image ?? "",
                    title: occasion.name ?? "",
                    onTap: () {},
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
