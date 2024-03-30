import 'package:google_map_example/data/api_provider/api_provider.dart';
import 'package:google_map_example/data/my_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceRepository{
  static getPlaceName(LatLng latLng) async{
    MyResponse temp = await ApiProvider.getPlaceNameByLocation(latLng);
    return temp.data as String;
  }
}