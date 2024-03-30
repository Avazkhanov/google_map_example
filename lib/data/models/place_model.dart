import 'package:google_map_example/data/models/place_category.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int? id;
  LatLng latLng;
  final String placeName;
  final String placeCategory;
  final String entrance;
  final String stage;
  final String flatNumber;
  final String orientAddress;

  PlaceModel({
    required this.placeCategory,
    required this.latLng,
    required this.placeName,
    required this.entrance,
    required this.flatNumber,
    required this.orientAddress,
    required this.stage,
    this.id,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      placeCategory: json['place_category'],
      placeName: json['place_name'],
      entrance: json['entrance'],
      stage: json['stage'],
      flatNumber: json['flat_number'],
      orientAddress: json['orient_address'],
      latLng: stringToLatLng(json['lat_lng']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_category': placeCategory.toString(),
      'place_name': placeName,
      'entrance': entrance,
      'stage': stage,
      'flat_number': flatNumber,
      'orient_address': orientAddress,
      'lat_Lng': "${latLng.latitude},${latLng.longitude}"
    };
  }

  PlaceModel copyWith({
    int? id,
    String? placeCategory,
    String? placeName,
    String? entrance,
    String? stage,
    String? flatNumber,
    String? orientAddress,
    LatLng? latLng,
  }) {
    return PlaceModel(
      id: id ?? this.id,
      placeCategory: placeCategory ?? this.placeCategory,
      placeName: placeName ?? this.placeName,
      entrance: entrance ?? this.entrance,
      stage: stage ?? this.stage,
      flatNumber: flatNumber ?? this.flatNumber,
      orientAddress: orientAddress ?? this.orientAddress,
      latLng: latLng ?? this.latLng,
    );
  }
}

LatLng stringToLatLng(String v) {
  List<String> parts = v.split(',');
  double lat = double.parse(parts[0]);
  double lng = double.parse(parts[1]);
  return LatLng(lat, lng);
}


PlaceCategory categoryFromString(String value) {
  return PlaceCategory.values.firstWhere(
      (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}
