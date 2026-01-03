import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../app/core/ui_helper/color/colors.dart';
import '../../../../../app/core/widgets/custom_button.dart';
import '../../../../../app/core/widgets/show_snak_bar.dart';
import '../manger/product_details_cubit/product_details_cubit.dart';
import 'images_slider.dart';

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final cubit = context.read<ProductDetailsCubit>();
        final resource = state.resource;
        if (resource.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.pink),
          );
        }
        if (resource.isError) {
          return Center(child: Text(resource.error ?? LocaleKeys.an_error_occurred));
        }
        final product = resource.data!;
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ImageSlider(context, product, state.selectedImageIndex),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () => context.pop(),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "EGP${product.priceAfterDiscount}",
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.copyWith(color: Colors.pink),
                        ),
                        const SizedBox(width: 8),
                        if (product.priceAfterDiscount != product.price)
                          Text(
                            "EGP ${product.price}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    Text(
                      LocaleKeys.allPricesIncludeTax,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 16
                      ),),
                    const SizedBox(height: 16),
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 120),
                    CustomButton(
                      isEnabled: true,
                      isLoading: false,
                      text: LocaleKeys.addToCard,
                      onPressed: () {
                        cubit.doIntent(const AddToCartIntent());
                        showAppSnackbar(context,LocaleKeys.productAddedToCart);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
