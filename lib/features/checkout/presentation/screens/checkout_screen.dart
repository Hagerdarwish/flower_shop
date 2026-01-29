import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/features/checkout/presentation/screens/checkout_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: BackButton(
          onPressed: () {
            context.push(RouteNames.home);
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: CheckoutBody(),
    );
  }
}
