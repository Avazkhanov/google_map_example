import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_example/screens/google_map/google_map_screen.dart';
import 'package:google_map_example/screens/splash/splash_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splash:
        return navigate(const SplashScreen());
      case RoutesNames.map:
        return navigate( GoogleMapScreen());
      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text('This page does not exist'),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) =>
      CupertinoPageRoute(builder: (context) => widget);
}

class RoutesNames {
  static const String splash = '/';
  static const String map = '/map';

}