
import 'package:flower_shop/features/e_commerce/presentation/product%20details/widgets/product_details_body.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ProductDetailsBody()),

    );
  }

}

