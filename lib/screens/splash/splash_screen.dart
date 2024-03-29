import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_example/view_models/location_view_model.dart';
import 'package:google_map_example/view_models/map_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: IconButton(
            onPressed: () {
              LatLng? latlng = context.read<LocationViewModel>().latLng;
              if (latlng!= null) {
                Provider.of<MapViewModel>(context,listen: false).setLatInitialLong(latlng);
                Navigator.pushReplacementNamed(context, '/map');
              }
            },
            icon: Icon(
              CupertinoIcons.location,
              size: 60.sp,
            ),
          ),
        ),
      ),
    );
  }
}
