import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({super.key});

  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {
  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.8597998, 75.3114008),
    zoom: 14.4746,
  );
  final List<Marker> _marker = [
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(18.521428, 73.8544541),
      infoWindow: InfoWindow(
        title: 'My Home',
      ),
    ),
  ];
  loadData() {
    getUserCurrentLocation().then((value) async {
      log('my currnt location');
      log(value.latitude.toString() + " " + value.longitude.toString());

      _marker.add(
        Marker(
          markerId: const MarkerId('2'),
          position: LatLng(
            value.latitude,
            value.longitude,
          ),
          infoWindow: const InfoWindow(
            title: 'My Current Location',
          ),
        ),
      );
      CameraPosition cameraPosition = CameraPosition(
          zoom: 14,
          target: LatLng(
            value.latitude,
            value.latitude,
          ));
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  void initState() {
    super.initState();
    loadData();
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      log(
        'Error' + error.toString(),
      );
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              loadData();
            },
            child: const Icon(
              Icons.local_activity,
            ),
          ),
        ],
      ),
    );
  }
}
