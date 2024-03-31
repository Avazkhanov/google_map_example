import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_example/data/models/place_model.dart';
import 'package:google_map_example/screens/globals/global_ink.dart';
import 'package:google_map_example/screens/home/widgets/address_item.dart';
import 'package:google_map_example/screens/routes.dart';
import 'package:google_map_example/utils/images/app_images.dart';
import 'package:google_map_example/view_models/firebase_view_model.dart';
import 'package:google_map_example/view_models/location_view_model.dart';
import 'package:google_map_example/view_models/map_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<FireBaseViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Address'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: provider.listenProducts(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<PlaceModel> list = snapshot.data as List<PlaceModel>;
            provider.places = list;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
              child: Column(
                children: [
                  list.isEmpty
                      ? Expanded(
                    child: Center(
                      child: LottieBuilder.asset(AppImages.empty),
                    ),
                  )
                      : const AddressItem(),
                  GlobalInk(
                    text: "Add Address",
                    onTap: () {
                      LatLng? latLng = context.read<LocationViewModel>().latLng;
                      if (latLng != null) {
                        Provider.of<MapViewModel>(context, listen: false)
                            .setLatInitialLong(latLng);
                        context.read<MapViewModel>().isEdit = false;
                        Navigator.pushNamed(context, RoutesNames.map,
                            arguments:
                            context.read<MapViewModel>().initialCameraPosition!);
                      }
                    },
                  ),
                ],
              ),
            );
          }
          if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
