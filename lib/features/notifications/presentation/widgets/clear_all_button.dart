import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/core/widgets/custom_action_text.dart';
import '../manager/notifications_cubit.dart';
import '../manager/notifications_intent.dart';
import '../manager/notifications_state.dart';

class ClearAllButton extends StatelessWidget {
  const ClearAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final hasData = state.resource.data?.isNotEmpty ?? false;

        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CustomActionText(
            text: LocaleKeys.clear_all.tr(),
            isEnabled: hasData,
            onTapAction: () {
              context.read<NotificationsCubit>().doIntent(
                ClearAllNotificationsIntent(),
              );
            },
          ),
        );
      },
    );
  }
}
