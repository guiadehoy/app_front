import 'package:app_scanner/routes.dart';
import 'package:bot_toast/bot_toast.dart';
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
                    Navigator.of(context).pushNamed(Routes.detail);
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
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeTransition(
                opacity: animationController,
                child: IconButton(
                  icon: Icon(Icons.favorite, color: Colors.redAccent, size: 30),
                  onPressed: handleTap,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Loading",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handleTap() {
    BotToast.showCustomText(
        onlyOne: true,
        duration: null,
        toastBuilder: (textCancel) => Align(
              alignment: Alignment(0, 0.8),
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        textCancel();
                      },
                    ),
                  ],
                ),
              ),
            ));
  }
}
