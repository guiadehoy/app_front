import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/constants/preferences.dart';
import 'package:app_scanner/models/login_response.dart';
import 'package:app_scanner/routes.dart';
import 'package:app_scanner/store/form/login_form.dart';
import 'package:app_scanner/utils/api_client.dart';
import 'package:app_scanner/utils/device_utils.dart';
import 'package:app_scanner/utils/preferences.dart';
import 'package:app_scanner/utils/utils.dart';
import 'package:app_scanner/widgets/app_icon_widget.dart';
import 'package:app_scanner/widgets/empty_app_bar_widget.dart';
import 'package:app_scanner/widgets/rounded_button_widget.dart';
import 'package:app_scanner/widgets/textfield_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late LoginStore _loginStore;
  late FocusNode _passwordFocusNode;
  late bool isObscure = true;
  late IconData suffix = Icons.visibility_off;
  late Client _client = Client();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    _loginStore = Provider.of<LoginStore>(context);
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
          MediaQuery.of(context).orientation == Orientation.landscape
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildLeftSide(),
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildRightSide(),
                    ),
                  ],
                )
              : Center(child: _buildRightSide()),
        ],
      ),
    );
  }

  Widget _buildLeftSide() {
    return SizedBox.expand(
      child: Image.asset(
        Assets.carBackground,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 32.0),
              child: AppIconWidget(
                image: Assets.logoLogin,
              ),
            ),
            _buildTitle(),
            SizedBox(height: 16.0),
            Observer(
              builder: (_) => _buildUserIdField(),
            ),
            Observer(
              builder: (_) => _buildPasswordField(),
            ),
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
                child: Observer(
                  builder: (_) => _buildSignInButton(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "¡Bienvenido organizor!",
      style: TextStyle(
          color: Utils.parseColor("#62617D"),
          fontSize: 20.0,
          letterSpacing: -0.4,
          fontWeight: FontWeight.bold),
    );
  }

  Widget _buildUserIdField() {
    return TextFieldWidget(
      label: "Correo electrónico",
      hint: "Correo electrónico",
      inputType: TextInputType.emailAddress,
      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
      textController: _userEmailController,
      inputAction: TextInputAction.next,
      autoFocus: false,
      maxLength: 100,
      onChanged: (value) {
        _loginStore.setUserId(value);
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      errorText: _loginStore.formErrorStore.userEmail,
    );
  }

  setInputPassword() {
    setState(() {
      this.isObscure = !this.isObscure;
    });

    if (this.isObscure) {
      setState(() {
        suffix = Icons.visibility_off;
      });
    } else {
      setState(() {
        suffix = Icons.visibility;
      });
    }
  }

  Widget _buildPasswordField() {
    return TextFieldWidget(
      label: "Contraseña",
      hint: "Contraseña",
      isObscure: isObscure,
      suffix: suffix,
      onPressedSuffix: () => setInputPassword(),
      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
      textController: _passwordController,
      focusNode: _passwordFocusNode,
      errorText: _loginStore.formErrorStore.password,
      onChanged: (value) {
        _loginStore.setPassword(value);
      },
    );
  }

  Widget _buildSignInButton() {
    return RoundedButtonWidget(
        buttonText: "Iniciar sesión",
        buttonColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: _loginStore.canLogin ? login : null);
  }

  login() async {
    DeviceUtils.hideKeyboard(context);
    LoginResponse response =
        await loginService(_userEmailController.text, _passwordController.text);
    await Preference.setItem(Preferences.auth_token, response.accessToken);
    await Preference.setItem(Preferences.refresh_token, response.refreshToken);
  }

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    Future.delayed(
      Duration(milliseconds: 0),
      () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.home, (Route<dynamic> route) => false);
      },
    );

    return Container();
  }

  Future<LoginResponse> loginService(email, password) async {
    Utils.checkConnection(context);
    try {
      final response = await _client.init().post('/scanner/auth/login',
          data: {"email": email, "password": password});

      _loginStore.login();

      return LoginResponse.fromJson(response.data);
    } on DioError catch (ex) {
      String errorMessage = Utils.manageError(ex);
      throw new Exception(errorMessage);
    }
  }

  @override
  void dispose() {
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
