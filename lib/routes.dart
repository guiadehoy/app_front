import 'package:app_scanner/ui/in_app_webiew_example.screen.dart';
import 'package:app_scanner/ui/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String login = '/login';
  static const String food = '/food';

  static const String splash = '/splash';
  static const String home = '/home';
  static const String next = '/next';
  static const String history = '/history';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => InAppWebViewExampleScreen(
          url: 'https://app.dev.guiadehoy.com/login',
        ),
    food: (BuildContext context) => InAppWebViewExampleScreen(
          url: 'https://app.dev.guiadehoy.com/food',
        ),
    splash: (BuildContext context) => SplashScreen(),
    home: (BuildContext context) => InAppWebViewExampleScreen(
          url: 'https://app.dev.guiadehoy.com',
        ),
    next: (BuildContext context) => InAppWebViewExampleScreen(
          url: 'https://app.dev.guiadehoy.com/siguientes-eventos',
        ),
    history: (BuildContext context) => InAppWebViewExampleScreen(
          url: 'https://app.dev.guiadehoy.com/eventos-pasados',
        ),
  };
}
