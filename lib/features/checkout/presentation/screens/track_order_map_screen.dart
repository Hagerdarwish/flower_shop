import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/tracking_order/track_order_map_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/track_order_map_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackOrderMapScreen extends StatelessWidget {
  final String orderId;
  final String driverId;

  const TrackOrderMapScreen({
    super.key,
    required this.orderId,
    required this.driverId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TrackOrderMapCubit>(),
      child: Scaffold(
        body: TrackOrderMapBody(orderId: orderId, driverId: driverId),
      ),
    );
  }
}
