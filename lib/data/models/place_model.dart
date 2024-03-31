import 'package:google_map_example/data/models/place_category.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final String? docId;
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
    this.docId,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      docId: json['doc_id'] as String? ?? "",
      placeCategory: json['place_category'] as String? ?? "",
      placeName: json['place_name'] as String? ?? "",
      entrance: json['entrance'] as String? ?? "",
      stage: json['stage'] as String? ?? "",
      flatNumber: json['flat_number'] as String? ?? "",
      orientAddress: json['orient_address'] as String? ?? "",
      latLng: stringToLatLng(json['lat_Lng'] as String? ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doc_id': docId,
      'place_category': placeCategory.toString(),
      'place_name': placeName,
      'entrance': entrance,
      'stage': stage,
      'flat_number': flatNumber,
      'orient_address': orientAddress,
      'lat_Lng': "${latLng.latitude},${latLng.longitude}"
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
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
    String? id,
    String? placeCategory,
    String? placeName,
    String? entrance,
    String? stage,
    String? flatNumber,
    String? orientAddress,
    LatLng? latLng,
  }) {
    return PlaceModel(
      docId: id ?? docId,
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
  if (v == "") return LatLng(41.311081, 69.240562);
  List<String> parts = v.split(',');
  double lat = double.parse(parts[0]);
  double lng = double.parse(parts[1]);
  return LatLng(lat, lng);
}

PlaceCategory categoryFromString(String value) {
  return PlaceCategory.values.firstWhere(
      (e) => e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
}
