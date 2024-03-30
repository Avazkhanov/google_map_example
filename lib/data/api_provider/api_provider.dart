import 'dart:convert';
import 'dart:io';

import 'package:google_map_example/data/my_response.dart';
import 'package:google_map_example/utils/constants/app_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static Future<MyResponse> getPlaceNameByLocation(LatLng latLng) async {
    String place = "Hudud noma'lum";

    Uri uri = Uri.https(AppConstants.baseUrl, "/1.x/", {
      "apikey": AppConstants.apiKey,
      "geocode": "${latLng.longitude}, ${latLng.latitude}",
      "lang": AppConstants.lang,
      "format": "json",
      "kind": "house",
      "rspn": "1",
      "results": "5"
    });

    http.Response response = await http.get(uri);

    if (response.statusCode == HttpStatus.ok) {
      var data = jsonDecode(response.body);
      var list =
      data["response"]["GeoObjectCollection"]["featureMember"] as List?;
      if (list != null && list.isNotEmpty) {
        String? placeName = list[0]["GeoObject"]["metaDataProperty"]
        ["GeocoderMetaData"]["text"];
        place = placeName ?? "Hudud noma'lum";
      }
    }
    return MyResponse(data: place);
  }
}