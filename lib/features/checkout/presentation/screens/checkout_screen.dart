import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/features/checkout/presentation/screens/checkout_body.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (context) => KeyedSubtree(
            key: ValueKey(context.locale.languageCode),
            child: Text(LocaleKeys.checkout.tr()),
          ),
        ),
        leading: BackButton(
          onPressed: () {
            context.push(RouteNames.home);
          },
        ),
      ),
      body: const CheckoutBody(),
    );
  }
}
