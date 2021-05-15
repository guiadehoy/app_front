import 'package:app_scanner/views/login_screen.dart';
import 'package:app_scanner/views/qr_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String qr = '/qr';
  static const String login = '/login';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(
          title: "Login",
        ),
    qr: (BuildContext context) => QrScreen(
          title: "QR",
        ),
  };
}
