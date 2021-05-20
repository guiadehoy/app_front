import 'package:app_scanner/routes.dart';
import 'package:flutter/material.dart';

class CheckQrScreen extends StatefulWidget {
  final String qrResult;

  CheckQrScreen({required this.qrResult});
  @override
  _CheckQrScreenState createState() => _CheckQrScreenState();
}

class _CheckQrScreenState extends State<CheckQrScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Escanear entradas",
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Future.delayed(
                  Duration(milliseconds: 0),
                  () {
                    Navigator.of(context).pushNamed(Routes.detail);
                  },
                );
              },
              child: Icon(
                Icons.close,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Text(widget.qrResult),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
