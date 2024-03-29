import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_example/screens/google_map/widgets/category_select.dart';
import 'package:google_map_example/screens/google_map/widgets/diolog.dart';
import 'package:google_map_example/screens/google_map/widgets/map_item.dart';
import 'package:google_map_example/utils/images/app_images.dart';
import 'package:google_map_example/view_models/map_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GoogleMapScreen extends StatelessWidget {
  GoogleMapScreen({super.key});

  late LatLng currentLatLng;

  @override
  Widget build(BuildContext context) {
    CameraPosition? cameraPosition;
    return Scaffold(
      body: Consumer<MapViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.initialCameraPosition == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                markers: viewModel.markers,
                onCameraIdle: () {
                  if (cameraPosition != null) {
                    context
                        .read<MapViewModel>()
                        .changeCurrentLocation(cameraPosition!);
                  }
                },
                onCameraMove: (CameraPosition currentCameraPosition) {
                  cameraPosition = currentCameraPosition;
                  currentLatLng = currentCameraPosition.target;
                },
                mapType: viewModel.mapType,
                initialCameraPosition: viewModel.initialCameraPosition!,
                onMapCreated: (GoogleMapController createdController) {
                  viewModel.controller.complete(createdController);
                },
              ),
              Align(
                child: Image.asset(
                  AppImages.other,
                  width: 50,
                  height: 50,
                ),
              ),
              Positioned(
                top: 60.h,
                right: 10.w,
                child: const MapTypeItem(),
              ),
            ],
          );
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            shape: const OvalBorder(),
            backgroundColor: Colors.white,
            onPressed: () {
              context.read<MapViewModel>().moveToInitialPosition();
            },
            child: const Icon(Icons.gps_fixed),
          ),
          SizedBox(height: 10.h),
          Material(
            color: Colors.transparent,
            child: Ink(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: InkWell(
                onTap: () {
                  showCategoryDialog(context: context, position: currentLatLng);
                },
                borderRadius: BorderRadius.circular(50.r),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.w),
                  child: Icon(
                    CupertinoIcons.location_solid,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _showMapTypePopup() {
    // show
  }
}
