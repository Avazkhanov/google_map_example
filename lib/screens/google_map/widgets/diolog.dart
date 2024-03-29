import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_example/screens/google_map/widgets/category_select.dart';
import 'package:google_map_example/services/local_notification_service.dart';
import 'package:google_map_example/view_models/map_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

TextEditingController _titleController = TextEditingController();
TextEditingController _locationController = TextEditingController();

showCategoryDialog({required BuildContext context, required LatLng position}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 10.w,
            right: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15.h),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Title",
              ),
            ),
            SizedBox(height: 15.h),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                hintText: "Location",
              ),
            ),
            SizedBox(height: 15.h),
            const CategorySelect(),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Ink(
                  height: 40.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(width: 1.w, color: Colors.blue)),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(15.r),
                    child: const Center(child: Text("Cancel")),
                  ),
                ),
                Ink(
                  height: 40.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(width: 1.w, color: Colors.blue)),
                  child: InkWell(
                    onTap: () {
                      context.read<MapViewModel>().addNewMarker(
                            position: position,
                            title: _titleController.text,
                            snippet: _locationController.text,
                          );
                      _titleController.clear();
                      _locationController.clear();
                      LocalNotificationService.localNotificationService
                          .showNotification(
                        title: "Diqqat !",
                        body: "Foydalanuvchi kordinatasi: ${position.longitude},${position.latitude} ga o'zgardi",
                        id: DateTime.now().millisecondsSinceEpoch ~/ 10000,
                      );
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(15.r),
                    child: const Center(child: Text("Save")),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
          ],
        ),
      );
    },
  );
}
