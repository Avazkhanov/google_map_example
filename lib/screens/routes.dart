import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_example/screens/google_map/google_map_screen.dart';
import 'package:google_map_example/screens/home/home_screen.dart';
import 'package:google_map_example/screens/splash/splash_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.splash:
        return navigate(const SplashScreen());
      case RoutesNames.map:
        return navigate( GoogleMapScreen(initialPosition: settings.arguments as CameraPosition,));
      case RoutesNames.home:
        return navigate(const HomeScreen());
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
  static const String home = '/home';

}