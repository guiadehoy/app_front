import 'package:app_scanner/ui/login_screen.dart';
import 'package:app_scanner/ui/qr_screen.dart';
import 'package:app_scanner/ui/splash_screen.dart';
import 'package:app_scanner/ui/welcome_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String qr = '/qr';
  static const String login = '/login';
  static const String splash = '/splash';
  static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    qr: (BuildContext context) => QrScreen(
          title: "QR",
        ),
    splash: (BuildContext context) => SplashScreen(),
    home: (BuildContext context) => WelcomeScreen(),
  };
}
