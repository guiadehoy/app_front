import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/routes.dart';
import 'package:app_scanner/ui/check_qr_screen.dart';
import 'package:app_scanner/widgets/empty_app_bar_widget.dart';
import 'package:app_scanner/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class DetailEventScreen extends StatefulWidget {
  @override
  _DetailEventScreenState createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  String qrCodeResult = "Aún no escaneada";
  String _scanBarcode = 'Unknown';
  List<Color> _colors = [
    const Color(0xFF774595),
    const Color(0xFF774595),
  ];

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
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _colors,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildLogOut(),
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Image.asset(
                Assets.logoQr,
                cacheHeight: 245,
                cacheWidth: 245,
              ),
            ),
            SizedBox(height: 16.0),
            _buildTCounter(),
            SizedBox(height: 16.0),
            _buildTitleScaner(),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.only(top: 24.0),
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
        "0",
        style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
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
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLogOut() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: () {
          logout(context);
        },
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: 30.0,
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
      buttonColor: Color(0xFFE9E1EE),
      textColor: Theme.of(context).primaryColor,
      onPressed: () async {
        scanQR();
      },
    );
  }

  void logout(BuildContext context) {
    print("cerrar sesión");
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
