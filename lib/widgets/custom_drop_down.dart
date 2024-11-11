import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.label,
    this.value,
  });

  final List<DropdownMenuItem<dynamic>>? items;
  final Function(dynamic) onChanged;
  final String label;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items,
      value: value,
      onChanged: (value) {
        onChanged(value);
      },
      style: FontTextstyleConfig.textfieldTextStyle,
      icon: const Icon(Icons.keyboard_arrow_down),
      focusColor: ColorConfig.whiteColor,
      dropdownColor: ColorConfig.whiteColor,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: ColorConfig.whiteColor,
        focusColor: ColorConfig.whiteColor,
        hoverColor: ColorConfig.whiteColor,
        labelStyle: FontTextstyleConfig.labelTextStyle,
        border: FontTextstyleConfig.borderDecoration,
        focusedBorder: FontTextstyleConfig.borderDecoration,
        enabledBorder: FontTextstyleConfig.borderDecoration,
        focusedErrorBorder: FontTextstyleConfig.borderDecoration,
        errorBorder: FontTextstyleConfig.borderDecoration,
        contentPadding: const EdgeInsets.symmetric(
            vertical: SizeConfig.size22, horizontal: SizeConfig.size20),
      ),
    );
  }
}
