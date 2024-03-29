import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_example/utils/images/app_images.dart';
import 'package:google_map_example/view_models/map_view_model.dart';
import 'package:provider/provider.dart';

class CategorySelect extends StatefulWidget {
  const CategorySelect({super.key});

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  int _activeIndex = -1;
  final List<String> _icons = [AppImages.home, AppImages.work, AppImages.other];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        _icons.length,
        (index) => Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.only(left: 30.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.white,
              border: _activeIndex == index
                  ? Border.all(
                      width: 1.w,
                      color: Colors.blue,
                    )
                  : null,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(15.r),
              onTap: () {
                setState(() {
                  _activeIndex = index;
                  context.read<MapViewModel>().icons = _icons[index];
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Image.asset(_icons[index],height: 40.h,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
