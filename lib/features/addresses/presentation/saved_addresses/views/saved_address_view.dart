import 'package:flower_shop/features/addresses/presentation/saved_addresses/widgets/saved_address_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/manager/saved_address_cubit.dart';
import 'package:flower_shop/features/addresses/presentation/saved_addresses/manager/saved_address_intent.dart';

class SavedAddressView extends StatelessWidget {
  const SavedAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SavedAddressCubit>()..doIntent(GetAddressesIntent()),
      child: const Scaffold(body: SavedAddressViewBody()),
    );
  }
}
