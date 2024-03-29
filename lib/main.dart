import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_example/screens/routes.dart';
import 'package:google_map_example/screens/splash/splash_screen.dart';
import 'package:google_map_example/view_models/location_view_model.dart';
import 'package:google_map_example/view_models/map_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapViewModel()),
        ChangeNotifierProvider(create: (_)=> LocationViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.read<LocationViewModel>().getUserLocation();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesNames.splash,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
