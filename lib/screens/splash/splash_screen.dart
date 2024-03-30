import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_example/screens/routes.dart';
import 'package:google_map_example/utils/extensions/extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init()async{
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, RoutesNames.home);
  }

  @override
  void initState() {
    _init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Center(
          child: Icon(
            CupertinoIcons.location,
            size: 60.sp,
          ),
        ),
      ),
    );
  }
}
