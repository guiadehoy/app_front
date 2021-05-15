import 'package:app_scanner/constants/assets.dart';
import 'package:app_scanner/widgets/app_icon_widget.dart';
import 'package:app_scanner/widgets/empty_app_bar_widget.dart';
import 'package:app_scanner/widgets/rounded_button_widget.dart';
import 'package:app_scanner/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //focus node:-----------------------------------------------------------------
  FocusNode _passwordFocusNode;

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
              padding: EdgeInsets.only(bottom: 24.0),
              child: AppIconWidget(
                image: Assets.logoLogin,
              ),
            ),
            //SizedBox(height: 24.0),
            _buildUserIdField(),
            _buildPasswordField(),
            /*  SizedBox(
                height: 48.0,
                width: double.infinity, // <-- match_parent
                child: _buildForgotPasswordButton()), */
            Padding(
              padding: EdgeInsets.only(top: 48.0),
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

  Widget _buildUserIdField() {
    return TextFieldWidget(
      label: "Usuario",
      hint: "Usuario",
      inputType: TextInputType.emailAddress,
      icon: Icons.person,
      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
      iconColor: Colors.black54,
      textController: _userEmailController,
      inputAction: TextInputAction.next,
      autoFocus: false,
      maxLength: 100,
      onChanged: (value) {
        print(value);
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      errorText: "error",
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
      errorText: "Error",
      onChanged: (value) {
        print(value);
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: FractionalOffset.centerRight,
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Text(
          "",
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: Colors.blueAccent),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildSignInButton() {
    return RoundedButtonWidget(
      buttonText: "Login",
      buttonColor: Colors.blueAccent,
      textColor: Colors.white,
      onPressed: () async {
        print("_buildSignInButton");
      },
    );
  }

  Widget navigate(BuildContext context) {
    print("navigate");
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
