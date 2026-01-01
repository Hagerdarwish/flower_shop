import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/product_details/models/product_details_entity.dart';
import '../manger/product_details_cubit/product_details_cubit.dart';

Widget ImageSlider(
    BuildContext context,
    ProductDetailsEntity product,
    int selectedIndex,
    ) {
  final cubit = context.read<ProductDetailsCubit>();

  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.5,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          itemCount: product.images.length,
          controller: PageController(initialPage: selectedIndex),
          onPageChanged: (index) =>
              cubit.doIntent(ChangeImageIntent(index)),
          itemBuilder: (_, index) => SizedBox.expand(
            child: Image.network(
              product.images[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 16, // distance from bottom of image
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              product.images.length,
                  (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 12,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                  selectedIndex == index ? Colors.pink : Colors.white70,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
