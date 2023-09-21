import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  
  final bool enabled;
  final int maxLines;
  final bool obscureText;
  final bool isCollapsed;
  final TextStyle? style;
  final String? hintLabel;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final TextAlignVertical? textAlignVertical;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readOnly;

  const CustomInput({
    super.key,
    this.style,
    this.hintLabel,
    this.focusNode,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.enabled = true,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.obscureText = false,
    this.isCollapsed = false,
    this.textInputType = TextInputType.text,
    this.readOnly = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      enabled: enabled,
      maxLines: maxLines,
      textAlign: textAlign,
      focusNode: focusNode,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      textAlignVertical: textAlignVertical,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hintLabel,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        isCollapsed: isCollapsed,
      ),
    );
  }
}
