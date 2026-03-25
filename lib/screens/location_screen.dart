import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with WidgetsBindingObserver {
  double? lat;
  double? lng;

  final MapController mapController = MapController();
  StreamSubscription<Position>? positionStream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // 🔥 detect resume
    startLiveTracking();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    positionStream?.cancel();
    super.dispose();
  }

  // 🔥 APP RESUME (jab user settings se wapas aaye)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      startLiveTracking(); // 🔥 auto restart
    }
  }

  // 🔴 MAIN FUNCTION
  Future<void> startLiveTracking() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location is OFF. Please enable it.")),
        );
      }

      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    // 🔥 FIRST LOCATION
    Position firstPosition = await Geolocator.getCurrentPosition();

    setState(() {
      lat = firstPosition.latitude;
      lng = firstPosition.longitude;
    });

    mapController.move(LatLng(lat!, lng!), 16);

    // 🔥 STREAM START (pehle cancel karo agar already chal rahi ho)
    await positionStream?.cancel();

    positionStream =
        Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 5,
          ),
        ).listen((Position position) {
          setState(() {
            lat = position.latitude;
            lng = position.longitude;
          });

          mapController.move(LatLng(lat!, lng!), mapController.camera.zoom);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🗺 MAP
          lat == null
              ? const Center(child: CircularProgressIndicator())
              : FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: LatLng(lat!, lng!),
                    initialZoom: 17, // 🔥 thoda zoom clear
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                      userAgentPackageName: "com.example.accident_alert",
                      maxZoom: 19,
                    ),

                    // 🔵 BLUE DOT
                    CircleLayer(
                      circles: [
                        CircleMarker(
                          point: LatLng(lat!, lng!),
                          radius: 12,
                          color: Colors.blue.withOpacity(0.2),
                          borderStrokeWidth: 3,
                          borderColor: Colors.blue,
                        ),
                      ],
                    ),

                    // 📍 MARKER
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(lat!, lng!),
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

          // 🔝 TOP BOX + BUTTON
          SafeArea(
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () async {
                  setState(() {
                    lat = null;
                    lng = null;
                  });

                  await startLiveTracking();

                  if (lat != null && lng != null && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Location Updated Successfully!"),
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.my_location,
                      color: Colors.blue.shade300,
                      size: 26,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lat != null && lng != null
                                ? "Lat: ${lat!.toStringAsFixed(5)}, Lng: ${lng!.toStringAsFixed(5)}"
                                : "Turn ON location to continue",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            "Live tracking enabled",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
