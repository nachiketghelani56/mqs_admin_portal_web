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
      style: FontTextStyleConfig.textFieldTextStyle,
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
        labelStyle: FontTextStyleConfig.labelTextStyle,
        border: FontTextStyleConfig.borderDecoration,
        focusedBorder: FontTextStyleConfig.borderDecoration,
        enabledBorder: FontTextStyleConfig.borderDecoration,
        focusedErrorBorder: FontTextStyleConfig.borderDecoration,
        errorBorder: FontTextStyleConfig.borderDecoration,
        contentPadding: const EdgeInsets.symmetric(
            vertical: SizeConfig.size22, horizontal: SizeConfig.size20),
      ),
    );
  }
}
