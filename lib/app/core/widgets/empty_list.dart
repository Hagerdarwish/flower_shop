import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../generated/assets.dart';
import '../../../generated/locale_keys.g.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            Assets.animationsEmpty,
            width: 220,
            repeat: true,
            height: 300,
          ),
          const SizedBox(height: 16),
          Text(
            LocaleKeys.no_notifications_yet.tr(),
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
