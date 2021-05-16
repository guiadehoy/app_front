import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFFB361CF), Color(0xFF774595)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Center(child: AppIconWidget(image: Assets.logoQr)),
    );
  }
}
