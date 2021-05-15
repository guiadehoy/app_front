import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final double fontSize;

  const RoundedButtonWidget({
    Key key,
    this.buttonText,
    this.buttonColor,
    this.fontSize = 16.0,
    this.textColor = Colors.white,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: buttonColor,
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: Theme.of(context)
            .textTheme
            .button
            .copyWith(color: textColor, fontSize: fontSize),
      ),
    );
  }
}