import 'package:app_scanner/routes.dart';
import 'package:app_scanner/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Scanner',
      initialRoute: Routes.splash,
      routes: Routes.routes,
      theme: ThemeData(
        primaryColor: Utils.parseColor("#774595"),
      ),
    );
  }
}
