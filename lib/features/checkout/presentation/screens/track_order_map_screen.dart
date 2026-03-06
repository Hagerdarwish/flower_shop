// import 'package:flower_shop/app/config/di/di.dart';
// import 'package:flower_shop/features/checkout/presentation/cubit/order_tracking_map/track_order_map_cubit.dart';
// import 'package:flower_shop/features/checkout/presentation/cubit/order_tracking_map/track_order_map_intent.dart';
// import 'package:flower_shop/features/checkout/presentation/cubit/order_tracking_map/track_order_map_state.dart' show TrackOrderMapState;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class TrackOrderMapScreen extends StatefulWidget {
//   final String orderId;
//   final String driverId;

//   const TrackOrderMapScreen({
//     super.key,
//     required this.orderId,
//     required this.driverId,
//   });

//   @override
//   State<TrackOrderMapScreen> createState() => _TrackOrderMapScreenState();
// }

// class _TrackOrderMapScreenState extends State<TrackOrderMapScreen> {
//   GoogleMapController? mapController;

//   Set<Marker> _buildMarkers(TrackOrderMapState state) {
//     final markers = <Marker>{};

//     if (state.shopLat != null) {
//       markers.add(
//         Marker(
//           markerId: const MarkerId("shop"),
//           position: LatLng(state.shopLat!, state.shopLng!),
//         ),
//       );
//     }

//     if (state.customerLat != null) {
//       markers.add(
//         Marker(
//           markerId: const MarkerId("customer"),
//           position: LatLng(state.customerLat!, state.customerLng!),
//         ),
//       );
//     }

//     if (state.driverLat != null) {
//       markers.add(
//         Marker(
//           markerId: const MarkerId("driver"),
//           position: LatLng(state.driverLat!, state.driverLng!),
//         ),
//       );
//     }

//     return markers;
//   }

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       context.read<TrackOrderMapCubit>().doIntent(
//             LoadMapDataIntent(
//               orderId: widget.orderId,
//               driverId: widget.driverId,
//             ),
//           );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<TrackOrderMapCubit>(),
//       child: BlocConsumer<TrackOrderMapCubit, TrackOrderMapState>(
//         listener: (context, state) {
//           if (state.errorMessage != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.errorMessage!)),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             backgroundColor: Colors.black,
//             body: Column(
//               children: [
//                 /// MAP
//                 Expanded(
//                   child: Stack(
//                     children: [
//                       GoogleMap(
//                         initialCameraPosition: CameraPosition(
//                           target: LatLng(
//                             state.driverLat ?? 30.0444,
//                             state.driverLng ?? 31.2357,
//                           ),
//                           zoom: 14,
//                         ),
//                         markers: _buildMarkers(state),
//                         myLocationEnabled: true,
//                         zoomControlsEnabled: false,
//                         onMapCreated: (controller) {
//                           mapController = controller;
//                         },
//                       ),

//                       /// TOP TITLE
//                       const Positioned(
//                         top: 50,
//                         left: 20,
//                         child: Text(
//                           "Track order",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 /// BOTTOM PANEL
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(30),
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       /// ARRIVAL
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             "Estimated arrival",
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 14,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             "03 Sep 2024, 11:00 AM",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 20),

//                       /// DRIVER INFO
//                       Row(
//                         children: [
//                           const CircleAvatar(
//                             radius: 22,
//                             backgroundImage:
//                                 AssetImage("assets/images/driver.png"),
//                           ),
//                           const SizedBox(width: 10),

//                           const Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Muhamed",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 Text(
//                                   "Is your delivery hero for today",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           IconButton(
//                             icon:
//                                 const Icon(Icons.phone, color: Colors.pink),
//                             onPressed: () {},
//                           ),

//                           IconButton(
//                             icon:
//                                 const Icon(Icons.message, color: Colors.pink),
//                             onPressed: () {},
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 20),

//                       /// BUTTON
//                       SizedBox(
//                         width: double.infinity,
//                         height: 55,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xffE91E63),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           onPressed: () {},
//                           child: const Text(
//                             "Order details",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flower_shop/app/config/di/di.dart';
// import 'package:flower_shop/features/checkout/presentation/cubit/order_tracking_map/track_order_map_cubit.dart';
// import 'package:flower_shop/features/checkout/presentation/cubit/order_tracking_map/track_order_map_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class TrackOrderMapScreen extends StatelessWidget {
//   const TrackOrderMapScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<TrackOrderMapCubit>(),
//       child: Scaffold(
//         body: const TrackOrderMapBody(),
//       ),
//     );
//   }
// }

// class TrackOrderMapBody extends StatefulWidget {
//   const TrackOrderMapBody({super.key});

//   @override
//   State<TrackOrderMapBody> createState() => _TrackOrderMapBodyState();
// }

// class _TrackOrderMapBodyState extends State<TrackOrderMapBody> {
//   GoogleMapController? mapController;

//   Set<Marker> _buildMarkers(TrackOrderMapState state) {
//     final markers = <Marker>{};

//     if (state.shopLat != null) {
//       markers.add(
//         Marker(
//           markerId: const MarkerId("shop"),
//           position: LatLng(state.shopLat!, state.shopLng!),
//         ),
//       );
//     }

//     if (state.customerLat != null) {
//       markers.add(
//         Marker(
//           markerId: const MarkerId("customer"),
//           position: LatLng(state.customerLat!, state.customerLng!),
//         ),
//       );
//     }

//     if (state.driverLat != null) {
//       markers.add(
//         Marker(
//           markerId: const MarkerId("driver"),
//           position: LatLng(state.driverLat!, state.driverLng!),
//         ),
//       );
//     }

//     return markers;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<TrackOrderMapCubit, TrackOrderMapState>(
//       listener: (context, state) {
//         if (state.errorMessage != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.errorMessage!)),
//           );
//         }
//       },
//       builder: (context, state) {
//         return Column(
//           children: [
//             /// MAP
//             Expanded(
//               child: Stack(
//                 children: [
//                   GoogleMap(
//                     initialCameraPosition: CameraPosition(
//                       target: LatLng(
//                         state.driverLat ?? 30.0444,
//                         state.driverLng ?? 31.2357,
//                       ),
//                       zoom: 14,
//                     ),
//                     markers: _buildMarkers(state),
//                     myLocationEnabled: true,
//                     zoomControlsEnabled: false,
//                     onMapCreated: (controller) {
//                       mapController = controller;
//                     },
//                   ),

//                   /// TOP TITLE
//                   const Positioned(
//                     top: 50,
//                     left: 20,
//                     child: Text(
//                       "Track order",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             /// BOTTOM PANEL
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(30),
//                 ),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   /// ARRIVAL
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Estimated arrival",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         state.estimatedArrival ?? "",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   /// DRIVER INFO
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 22,
//                         backgroundImage: state.driverImage != null
//                             ? NetworkImage(state.driverImage!)
//                             : const AssetImage("assets/images/driver.png")
//                                 as ImageProvider,
//                       ),
//                       const SizedBox(width: 10),

//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               state.driverName ?? "",
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             const Text(
//                               "Is your delivery hero for today",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       IconButton(
//                         icon: const Icon(Icons.phone, color: Colors.pink),
//                         onPressed: () {},
//                       ),

//                       IconButton(
//                         icon: const Icon(Icons.message, color: Colors.pink),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   /// BUTTON
//                   SizedBox(
//                     width: double.infinity,
//                     height: 55,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xffE91E63),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: const Text(
//                         "Order details",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
