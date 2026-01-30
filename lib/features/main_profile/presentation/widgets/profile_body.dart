import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/app_constants.dart';
import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/features/auth/presentation/logout/manager/logout_cubit.dart';
import 'package:flower_shop/features/auth/presentation/logout/manager/logout_intent.dart';
import 'package:flower_shop/features/auth/presentation/logout/manager/logout_state.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'language_bottom_sheet.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user});
  final ProfileUserModel user;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        /// Profile Header
        Center(
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  await context.push(RouteNames.editProfile, extra: user);
                  if (context.mounted) {
                    context.read<ProfileCubit>().doIntent(LoadProfileEvent());
                  }
                },
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.grey.shade200,
                  child: ClipOval(
                    child: Image.network(
                      user.photo ?? '',
                      width: 84,
                      height: 84,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person, size: 42),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                user.firstName ?? AppConstants.noName,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 4),

              Text(
                user.email ?? AppConstants.noEmail,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),
        const Divider(),

        _ProfileItem(
          title: AppConstants.myOrders,
          icon: Icons.receipt_long,
          onTap: () {},
        ),

        _ProfileItem(
          title: AppConstants.savedaddresses,
          icon: Icons.location_on_outlined,
          onTap: () {},
        ),

        _ProfileItem(
          title: AppConstants.notifications,
          icon: Icons.notifications_none,
          trailing: Switch(value: true, onChanged: (_) {}),
        ),

        _ProfileItem(
          title: AppConstants.Language,
          icon: Icons.language,
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const LanguageBottomSheet(),
            );
          },
          trailing: Text(
            context.locale.languageCode == 'ar' ? 'Arabic' : 'English',
          ),
        ),

        const Divider(),

        _ProfileItem(
          title: AppConstants.aboutUs,
          icon: Icons.info_outline,
          onTap: () {},
        ),

        _ProfileItem(
          title: AppConstants.termsAndConditions,
          icon: Icons.description_outlined,
          onTap: () {},
        ),

        const Divider(),

        /// Logout
        BlocConsumer<LogoutCubit, LogoutStates>(
          listener: (context, state) {
            if (state.logoutResource.isSuccess) {
              context.go(RouteNames.login);
            }
            if (state.logoutResource.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.logoutResource.error ?? 'Logout failed'),
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state.logoutResource.isLoading;
            return _ProfileItem(
              title: AppConstants.logout,
              icon: Icons.logout,
              color: Colors.red,
              trailing: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : null,
              onTap: isLoading
                  ? null
                  : () {
                      context.read<LogoutCubit>().doIntent(PerformLogout());
                    },
            );
          },
        ),
      ],
    );
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
    this.color,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final itemColor = color ?? Theme.of(context).colorScheme.onSurface;

    return ListTile(
      leading: Icon(icon, color: itemColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: itemColor,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
