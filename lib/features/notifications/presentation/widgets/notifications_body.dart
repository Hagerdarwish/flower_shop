import 'package:flower_shop/app/core/widgets/empty_list.dart';
import 'package:flower_shop/app/core/widgets/shimmer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/core/widgets/show_snak_bar.dart';
import '../manager/notifications_cubit.dart';
import '../manager/notifications_state.dart';
import 'notification_tile.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state.lastAction == NotificationsAction.deleted) {
          showAppSnackbar(
            context,
            LocaleKeys.notification_deleted_successfully.tr(),
          );
        }
        if (state.lastAction == NotificationsAction.cleared) {
          showAppSnackbar(context, LocaleKeys.all_notifications_cleared.tr());
        }
        if (state.resource.isError) {
          showAppSnackbar(
            context,
            state.resource.error ?? LocaleKeys.something_went_wrong.tr(),
            backgroundColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        if (state.resource.isLoading) {
          return const ShimmerList();
        }
        final list = state.resource.data ?? [];
        if (list.isEmpty) {
          return const EmptyList();
        }
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return NotificationTile(notification: list[index]);
          },
        );
      },
    );
  }
}
