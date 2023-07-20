
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_demo_app/location_services.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  String ?lat , lng;




/*
  var googleLocation = '';
  String lat = '';
  String lng = '';
*/





 /* void getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Permission not given");
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("Latitude : " + currentPosition.latitude.toString());
      print("Longitude : " + currentPosition.longitude.toString());

      setState(() {
        lat = currentPosition.latitude.toString();
        lng = currentPosition.longitude.toString();

      });
    }
  }*/

/*  void googleMap() async{
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if(await canLaunchUrl(  Uri.parse(googleUrl) )){

      await launchUrl(Uri.parse(googleUrl));
    }else{
      print("Could not open google maps");
    }
  }*/


  void liveLocation()async{


    LocationService service = LocationService();
    var locationData = await service.getLocation();
    setState(() {

      lat = locationData!.latitude.toString();
      lng =  locationData!.longitude.toString();

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),

              Text(lat??""),
              Text(lng??""),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  liveLocation();
               /*   getCurrentLocation();*/
                },
                child: const Text("Get current location"),
              ),
              SizedBox(
                height: 50,
              ),
          /*    ElevatedButton(
                onPressed: () {
                  googleMap();
                },
                child: const Text("Open in Google Maps"),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
