import 'package:flutter/material.dart';
import 'package:opx_certification/design/app_colors.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final bool autofocus;
  final bool enabled;
  final Color fillColor;
  final Color cursorColor;
  final VoidCallback? onSuffixIconTap;
  final bool? isSearch;

  const CommonTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.onChanged,
      this.validator,
      this.focusNode,
      this.onEditingComplete,
      this.autofocus = false,
      this.enabled = true,
      this.fillColor = Colors.transparent,
      this.cursorColor = Colors.blue,
      this.onSuffixIconTap,
      this.isSearch = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: isSearch! ? Colors.white : null),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isSearch! ? Colors.white : AppColors.subHeadingFontColor),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.white,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: onSuffixIconTap,
              )
            : null,
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(4.0), // Adjust the radius as needed
        ),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      validator: validator,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      autofocus: autofocus,
      enabled: enabled,
      cursorColor: isSearch! ? Colors.white : AppColors.secondaryColor,
    );
  }
}
