import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (_, __) {},
      builder: (context, state) {
        if (state is ProfileInitial || state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileError) {
          return Center(child: Text(state.message));
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
              Text(user.email ?? 'No email'),
              Text(user.id ?? 'No ID'),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
