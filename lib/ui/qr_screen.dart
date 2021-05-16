// ignore: import_of_legacy_library_into_null_safe
import 'package:app_scanner/routes.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';

class QrScreen extends StatefulWidget {
  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  String qrCodeResult = "Aún no escaneada";

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
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Message displayed over here
            Text(
              "Resultado",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              padding: EdgeInsets.all(15),
              onPressed: () async {
                String codeSanner =
                    await BarcodeScanner.scan(); //barcode scnner
                setState(() {
                  qrCodeResult = codeSanner;
                });
              },
              child: Text(
                "Escanear",
                style: TextStyle(color: Colors.indigo[900]),
              ),
              //Button having rounded rectangle border
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
