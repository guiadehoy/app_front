import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/widgets/empty_app_bar_widget.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  late String error;
  ErrorScreen({required this.error});
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

  Widget header(BuildContext context) {
    return Column(
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
            child: _buildErrorTitle(),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: 24.0,
              left: 56.0,
              right: 56.0,
            ),
            child: _buildErrorMessage(widget.error),
          ),
        ),
      ],
    );
  }

  Widget closeIcon(BuildContext context) {
    return Center(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        height: double.maxFinite,
        child: new Stack(
          children: <Widget>[
            new Positioned(
              child: header(context),
            ),
            new Positioned(
              bottom: 0.0,
              left: 0,
              right: 0,
              child: new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: closeIcon(context)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildErrorTitle() {
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

  Widget _buildErrorMessage(String error) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        error,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.48,
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
