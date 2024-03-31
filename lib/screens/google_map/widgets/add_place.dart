import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_example/data/models/place_model.dart';
import 'package:google_map_example/screens/globals/global_ink.dart';
import 'package:google_map_example/screens/google_map/widgets/category_select.dart';
import 'package:google_map_example/utils/extensions/extension.dart';
import 'package:google_map_example/view_models/firebase_view_model.dart';
import 'package:google_map_example/view_models/map_view_model.dart';
import 'package:provider/provider.dart';

class AddPlace extends StatelessWidget {
  const AddPlace({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController locationController = TextEditingController(
        text: context.watch<MapViewModel>().currentPlaceName);
    final TextEditingController entranceController = TextEditingController();
    final TextEditingController flatController = TextEditingController();
    final TextEditingController stageController = TextEditingController();
    final TextEditingController orientController = TextEditingController();
    if (context.watch<MapViewModel>().isEdit) {
      entranceController.text =
          context.watch<MapViewModel>().placeModel!.entrance;
      flatController.text =
          context.watch<MapViewModel>().placeModel!.flatNumber;
      stageController.text = context.watch<MapViewModel>().placeModel!.stage;
      orientController.text =
          context.watch<MapViewModel>().placeModel!.orientAddress;
    }

    var latLng = context.read<MapViewModel>().currentCameraPosition;
    debugPrint("$latLng");
    return Container(
      height: 280.h,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.r))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: context.watch<FireBaseViewModel>().getLoader
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 15.h),
                  TextField(
                    maxLines: 2,
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
                      text: context.watch<MapViewModel>().isEdit
                          ? "Change Save"
                          : "Save",
                      onTap: () async {
                        if (context.read<MapViewModel>().isEdit) {
                          var temp = context.read<MapViewModel>().placeModel;
                          temp = temp!.copyWith(
                            placeName: locationController.text,
                            entrance: entranceController.text,
                            flatNumber: flatController.text,
                            stage: stageController.text,
                            orientAddress: orientController.text,
                          );
                          await context
                              .read<FireBaseViewModel>()
                              .updatePlace(temp, context);
                        } else {
                          await context
                              .read<FireBaseViewModel>()
                              .insertProducts(
                                  PlaceModel(
                                    placeCategory:
                                        context.read<MapViewModel>().icons,
                                    latLng: latLng.target,
                                    placeName: locationController.text,
                                    entrance: entranceController.text,
                                    flatNumber: flatController.text,
                                    orientAddress: orientController.text,
                                    stage: stageController.text,
                                  ),
                                  context);
                        }
                      }),
                ],
              ),
      ),
    );
  }
}
