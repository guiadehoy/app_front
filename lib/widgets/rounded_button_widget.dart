import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final FontWeight fontWeight;

  final Color buttonColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double fontSize;

  const RoundedButtonWidget({
    Key? key,
    this.buttonText = "",
    this.fontWeight = FontWeight.normal,
    this.buttonColor = Colors.blue,
    this.fontSize = 16.0,
    this.textColor = Colors.white,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
            else if (states.contains(MaterialState.disabled))
              return Color(0xFFBEBED1);
            return buttonColor; // Use the component's default.
          },
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.button!.copyWith(
            color: textColor, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
