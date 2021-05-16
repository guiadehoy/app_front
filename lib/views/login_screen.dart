import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/store/form/login_form.dart';
import 'package:app_scanner/utils/utils.dart';
import 'package:app_scanner/widgets/app_icon_widget.dart';
import 'package:app_scanner/widgets/empty_app_bar_widget.dart';
import 'package:app_scanner/widgets/rounded_button_widget.dart';
import 'package:app_scanner/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _loginStore = LoginStore();
  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

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
      icon: Icons.person,
      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
      iconColor: Colors.black54,
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

  Widget _buildPasswordField() {
    return TextFieldWidget(
      label: "Contraseña",
      hint: "Contraseña",
      isObscure: true,
      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
      icon: Icons.lock,
      iconColor: Colors.black54,
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
      onPressed: () async {
        print("object");
      },
    );
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
