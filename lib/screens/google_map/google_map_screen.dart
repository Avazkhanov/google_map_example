import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_example/screens/google_map/widgets/add_place.dart';
import 'package:google_map_example/screens/google_map/widgets/map_item.dart';
import 'package:google_map_example/utils/images/app_images.dart';
import 'package:google_map_example/view_models/map_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GoogleMapScreen extends StatelessWidget {
 const GoogleMapScreen({super.key, required this.initialPosition});
 final CameraPosition initialPosition;

  @override
  Widget build(BuildContext context) {
    context.read<MapViewModel>();
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
                onCameraMoveStarted: () {
                  viewModel.cameraMove(true);
                },
                zoomControlsEnabled: false,
                markers: viewModel.markers,
                onCameraIdle: () {
                  if (cameraPosition != null) {
                    context
                        .read<MapViewModel>()
                        .changeCurrentLocation(cameraPosition!);
                    viewModel.cameraMove(false);
                  }
                },
                onCameraMove: (CameraPosition currentCameraPosition) {
                  cameraPosition = currentCameraPosition;
                },
                mapType: viewModel.mapType,
                initialCameraPosition: viewModel.initialCameraPosition!,
                onMapCreated: (GoogleMapController createdController) {
                  viewModel.controller.complete(createdController);
                },
              ),
              Align(
                child: Image.asset(
                  AppImages.marker,
                  width: 50,
                  height: 50,
                ),
              ),
              Positioned(
                top: 60.h,
                right: 10.w,
                child: const MapTypeItem(),
              ),
              Positioned(
                top: 150.h,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r),
                      )),
                  child: IconButton(
                    onPressed: () {
                      context.read<MapViewModel>().moveToInitialPosition();
                    },
                    icon: Icon(
                      CupertinoIcons.location_solid,
                      size: 24.sp,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
              viewModel.isScrolled
                  ? SizedBox()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: const AddPlace(),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
