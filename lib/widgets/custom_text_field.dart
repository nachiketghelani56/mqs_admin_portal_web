import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/config/font_textstyle_config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.isObscure = false,
      this.suffixIcon,
      this.onSuffixIconTap,
      this.validator});

  final TextEditingController controller;
  final String label;
  final bool isObscure;
  final String? suffixIcon;
  final Function? onSuffixIconTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      obscuringCharacter: '•',
      style: FontTextstyleConfig.textfieldTextStyle,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: FontTextstyleConfig.labelTextStyle,
        border: FontTextstyleConfig.borderDecoration,
        focusedBorder: FontTextstyleConfig.borderDecoration,
        enabledBorder: FontTextstyleConfig.borderDecoration,
        focusedErrorBorder: FontTextstyleConfig.borderDecoration,
        errorBorder: FontTextstyleConfig.borderDecoration,
        suffixIcon: suffixIcon != null
            ? Container(
                height: SizeConfig.size25,
                width: SizeConfig.size25,
                alignment: Alignment.center,
                child: Image.asset(
                  suffixIcon!,
                  height: SizeConfig.size25,
                  width: SizeConfig.size25,
                ),
              ).tap(() {
                if (onSuffixIconTap != null) {
                  onSuffixIconTap!();
                }
              }).paddingOnly(right: SizeConfig.size20)
            : null,
        contentPadding: const EdgeInsets.symmetric(
            vertical: SizeConfig.size20, horizontal: SizeConfig.size20),
      ),
    );
  }
}
