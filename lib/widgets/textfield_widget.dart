import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData icon;
  final IconData? suffix;
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
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final VoidCallback? onPressedSuffix;
  final bool autoFocus;
  final TextInputAction inputAction;
  final int maxLength;

  const TextFieldWidget(
      {Key? key,
      this.icon = Icons.person,
      this.hint = "",
      this.errorText = "",
      this.isObscure = false,
      this.enabled = true,
      this.inputType = TextInputType.text,
      required this.textController,
      this.label = '',
      this.isIcon = false,
      this.padding = const EdgeInsets.all(0),
      this.hintColor = Colors.grey,
      this.iconColor = Colors.grey,
      this.focusNode,
      this.onFieldSubmitted,
      this.onChanged,
      this.onPressedSuffix,
      this.maxLength = 25,
      this.autoFocus = false,
      this.inputAction = TextInputAction.next,
      this.suffix})
      : super(key: key);

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
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
            hintText: this.hint,
            suffixIcon: suffix != null
                ? GestureDetector(
                    onTap: onPressedSuffix,
                    child: Icon(
                      Icons.visibility,
                    ),
                  )
                : null,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: hintColor),
            errorText: errorText != "" ? errorText : null,
            counterText: '',
            icon: isIcon ? Icon(this.icon, color: iconColor) : null),
      ),
    );
  }
}
