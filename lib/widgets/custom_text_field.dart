import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isObscure = false,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.validator,
    this.hintText,
    this.readOnly = false,
    this.onTap,
    this.inputFormatters,
    this.autofillHints,
  });

  final TextEditingController controller;
  final String label;
  final bool isObscure;
  final String? suffixIcon;
  final Function? onSuffixIconTap;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool readOnly;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FontTextStyleConfig.labelTextStyle,
        ).paddingOnly(left: SizeConfig.size2),
        SizeConfig.size6.height,
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          obscureText: isObscure,
          obscuringCharacter: '•',
          style: FontTextStyleConfig.textFieldTextStyle
              .copyWith(fontSize: FontSizeConfig.fontSize16),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: inputFormatters,
          autofillHints: autofillHints,
          decoration: InputDecoration(
            hintText: hintText,
            isDense: true,
            filled: true,
            fillColor: ColorConfig.backgroundColor,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: FontTextStyleConfig.labelTextStyle,
            border: FontTextStyleConfig.borderDecoration,
            focusedBorder: FontTextStyleConfig.borderDecoration,
            enabledBorder: FontTextStyleConfig.borderDecoration,
            focusedErrorBorder: FontTextStyleConfig.borderDecoration,
            errorBorder: FontTextStyleConfig.borderDecoration,
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
        ),
      ],
    );
  }
}
