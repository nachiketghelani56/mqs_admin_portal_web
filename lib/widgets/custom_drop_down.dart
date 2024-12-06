import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.label,
    this.value,
    this.validator,
  });

  final List<DropdownMenuItem<dynamic>>? items;
  final Function(dynamic) onChanged;
  final String label;
  final dynamic value;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: FontTextStyleConfig.labelTextStyle,
          ).paddingOnly(left: SizeConfig.size2),
          SizeConfig.size6.height,
        ],
        DropdownButtonFormField(
          items: items,
          value: value,
          onChanged: (value) {
            onChanged(value);
          },
          style: FontTextStyleConfig.textFieldTextStyle
              .copyWith(fontSize: FontSizeConfig.fontSize16),
          validator: validator,
          icon: const Icon(Icons.keyboard_arrow_down),
          focusColor: ColorConfig.backgroundColor,
          dropdownColor: ColorConfig.backgroundColor,
          decoration: InputDecoration(
            isDense: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            fillColor: ColorConfig.backgroundColor,
            focusColor: ColorConfig.backgroundColor,
            hoverColor: ColorConfig.backgroundColor,
            labelStyle: FontTextStyleConfig.labelTextStyle,
            border: FontTextStyleConfig.borderDecoration,
            focusedBorder: FontTextStyleConfig.borderDecoration,
            enabledBorder: FontTextStyleConfig.borderDecoration,
            focusedErrorBorder: FontTextStyleConfig.borderDecoration,
            errorBorder: FontTextStyleConfig.borderDecoration,
            contentPadding: const EdgeInsets.symmetric(
                vertical: SizeConfig.size22, horizontal: SizeConfig.size20),
          ),
        ),
      ],
    );
  }
}
