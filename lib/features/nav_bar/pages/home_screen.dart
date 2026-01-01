import 'package:flower_shop/app/core/app_constants.dart';
import 'package:flower_shop/features/best_seller/data/fake_data.dart';
import 'package:flower_shop/features/bset_sell/cubit/best_sell_cubit.dart';
import 'package:flower_shop/features/bset_sell/cubit/pages/best_sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppConstants.welcomeMessage),
            Text(AppConstants.home),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => BestSellerCubit(FakeProducts.products),
                      child: const BestSellScreen(),
                    ),
                  ),
                );
              },
              child: const Text('Go to Best Seller screen'),
            ),
          ],
        ),
      ),
    );
  }
}
