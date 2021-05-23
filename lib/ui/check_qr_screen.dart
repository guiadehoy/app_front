import 'dart:convert';

import 'package:app_scanner/models/qr_response.dart';
import 'package:app_scanner/ui/error_screen.dart';
import 'package:app_scanner/ui/result_screen.dart';
import 'package:app_scanner/utils/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CheckQrScreen extends StatefulWidget {
  final String qrResult;

  CheckQrScreen({required this.qrResult});
  @override
  _CheckQrScreenState createState() => _CheckQrScreenState();
}

class _CheckQrScreenState extends State<CheckQrScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Client _client = Client();

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    readQr(widget.qrResult);
    super.dispose();
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
          "Validando información",
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        /* actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.home);
              },
              child: Icon(
                Icons.close,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          ),
        ],*/
      ),
      body: Center(
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            alignment: Alignment.center,
            height: 50,
            width: 250,
            child: Text(
              "Cargando información de QR",
            ),
          ),
        ),
      ),
    );
  }

  Future<QrResponse> readQr(qr) async {
    print(qr);
    try {
      final response =
          await _client.init().post('/scanner/qr', data: {"qr": qr});
      late QrResponse data = QrResponse.fromJson(response.data);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            qrResponse: data,
          ),
        ),
      );
      print(data.name);
      print(data.typeTicket);
      print(data.message);

      return data;
    } on DioError catch (ex) {
      String errorMessage = json.decode(ex.response.toString())["message"];
      print(errorMessage);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorScreen(
            error: errorMessage,
          ),
        ),
      );
      throw new Exception(errorMessage);
    }
  }
}
