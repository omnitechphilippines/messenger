import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:messenger/constants/colors.dart';

import '../../../widgets/custom_loader.dart';
import '../../../widgets/gradient_icon_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? currentLocation;
  MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await getCurrentLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode() ? Colors.black : const Color(0xFFFEF7FF),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context, currentLocation),
        backgroundColor: Colors.transparent,
        child: const GradientIconButton(size: 55, iconData: Icons.send),
      ),
      body: currentLocation != null
          ? FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: currentLocation!,
          initialZoom: 13.0,
          onTap: (TapPosition tp, LatLng latLong) => setState(() => currentLocation = latLong),
        ),
        children: <Widget>[
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
        ],
      )
          : const Center(child: CustomLoader()),
    );
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showError("Location services are disabled.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showError("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showError("Location permission permanently denied. Please enable it in settings.");
      await Geolocator.openAppSettings();
      return;
    }

    try {
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(),
      );
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      showError("Failed to get location: $e");
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}