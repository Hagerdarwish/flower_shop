import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/core/app_constants.dart';
import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_state.dart';
import 'package:flower_shop/features/main_profile/presentation/widgets/guest_screen.dart';
import 'package:flower_shop/features/main_profile/presentation/widgets/profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final userState = state.user;

        if (userState!.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (userState.isError) {
          if (_isTokenError(userState.message)) {
            // Defer side effects
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<AuthStorage>().clearToken();
            });

            return GuestProfileScreen(
              onLoginPressed: () {
                context.go(AppConstants.login);
              },

              onRegisterPressed: () {
                context.go(AppConstants.register);
              },
              onContinueAsGuest: () {
                context.go(AppConstants.home);
              },
            );
          }
        }

        if (userState.isSuccess && userState.data != null) {
          return ProfileBody(user: userState.data!);
        }

        return GuestProfileScreen(
          onLoginPressed: () {
            context.go('/login');
          },
          onRegisterPressed: () {
            context.go('/signup');
          },
          onContinueAsGuest: () {
            context.go('/home');
          },
        );
      },
    );
  }

  bool _isTokenError(String? message) {
    if (message == null) return false;
    final lower = message.toLowerCase();
    return lower.contains('token') ||
        lower.contains('unauthorized') ||
        lower.contains('401') ||
        lower.contains('auth') ||
        lower.contains('login') ||
        lower.contains('session');
  }
}
