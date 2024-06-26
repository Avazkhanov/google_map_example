import 'dart:async';
import 'dart:ui'as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map_example/data/models/place_model.dart';
import 'package:google_map_example/data/repositories/place_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewModel extends ChangeNotifier{
  String icons = "";
  String currentPlaceName = "";
  bool isScrolled = false;
  bool isEdit = false;
  PlaceModel? placeModel;



  cameraMove(bool v){
    isScrolled = v;
    notifyListeners();
  }

  final Completer<GoogleMapController> controller =
  Completer<GoogleMapController>();

  MapType mapType = MapType.normal;

  CameraPosition? initialCameraPosition;
  late CameraPosition currentCameraPosition;

  Set<Marker> markers = {};

  setLatInitialLong(LatLng latLng) {
    initialCameraPosition = CameraPosition(
      target: latLng,
      zoom: 15,
    );

    currentCameraPosition = initialCameraPosition!;
  }

  changeMapType(MapType newMapType) {
    mapType = newMapType;
    notifyListeners();
  }

  moveToInitialPosition() async {
    final GoogleMapController mapController = await controller.future;
    await mapController
        .animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition!));
  }

  changeCurrentCameraPosition(CameraPosition cameraPosition) async {
    final GoogleMapController mapController = await controller.future;
    await mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  changeCurrentLocation(CameraPosition cameraPosition) async {
    currentCameraPosition = cameraPosition;
    currentPlaceName = await PlaceRepository.getPlaceName(cameraPosition.target);
    notifyListeners();
  }

  addNewMarker({required LatLng position,required String title,required String snippet}) async {
    Uint8List markerImage = await getBytesFromAsset(
      icons,
      150,
    );
    markers.add(
      Marker(
        position: position,
        infoWindow:  InfoWindow(title: title, snippet: snippet),
        //BitmapDescriptor.defaultMarker,
        icon: BitmapDescriptor.fromBytes(markerImage),
        markerId: MarkerId(DateTime.now().toString()),
      ),
    );
    notifyListeners();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}