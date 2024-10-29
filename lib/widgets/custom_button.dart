import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.btnText, required this.onTap});

  final String btnText;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.size46,
      decoration: const BoxDecoration(
        color: ColorConfig.primaryColor,
      ),
      alignment: Alignment.center,
      child: Text(
        btnText,
        style: FontTextstyleConfig.buttonTextStyle,
      ),
    ).tap(onTap);
  }
}
