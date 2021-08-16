import 'dart:async';

import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/routes.dart';
import 'package:app_scanner/utils/Utils.dart';
import 'package:app_scanner/utils/remote_service.dart';
import 'package:app_scanner/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';

import 'no_connection.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late RemoteConfigService _remoteConfigService;

  initializeRemoteConfig() async {
    _remoteConfigService = (await RemoteConfigService.getInstance())!;
    await _remoteConfigService.initialize();
  }

  @override
  void initState() {
    initializeRemoteConfig();
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF774595),
            Color(0xFF774595),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: AppIconWidget(
          image: Assets.appLogo,
        ),
      ),
    );
  }

  Future<void> noConnectionCheck() async {
    bool _permissionStatus = await Utils.internetConnectivity();
    if (!_permissionStatus) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoConnectionScreen(),
        ),
      );
    }
  }

  startTimer() {
    noConnectionCheck();
    var _duration = Duration(milliseconds: 4000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    Navigator.of(context).pushNamed(Routes.home);
  }
}
