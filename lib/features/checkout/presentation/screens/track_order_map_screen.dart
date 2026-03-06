import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/order_tracking_map/track_order_map_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/track_order_map_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackOrderMapScreen extends StatelessWidget {
  const TrackOrderMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TrackOrderMapCubit>(),
      child: Scaffold(body: const TrackOrderMapBody()),
    );
  }
}
