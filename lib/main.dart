import 'package:app_scanner/constants/app_theme.dart';
import 'package:app_scanner/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/strings.dart';

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
      title: Strings.appName,
      initialRoute: Routes.splash,
      routes: Routes.routes,
      theme: themeData,
    );
  }
}
