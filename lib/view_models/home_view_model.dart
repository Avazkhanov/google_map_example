import 'package:flutter/material.dart';
import 'package:google_map_example/data/localdatebase/local_datebase.dart';
import 'package:google_map_example/data/models/place_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    getAllPlaces();
  }

  int index = 0;
  bool isEdit = false;

  List<PlaceModel> places = [];

  Future<void> getAllPlaces() async {
    places = await LocalDatabase.getAllPlace();
    notifyListeners();
  }
  Future<void> deletePlace(PlaceModel place) async {
    await LocalDatabase.deletePlace(place.id!);
    getAllPlaces();
  }
}
