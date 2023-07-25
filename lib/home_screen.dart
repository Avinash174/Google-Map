import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.8597998, 75.3114008),
    zoom: 14.4746,
  );
  List<Marker> marker = [];
  List<Marker> list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(18.521428, 73.8544541),
      infoWindow: InfoWindow(
        title: 'My Home',
      ),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(18.520430, 75.319489),
      infoWindow: InfoWindow(
        title: 'My Home',
      ),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(19.0785451, 72.878176),
      infoWindow: InfoWindow(
        title: 'My Home',
      ),
    ),
    Marker(
      markerId: MarkerId('4'),
      position: LatLng(20.0112475, 73.7902364),
      infoWindow: InfoWindow(
        title: 'My Home',
      ),
    ),
  ];

  void initState() {
    super.initState();
    marker.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          markers: Set<Marker>.of(marker),
          mapType: MapType.hybrid,
          myLocationEnabled: true,
          compassEnabled: true,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController googleMapController) {
            _controller.complete(googleMapController);
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: FloatingActionButton(
                onPressed: () async {
                  GoogleMapController controller = await _controller.future;
                  controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      const CameraPosition(
                        target: LatLng(20.0112475, 73.7902364),
                        zoom: 14,
                      ),
                    ),
                  );
                  setState(() {});
                },
                child: const Icon(
                  Icons.location_disabled_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
