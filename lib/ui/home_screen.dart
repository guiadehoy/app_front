import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/constants/preferences.dart';
import 'package:app_scanner/store/form/login_form.dart';
import 'package:app_scanner/widgets/empty_app_bar_widget.dart';
import 'package:app_scanner/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _loginStore = LoginStore();
  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  List<Color> _colors = [
    const Color(0xFF774595),
    const Color(0xFF774595),
  ];

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: _buildBody(),
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
            Observer(
              builder: (context) {
                return _loginStore.success ? navigate(context) : Container();
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: SizedBox(
                height: 48.0,
                width: double.infinity, // <-- match_parent
                child: _buildSignInButton(),
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
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 46.0),
      child: Text(
        "Cerrar sesión",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return RoundedButtonWidget(
      buttonText: "Escanear entradas",
      fontWeight: FontWeight.bold,
      buttonColor: Color(0xFFE9E1EE),
      textColor: Theme.of(context).primaryColor,
      onPressed: () async {
        Future.delayed(
          Duration(milliseconds: 0),
          () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.qr, (Route<dynamic> route) => false);
          },
        );
      },
    );
  }

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });

    return Container();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
