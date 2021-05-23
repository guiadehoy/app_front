import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/routes.dart';
import 'package:app_scanner/store/form/login_form.dart';
import 'package:app_scanner/ui/check_qr_screen.dart';
import 'package:app_scanner/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailEventScreen extends StatefulWidget {
  DetailEventScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DetailEventScreenState createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  String qrCodeResult = "Aún no escaneada";
  String _scanBarcode = 'Unknown';

  late LoginStore _loginStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _loginStore = Provider.of<LoginStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Material(
      child: Center(
        child: _buildRightSide(),
      ),
    );
  }

  Widget _buildRightSide() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 70.0),
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
              cacheHeight: 172,
              cacheWidth: 172,
            ),
            SizedBox(height: 16.0),
            _buildTCounter(),
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
        "1920",
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
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    if (barcodeScanRes == "-1") {
      barcodeScanRes = 'No haz escaneado ningun boleto';
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckQrScreen(
            qrResult: _scanBarcode,
          ),
        ),
      );
    }

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
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
