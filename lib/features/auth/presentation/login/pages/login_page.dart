import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/features/auth/presentation/login/manager/login_cubit.dart';
import 'package:flower_shop/features/auth/presentation/login/widgets/login_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: const LoginPageBody(),
      ),
    );
  }
}
