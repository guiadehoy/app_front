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
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 128.0),
                  child: Image.asset(
                    Assets.okIcon,
                    cacheHeight: 96,
                    cacheWidth: 96,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 56.0),
                  child: _buildWlcomeText(),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: _buildNameUser(),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: _buildTypeTicket(),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 168.0,
                    bottom: 36.0,
                  ),
                  child: Image.asset(
                    Assets.closeIcon,
                    cacheHeight: 64,
                    cacheWidth: 64,
                  ),
                ),
              ),
            ],
          ),
        ));
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
        textAlign: TextAlign.center,
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
