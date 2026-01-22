import 'package:flower_shop/app/core/app_constants.dart';
import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user});

  final ProfileUserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          rowItem(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await context.push(RouteNames.editProfile, extra: user);
                  if (context.mounted) {
                    context.read<ProfileCubit>().doIntent(LoadProfileEvent());
                  }
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade200,
                  child: ClipOval(
                    child: Image.network(
                      user.photo ?? '',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return const Icon(Icons.person, size: 40);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.firstName ?? AppConstants.noName),
                  Text(user.email ?? AppConstants.noEmail),
                ],
              ),
            ],
          ),

          rowItem(
            children: [
              const Text(AppConstants.myOrders),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),

          rowItem(
            children: [
              const Text(AppConstants.savedaddresses),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),

          rowItem(
            children: [
              const Text(AppConstants.notifications),
              Switch(value: true, onChanged: (_) {}),
            ],
          ),

          rowItem(
            children: [
              const Text(AppConstants.Language),
              DropdownButton<String>(
                value: 'en',
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'ar', child: Text('Arabic')),
                ],
                onChanged: (_) {},
              ),
            ],
          ),

          rowItem(
            children: [
              const Text(AppConstants.aboutUs),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),

          rowItem(
            children: [
              const Text(AppConstants.termsAndConditions),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),

          rowItem(
            children: [
              const Text('Logout'),
              IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
            ],
          ),
        ],
      ),
    );
  }
}

Widget rowItem({
  required List<Widget> children,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
}) {
  return Row(
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: crossAxisAlignment,
    children: children,
  );
}
