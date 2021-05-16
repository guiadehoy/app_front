import 'package:app_scanner/routes.dart';
import 'package:flutter/material.dart';

class QrScreen extends StatefulWidget {
  QrScreen({Key? key}) : super(key: key);

  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.home, (Route<dynamic> route) => false);
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
