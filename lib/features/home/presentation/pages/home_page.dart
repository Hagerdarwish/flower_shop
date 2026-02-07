import 'package:flower_shop/features/home/presentation/widgets/home_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/features/home/presentation/manager/home_cubit.dart';
import 'package:flower_shop/features/home/presentation/manager/home_intent.dart';
import 'package:flower_shop/app/config/di/di.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..doIntent(LoadHomeData()),
      child: const Scaffold(body: HomePageBody()),
    );
  }
}
