import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalInk extends StatelessWidget {
  const GlobalInk({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        height: 40.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r), color: Colors.amber),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15.r),
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
