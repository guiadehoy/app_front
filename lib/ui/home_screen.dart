import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/widgets/app_icon_widget.dart';
import 'package:app_scanner/widgets/empty_app_bar_widget.dart';
import 'package:app_scanner/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFB361CF), Color(0xFF774595)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Cerrar sesión",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 48.0,
                ),
                child: Center(child: AppIconWidget(image: Assets.logoQr)),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 48.0,
                ),
                child: Text(
                  "1",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              _buildScanInButton(),
            ]),
      ),
    );
  }

  Widget _buildScanInButton() {
    return RoundedButtonWidget(
      buttonText: "Iniciar sesión",
      buttonColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        print("object");
      },
    );
  }
}
