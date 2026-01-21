import 'package:flower_shop/features/auth/presentation/signup/manager/signup_cubit.dart';
import 'package:flower_shop/features/auth/presentation/signup/manager/signup_states.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Add this to fetch profile on widget initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().getProfile();
    });

    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        // Handle ProfileInitial state
        if (state is ProfileInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileError) {
          return Center(
            child: Text(state.signupState.genderError ?? 'An error occurred'),
          );
        }

        if (state is ProfileLoaded) {
          final user = state.user;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(user.email),
              Text(
                user.addresses.isNotEmpty ? user.addresses[0] : 'No address',
              ),
              Text(user.phone.isEmpty ? 'No phone' : user.phone),
              Text(user.role.isNotEmpty ? user.role : 'No role'),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
