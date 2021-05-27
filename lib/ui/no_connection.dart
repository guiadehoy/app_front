import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';

class NoConnectionScreen extends StatefulWidget {
  @override
  _NoConnectionScreenState createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  right: 16.0,
                ),
                child: Icon(
                  Icons.close,
                  size: 26.0,
                  color: const Color(0xFF666666),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 42.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 42.0,
                  ),
                  child: Image.asset(
                    Assets.sleepIcon,
                    cacheHeight: 120,
                    cacheWidth: 122,
                  ),
                ),
                Text(
                  "Has perdido tu",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.18,
                      color: const Color(0xFF333333)),
                ),
                Text(
                  "conexión a internet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.18,
                      color: const Color(0xFF333333)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 24.0,
                  ),
                  child: Text(
                    "Revisa tu conexión a internet",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      letterSpacing: 0.15,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ),
                Text(
                  "y vuelve a intentarlo.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 0.15,
                    color: const Color(0xFF666666),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 48.0,
                  ),
                  child: SizedBox(
                    height: 48.0,
                    width: 148.0,
                    child: RoundedButtonWidget(
                      buttonText: "Reintentar",
                      buttonColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
