import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String label;
  final String errorText;
  final bool isObscure;
  final bool isIcon;
  final bool enabled;
  final TextInputType inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode focusNode;
  final ValueChanged onFieldSubmitted;
  final ValueChanged onChanged;
  final bool autoFocus;
  final TextInputAction inputAction;
  final int maxLength;

  const TextFieldWidget({
    Key key,
    this.icon,
    this.hint,
    this.errorText,
    this.isObscure = false,
    this.enabled = true,
    this.inputType,
    this.textController,
    this.label = '',
    this.isIcon = true,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.maxLength = 25,
    this.autoFocus = false,
    this.inputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: textController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus,
        textInputAction: inputAction,
        obscureText: this.isObscure,
        maxLength: this.maxLength,
        keyboardType: this.inputType,
        enabled: enabled,
        // ignore: deprecated_member_use
        style: Theme.of(context).textTheme.body1,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
            hintText: this.hint,
            hintStyle:
                // ignore: deprecated_member_use
                Theme.of(context).textTheme.body1.copyWith(color: hintColor),
            errorText: errorText,
            counterText: '',
            // ignore: dead_code
            icon: false ? Icon(this.icon, color: iconColor) : null),
      ),
    );
  }
}
