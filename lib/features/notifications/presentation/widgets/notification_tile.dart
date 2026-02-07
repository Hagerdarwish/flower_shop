import 'package:flower_shop/app/core/ui_helper/style/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/notification_entity.dart';
import '../manager/notifications_cubit.dart';
import '../manager/notifications_intent.dart';

class NotificationTile extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(notification.id),
      direction: DismissDirection.endToStart,

      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      confirmDismiss: (_) async {
        context.read<NotificationsCubit>().doIntent(
          DeleteNotificationIntent(notification.id!),
        );

        return true;
      },

      child: ListTile(
        leading: const Icon(Icons.notifications, color: Colors.pink),

        title: Text(notification.title ?? '', style: AppStyles.black14bold),

        subtitle: Text(
          notification.body ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppStyles.grey14Regular,
        ),
      ),
    );
  }
}
