import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/checkout_intents.dart';
import 'package:flower_shop/features/checkout/presentation/screens/checkout_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          context.read<CheckoutCubit>()..doIntent(GetAllCheckoutIntents()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          leading: BackButton(
            onPressed: () {
              context.push(RouteNames.home);
            },
          ),
        ),
        body: const CheckoutBody(),
      ),
    );
  }
}
