import 'dart:async';
import 'dart:convert';

import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/models/qr_response.dart';
import 'package:app_scanner/routes.dart';
import 'package:app_scanner/store/form/login_form.dart';
import 'package:app_scanner/ui/error_screen.dart';
import 'package:app_scanner/ui/result_screen.dart';
import 'package:app_scanner/utils/api_client.dart';
import 'package:app_scanner/utils/preferences.dart';
import 'package:app_scanner/widgets/rounded_button_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailEventScreen extends StatefulWidget {
  late bool? openQr = false;

  DetailEventScreen({
    Key? key,
    this.openQr,
  }) : super(key: key);

  @override
  _DetailEventScreenState createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  String qrCodeResult = "Aún no escaneada";
  late Client _client = Client();
  late bool loading = true;

  late LoginStore _loginStore;

  @override
  void didChangeDependencies() {
    _loginStore = Provider.of<LoginStore>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    bool? dataRead = widget.openQr;
    if (dataRead != null && dataRead) {
      startTimercAndScan();
    }
    startTimer();
  }

  Future<QrResponse> readQr(qr) async {
    try {
      final response = await _client.init().post('/scanner/qr', data: {
        "code": 200,
        "qr": qr,
        "id_event": _loginStore.eventSelected!.id
      });
      late QrResponse data = QrResponse.fromJson(response.data);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            qrResponse: data,
          ),
        ),
      );

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

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Material(
      child: Center(
        child: this.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _buildRightSide(),
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 1000);
    return Timer(_duration, setLoading);
  }

  startTimercAndScan() {
    var _duration = Duration(milliseconds: 1000);
    return Timer(_duration, setLoadingScan);
  }

  setLoading() {
    getsumScannerItems(_loginStore.eventSelected!.id);
    setState(() {
      this.loading = false;
    });
  }

  setLoadingScan() async {
    await scanQR();
  }

  Widget _buildRightSide() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: const Color(0xFF7E7E7E),
                      ),
                      onTap: () {
                        _returnToHome();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 20.0),
                    child: Column(
                      children: [
                        Text(
                          _loginStore.eventSelected!.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.4,
                          ),
                        ),
                        Text(
                          _loginStore.eventSelected!.hourLabel,
                          style: TextStyle(
                            fontSize: 14.0,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Image.asset(
              Assets.logoQr,
              cacheHeight: 194,
              cacheWidth: 192,
            ),
            SizedBox(height: 16.0),
            Observer(
              builder: (_) => _buildTCounter(),
            ),
            SizedBox(height: 16.0),
            _buildTitleScaner(),
            Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: SizedBox(
                height: 48.0,
                width: double.infinity, // <-- match_parent
                child: _buildScanButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTCounter() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '${_loginStore.countScanned}',
        style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildTitleScaner() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Escaneados",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    if (barcodeScanRes == "-1") {
      barcodeScanRes = 'No haz escaneado ningun boleto';
    } else {
      await readQr(barcodeScanRes);
      int count = await sumScannerItems(_loginStore.eventSelected!.id);
      _loginStore.setCountScanned(count);
    }
    if (widget.openQr != null && widget.openQr == true) {
      setState(() {
        this.loading = false;
      });
    }
  }

  sumScannerItems(idEvent) async {
    String key = 'event-$idEvent';
    int countSum = await Preference.getInt(key);
    int count = countSum + 1;
    await Preference.setInt(key, count);
    return count;
  }

  getsumScannerItems(idEvent) async {
    String key = 'event-$idEvent';
    int count = await Preference.getInt(key);
    _loginStore.setCountScanned(count);
    return count;
  }

  Widget _buildScanButton() {
    return RoundedButtonWidget(
      buttonText: "Escanear entradas",
      fontWeight: FontWeight.bold,
      buttonColor: Theme.of(context).primaryColor,
      textColor: Color(0xFFE9E1EE),
      onPressed: () async {
        scanQR();
      },
    );
  }

  void _returnToHome() {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
