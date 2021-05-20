import 'dart:async';

import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/routes.dart';
import 'package:app_scanner/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF774595), Color(0xFF774595)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Center(child: AppIconWidget(image: Assets.appLogo)),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 4000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    Navigator.of(context).pushReplacementNamed(Routes.login);
  }
}
