import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/widgets/empty_app_bar_widget.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
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
      body: _buildRightSide(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          Center(child: _buildRightSide()),
        ],
      ),
    );
  }

  Widget _buildRightSide() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            Assets.logoQr,
            cacheHeight: 80,
            cacheWidth: 80,
          ),
          SizedBox(height: 16.0),
          _buildWlcomeText(),
          SizedBox(height: 16.0),
          _buildNameUser(),
          SizedBox(height: 16.0),
          _buildTypeTicket(),
          Image.asset(
            Assets.logoQr,
            cacheHeight: 65,
            cacheWidth: 65,
          ),
        ],
      ),
    );
  }

  Widget _buildWlcomeText() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Bienvenido(a)",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          color: const Color(0xFF999999),
        ),
      ),
    );
  }

  Widget _buildNameUser() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Carlos Galaviz",
        style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.8,
          color: const Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildTypeTicket() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Ticket: Entrada general",
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          color: const Color(0xFF333333),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
