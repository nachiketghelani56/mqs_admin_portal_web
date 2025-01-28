import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.value,
    this.onChanged,
  });

  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: Checkbox(
        value: value,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConfig.size4)),
        side: BorderSide.none,
        splashRadius: 0,
        activeColor: ColorConfig.primaryColor,
        checkColor: ColorConfig.whiteColor,
        fillColor: !value
            ? WidgetStatePropertyAll(
            ColorConfig.checkBoxColor.withOpacity(SizeConfig.size0point6))
            : const WidgetStatePropertyAll(ColorConfig.primaryColor),
        onChanged: onChanged,
      ),
    );
  }
}
