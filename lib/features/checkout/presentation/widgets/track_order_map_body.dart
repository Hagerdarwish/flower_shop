import 'package:flower_shop/features/checkout/presentation/cubit/tracking_order/track_order_map_cubit.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/tracking_order/track_order_map_intent.dart';
import 'package:flower_shop/features/checkout/presentation/widgets/marker_generator.dart';
import 'package:flower_shop/features/checkout/presentation/cubit/tracking_order/track_order_map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackOrderMapBody extends StatefulWidget {
  final String orderId;
  final String driverId;

  const TrackOrderMapBody({
    super.key,
    required this.orderId,
    required this.driverId,
  });

  @override
  State<TrackOrderMapBody> createState() => _TrackOrderMapBodyState();
}

class _TrackOrderMapBodyState extends State<TrackOrderMapBody> {
  GoogleMapController? mapController;
  BitmapDescriptor? shopIcon;
  BitmapDescriptor? customerIcon;
  BitmapDescriptor? driverIcon;
  bool _cameraInitialized = false;

  @override
  void initState() {
    super.initState();

    context.read<TrackOrderMapCubit>().doIntent(
      LoadMapDataIntent(orderId: widget.orderId, driverId: widget.driverId),
    );

    _loadCustomMarkers();
  }

  Future<void> _loadCustomMarkers() async {
    final customShopIcon = await MarkerGenerator.createCustomMarker(
      title: "Flowery",
      iconData: Icons.local_florist,
    );
    final customCustomerIcon = await MarkerGenerator.createCustomMarker(
      title: "Apartment",
      iconData: Icons.home_rounded,
    );
    final customDriverIcon = await MarkerGenerator.createCustomMarker(
      title: "Driver",
      iconData: Icons.two_wheeler,
      backgroundColor:
          Colors.blueAccent, // Use distinct color for driver if you like
    );

    if (mounted) {
      setState(() {
        shopIcon = customShopIcon;
        customerIcon = customCustomerIcon;
        driverIcon = customDriverIcon;
      });
    }
  }

  Set<Marker> _buildMarkers(TrackOrderMapState state) {
    final markers = <Marker>{};

    if (state.shopLat != null && state.shopLng != null) {
      markers.add(
        Marker(
          markerId: const MarkerId("shop"),
          position: LatLng(state.shopLat!, state.shopLng!),
          infoWindow: const InfoWindow(title: "Shop Location"),
          icon:
              shopIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ),
      );
    }

    if (state.customerLat != null && state.customerLng != null) {
      markers.add(
        Marker(
          markerId: const MarkerId("customer"),
          position: LatLng(state.customerLat!, state.customerLng!),
          infoWindow: const InfoWindow(title: "My Destination"),
          icon:
              customerIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }

    if (state.driverLat != null && state.driverLng != null) {
      markers.add(
        Marker(
          markerId: const MarkerId("driver"),
          position: LatLng(state.driverLat!, state.driverLng!),
          infoWindow: const InfoWindow(title: "Driver"),
          icon:
              driverIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    return markers;
  }

  Set<Polyline> _buildPolylines(TrackOrderMapState state) {
    final polylines = <Polyline>{};

    if (state.shopLat != null &&
        state.shopLng != null &&
        state.customerLat != null &&
        state.customerLng != null) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          color: const Color(0xffE91E63),
          width: 5,
          points: [
            LatLng(state.shopLat!, state.shopLng!),
            LatLng(state.customerLat!, state.customerLng!),
          ],
        ),
      );
    }

    return polylines;
  }

  LatLngBounds _calculateBounds(TrackOrderMapState state) {
    double? minLat, maxLat, minLng, maxLng;

    void updateBounds(double lat, double lng) {
      if (minLat == null || lat < minLat!) minLat = lat;
      if (maxLat == null || lat > maxLat!) maxLat = lat;
      if (minLng == null || lng < minLng!) minLng = lng;
      if (maxLng == null || lng > maxLng!) maxLng = lng;
    }

    if (state.shopLat != null && state.shopLng != null) {
      updateBounds(state.shopLat!, state.shopLng!);
    }
    if (state.customerLat != null && state.customerLng != null) {
      updateBounds(state.customerLat!, state.customerLng!);
    }
    if (state.driverLat != null && state.driverLng != null) {
      updateBounds(state.driverLat!, state.driverLng!);
    }

    // Default if everything is null (though guard should prevent it)
    if (minLat == null) {
      return LatLngBounds(
        southwest: const LatLng(30.0, 31.0),
        northeast: const LatLng(30.1, 31.1),
      );
    }

    return LatLngBounds(
      southwest: LatLng(minLat!, minLng!),
      northeast: LatLng(maxLat!, maxLng!),
    );
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

        // Move camera to show all markers when we have at least shop and driver
        if (state.shopLat != null &&
            state.customerLat != null &&
            mapController != null &&
            !_cameraInitialized) {
          _cameraInitialized = true;
          final bounds = _calculateBounds(state);
          mapController!.animateCamera(
            CameraUpdate.newLatLngBounds(bounds, 80),
          );
        }
      },
      builder: (context, state) {
        if (state.orderResource.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

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
                    polylines: _buildPolylines(state),
                    myLocationEnabled: false,
                    zoomControlsEnabled: false,
                    onMapCreated: (controller) {
                      mapController = controller;
                      // Move camera once on create if we already have data
                      if (state.shopLat != null) {
                        mapController!.animateCamera(
                          CameraUpdate.newLatLngBounds(
                            _calculateBounds(state),
                            80,
                          ),
                        );
                      }
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
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.person, color: Colors.pink),
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.driverName ?? "Your driver",
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

                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 55,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: const Color(0xffE91E63),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //     ),
                  //     onPressed: () {},
                  //     child: const Text(
                  //       "Order details",
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
