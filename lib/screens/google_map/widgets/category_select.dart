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
  final List<String> _icons = [AppImages.home, AppImages.work, AppImages.other];
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    context.read<MapViewModel>().icons = _icons[_activeIndex];
    return Row(
      children: List.generate(
        _icons.length,
        (index) => Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.only(left: 60.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
              border: _activeIndex == index
                  ? Border.all(
                      width: 1.w,
                      color: Colors.blue,
                    )
                  : null,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10.r),
              onTap: () {
                setState(() {
                  _activeIndex = index;
                  context.read<MapViewModel>().icons = _icons[index];
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                child: Image.asset(_icons[index],height: 20.h,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
