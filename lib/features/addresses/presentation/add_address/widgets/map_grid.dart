import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/add_address_cubit.dart';
import '../manager/add_address_events.dart';
import '../manager/add_address_state.dart';

class AddressMapSection extends StatefulWidget {
  const AddressMapSection({super.key});

  @override
  State<AddressMapSection> createState() => _AddressMapSectionState();
}

class _AddressMapSectionState extends State<AddressMapSection> {
  GoogleMapController? _controller;
  LatLng _center = const LatLng(30.0444, 31.2357); // Cairo fallback

  bool _permissionGranted = false;
  bool _checkingPermission = true;

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermission();
  }

  Future<void> _checkAndRequestPermission() async {
    setState(() => _checkingPermission = true);

    // 1) service enabled?
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _permissionGranted = false;
        _checkingPermission = false;
      });
      _showLocationDialog(serviceOff: true);
      return;
    }

    // 2) permission status
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      setState(() {
        _permissionGranted = false;
        _checkingPermission = false;
      });
      _showLocationDialog();
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _permissionGranted = false;
        _checkingPermission = false;
      });
      _showLocationDialog(deniedForever: true);
      return;
    }

    // Granted
    setState(() {
      _permissionGranted = true;
      _checkingPermission = false;
    });

    await _moveToCurrentLocation();
  }

  Future<void> _moveToCurrentLocation() async {
    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final latLng = LatLng(pos.latitude, pos.longitude);
      _center = latLng;

      // update cubit with initial lat/lng
      context.read<AddAddressCubit>().doIntent(
        LocationPickedEvent(lat: latLng.latitude, lng: latLng.longitude),
      );

      await _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 15),
        ),
      );
    } catch (_) {}
  }

  void _showLocationDialog({
    bool deniedForever = false,
    bool serviceOff = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text(LocaleKeys.location_permission.tr()),
          content: Text(
            serviceOff
                ? LocaleKeys.location_service_off_message.tr()
                : deniedForever
                ? LocaleKeys.location_permission_denied_forever_message.tr()
                : LocaleKeys.location_permission_denied_message.tr(),
          ),
          actions: [
            if (deniedForever)
              TextButton(
                onPressed: () async {
                  await Geolocator.openAppSettings();
                  Navigator.pop(ctx);
                  _checkAndRequestPermission();
                },
                child: Text(LocaleKeys.open_settings.tr()),
              )
            else if (serviceOff)
              TextButton(
                onPressed: () async {
                  await Geolocator.openLocationSettings();
                  Navigator.pop(ctx);
                  _checkAndRequestPermission();
                },
                child: Text(LocaleKeys.open_location_settings.tr()),
              )
            else
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(ctx);
                  _checkAndRequestPermission();
                },
                child: Text(LocaleKeys.allow_location.tr()),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAddressCubit, AddAddressState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 170,
            child: Stack(
              alignment: Alignment.center,
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 12,
                  ),
                  onMapCreated: (c) => _controller = c,
                  myLocationEnabled: _permissionGranted,
                  myLocationButtonEnabled: _permissionGranted,
                  zoomControlsEnabled: false,
                  onCameraMove: (pos) {
                    _center = pos.target;
                  },
                  onCameraIdle: () {
                    // when user stops moving map: save lat/lng to cubit
                    context.read<AddAddressCubit>().doIntent(
                      LocationPickedEvent(
                        lat: _center.latitude,
                        lng: _center.longitude,
                      ),
                    );
                  },
                ),

                // ✅ same pink pin design
                const Icon(Icons.location_pin, size: 44, color: Colors.pink),

                // Optional: small info chip showing chosen coords
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      state.lat == null
                          ? LocaleKeys.move_map_to_choose_location.tr()
                          : "Lat: ${state.lat!.toStringAsFixed(5)}  Lng: ${state.lng!.toStringAsFixed(5)}",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),

                if (_checkingPermission)
                  Positioned.fill(
                    child: Container(
                      color: Colors.white.withOpacity(0.6),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
