import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationViewModel extends ChangeNotifier{
  LocationViewModel(){
    getUserLocation();
  }

  Location location = Location();
  LatLng? latLng;

  Future<void> getUserLocation() async {
    print("functionga kirdi");
    bool serviceEnabled = false;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    latLng = LatLng(locationData.latitude!, locationData.longitude!);
    print("function latLng: $latLng");

    debugPrint("LONGITUDE:${locationData.longitude}");
    debugPrint("LATITUDE:${locationData.latitude}");
    debugPrint("SPEED:${locationData.speed}");
    debugPrint("ALTITUDE:${locationData.altitude}");

    listenCurrentLocation();

    location.enableBackgroundMode(enable: true);
  }

  void listenCurrentLocation() {
    location.onLocationChanged.listen((event) {
      debugPrint("lat ${event.latitude}");
    });
  }

}