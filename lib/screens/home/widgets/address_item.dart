import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_example/data/models/place_category.dart';
import 'package:google_map_example/screens/routes.dart';
import 'package:google_map_example/utils/images/app_images.dart';
import 'package:google_map_example/view_models/home_view_model.dart';
import 'package:google_map_example/view_models/map_view_model.dart';
import 'package:provider/provider.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<HomeViewModel>();
    return Expanded(
      child: ListView.separated(
        itemCount: provider.places.length,
        itemBuilder: (context, index) {
          var place = provider.places[index];
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 12,
                    offset: Offset(0, 12),
                  ),
                ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15.r),
                onTap: () {
                  Provider.of<MapViewModel>(context, listen: false)
                      .setLatInitialLong(place.latLng);
                  context.read<HomeViewModel>().isEdit = true;
                  // context.read<HomeViewModel>().index = place.id!;
                  Navigator.pushNamed(context, RoutesNames.map,
                      arguments:
                          context.read<MapViewModel>().initialCameraPosition!);
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                  child: Row(
                    children: [
                      Image.asset(place.placeCategory,
                          height: 30.h, width: 30.w),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getCategory(place.placeCategory),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp),
                            ),
                            SizedBox(height: 5.h),
                            Text(place.placeName),
                            SizedBox(height: 5.h),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          provider.deletePlace(place);
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 10.h);
        },
      ),
    );
  }
}

getCategory(String v) {
  switch (v) {
    case AppImages.home:
      return PlaceCategory.Home.name;
    case AppImages.work:
      return PlaceCategory.Work.name;
    case AppImages.other:
      return PlaceCategory.Other.name;
    default:
      return PlaceCategory.Home.name;
  }
}
