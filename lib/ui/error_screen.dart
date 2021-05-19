import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/widgets/empty_app_bar_widget.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
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
          color: Colors.black12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 128.0),
                  child: Image.asset(
                    Assets.errorIcon,
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
                  padding: EdgeInsets.only(
                    top: 24.0,
                    left: 56.0,
                    right: 56.0,
                  ),
                  child: _buildError(),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 190.0,
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
        "Error",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          color: const Color(0xFF999999),
        ),
      ),
    );
  }

  Widget _buildError() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "El ticket ya ha sido escaneado previamente",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.4,
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
