import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/notifications/presentation/widgets/clear_all_button.dart';
import 'package:flower_shop/features/notifications/presentation/widgets/notifications_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/core/router/route_names.dart';
import '../../../../generated/locale_keys.g.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.notifications.tr()),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => context.go(RouteNames.profile),
          ),
          actions: [ClearAllButton()],
        ),
        body: const NotificationsBody(),
      ),
    );
  }
}
