import 'package:flower_shop/features/checkout/presentation/cubit/order_tracking_map/track_order_map_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/order_tracking_map/track_order_map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackOrderMapBody extends StatefulWidget {
  const TrackOrderMapBody({super.key});

  @override
  State<TrackOrderMapBody> createState() => _TrackOrderMapBodyState();
}

class _TrackOrderMapBodyState extends State<TrackOrderMapBody> {
  GoogleMapController? mapController;

  Set<Marker> _buildMarkers(TrackOrderMapState state) {
    final markers = <Marker>{};

    if (state.shopLat != null) {
      markers.add(
        Marker(
          markerId: const MarkerId("shop"),
          position: LatLng(state.shopLat!, state.shopLng!),
        ),
      );
    }

    if (state.customerLat != null) {
      markers.add(
        Marker(
          markerId: const MarkerId("customer"),
          position: LatLng(state.customerLat!, state.customerLng!),
        ),
      );
    }

    if (state.driverLat != null) {
      markers.add(
        Marker(
          markerId: const MarkerId("driver"),
          position: LatLng(state.driverLat!, state.driverLng!),
        ),
      );
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackOrderMapCubit, TrackOrderMapState>(
      listener: (context, state) {
        final error = state.orderResource.error;
        if (error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error)));
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        state.driverLat ?? 30.0444,
                        state.driverLng ?? 31.2357,
                      ),
                      zoom: 14,
                    ),
                    markers: _buildMarkers(state),
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                  ),
                  const Positioned(
                    top: 50,
                    left: 20,
                    child: Text(
                      "Track order",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Estimated arrival",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        state.orderResource.data?.updatedAt.toString() ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,

                        backgroundImage: AssetImage("assets/images/driver.png"),
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.orderResource.data?.userAddress.name ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const Text(
                              "Is your delivery hero for today",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons.phone, color: Colors.pink),
                        onPressed: () {},
                      ),

                      IconButton(
                        icon: const Icon(Icons.message, color: Colors.pink),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffE91E63),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Order details",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
