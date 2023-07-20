import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class GetCurrentLocation extends StatefulWidget {
  const GetCurrentLocation({super.key});

  @override
  State<GetCurrentLocation> createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {
  Location location = Location();
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();

    // Request permission to access the device's location
    _requestLocationPermission();
    setLocation();
  }

  void setLocation() async {


      location.onLocationChanged.listen((LocationData currentLocation) {
        setState(() {
          _currentLocation = currentLocation;
        });
      });

    // Set up the location listener
  }

  // Function to request location permission
  Future<void> _requestLocationPermission() async {


    bool serviceEnabled;
    PermissionStatus permissionGranted;

      // Check if location services are enabled
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
        print("is in If of service enabled");
      }
      print("is out of If of service enabled");
      // Check if the app has location permission
      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return ;
        }
        print("is in If of permission enabled");
      }
      print("is out of If of permission enabled");

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Location Listener Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_currentLocation != null)
                Text(
                  'Latitude: ${_currentLocation!.latitude}\n'
                  'Longitude: ${_currentLocation!.longitude}',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              if (_currentLocation == null)
                const Text(
                  'Waiting for location updates...',
                  style: TextStyle(fontSize: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
