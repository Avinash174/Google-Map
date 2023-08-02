import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertingLatLanToAdderess extends StatefulWidget {
  const ConvertingLatLanToAdderess({super.key});

  @override
  State<ConvertingLatLanToAdderess> createState() =>
      _ConvertingLatLanToAdderessState();
}

class _ConvertingLatLanToAdderessState
    extends State<ConvertingLatLanToAdderess> {
  String stAddress = '', stAdd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AppBar',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(stAdd),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(stAddress),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () async {
                // final coordinates = Coordinates(
                //   19.8762,
                //   75.3433,
                // );
                List<Location> locations =
                    await locationFromAddress("Gronausestraat 710, Enschede");

                List<Placemark> placemarks =
                    await placemarkFromCoordinates(52.2165157, 6.9437819);
                setState(() {
                  stAddress = locations.last.latitude.toString() +
                      "  " +
                      locations.last.longitude.toString();
                  stAdd = placemarks.reversed.last.country.toString() +
                      " " +
                      placemarks.reversed.last.locality.toString();
                });
              },
              child: Container(
                height: 55,
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: const Center(
                  child: Text(
                    'Convert',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
