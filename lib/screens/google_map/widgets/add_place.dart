import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_example/data/localdatebase/local_datebase.dart';
import 'package:google_map_example/data/models/place_model.dart';
import 'package:google_map_example/screens/globals/global_ink.dart';
import 'package:google_map_example/screens/google_map/widgets/category_select.dart';
import 'package:google_map_example/utils/extensions/extension.dart';
import 'package:google_map_example/view_models/home_view_model.dart';
import 'package:google_map_example/view_models/map_view_model.dart';
import 'package:provider/provider.dart';

class AddPlace extends StatelessWidget {
  const AddPlace({super.key, this.placeModel});
  final PlaceModel? placeModel;

  @override
  Widget build(BuildContext context) {
    final TextEditingController locationController = TextEditingController(
        text: context.watch<MapViewModel>().currentPlaceName);
    final TextEditingController entranceController = TextEditingController();
    final TextEditingController flatController = TextEditingController();
    final TextEditingController stageController = TextEditingController();
    final TextEditingController orientController = TextEditingController();
    var latLng = context.read<MapViewModel>().currentCameraPosition;
    debugPrint("$latLng");
    return Container(
      height: 270.h,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.r))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15.h),
            TextField(
              maxLines: null,
              controller: locationController,
              decoration: const InputDecoration(
                hintText: "Location",
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80.w,
                  height: 20.h,
                  child: TextField(
                    controller: entranceController,
                    decoration: const InputDecoration(
                      hintText: "Entrance",
                    ),
                  ),
                ),
                SizedBox(
                  width: 80.w,
                  height: 20.h,
                  child: TextField(
                    controller: flatController,
                    decoration: const InputDecoration(
                      hintText: "Flat",
                    ),
                  ),
                ),
                SizedBox(
                  width: 80.w,
                  height: 20.h,
                  child: TextField(
                    controller: stageController,
                    decoration: const InputDecoration(
                      hintText: "Stage",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            TextField(
              maxLines: null,
              controller: orientController,
              decoration: const InputDecoration(
                hintText: "Orientation",
              ),
            ),
            SizedBox(height: 15.h),
            const CategorySelect(),
            SizedBox(height: 15.h),
            GlobalInk(
                text: "Save",
                onTap: () async {
                  await LocalDatabase.insertPlace(
                    PlaceModel(
                      placeCategory: context.read<MapViewModel>().icons,
                      latLng: latLng.target,
                      placeName: locationController.text,
                      entrance: entranceController.text,
                      flatNumber: flatController.text,
                      orientAddress: orientController.text,
                      stage: stageController.text,
                    ),
                  );
                  context.read<HomeViewModel>().getAllPlaces();
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
