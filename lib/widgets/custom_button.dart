import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.btnText,
      required this.onTap,
      this.isSelected = true});

  final String btnText;
  final Function onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.size46,
      decoration: BoxDecoration(
        color: isSelected ? ColorConfig.primaryColor : null,
        border: Border.all(color: ColorConfig.primaryColor),
      ),
      alignment: Alignment.center,
      child: Text(
        btnText,
        style: FontTextstyleConfig.buttonTextStyle
            .copyWith(color: isSelected ? null : ColorConfig.primaryColor),
      ),
    ).tap(onTap);
  }
}
