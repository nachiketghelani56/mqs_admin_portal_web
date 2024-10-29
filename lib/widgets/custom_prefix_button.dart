import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';

class CustomPrefixButton extends StatelessWidget {
  const CustomPrefixButton(
      {super.key,
      required this.btnText,
      required this.onTap,
      required this.prefixIcon});

  final String btnText, prefixIcon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorConfig.primaryColor),
        borderRadius: BorderRadius.circular(SizeConfig.size2),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: SizeConfig.size34, vertical: SizeConfig.size10),
      child: Row(
        children: [
          Image.asset(
            prefixIcon,
            width: SizeConfig.size22,
          ),
          10.width,
          Text(
            btnText,
            style: FontTextstyleConfig.tabTextStyle,
          ),
        ],
      ),
    ).tap(onTap);
  }
}
