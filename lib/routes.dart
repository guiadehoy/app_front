import 'package:app_scanner/ui/error_screen.dart';
import 'package:app_scanner/ui/home_screen.dart';
import 'package:app_scanner/ui/login_screen.dart';
import 'package:app_scanner/ui/qr_screen.dart';
import 'package:app_scanner/ui/result_screen.dart';
import 'package:app_scanner/ui/splash_screen.dart';
import 'package:app_scanner/ui/datail_event_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String qr = '/qr';
  static const String login = '/login';
  static const String splash = '/splash';
  static const String detail = '/detail';
  static const String result = '/result';
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    qr: (BuildContext context) => QrScreen(),
    splash: (BuildContext context) => SplashScreen(),
    detail: (BuildContext context) => DetailEventScreen(),
    result: (BuildContext context) => ResultScreen(),
    home: (BuildContext context) => HomeScreen(),
  };
}
