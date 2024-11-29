import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';

class CustomPrefixButton extends StatelessWidget {
  const CustomPrefixButton(
      {super.key,
      required this.btnText,
      required this.onTap,
      required this.prefixIcon, this.padding});

  final String btnText, prefixIcon;
  final Function onTap;
  final double? padding;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.size46,
      decoration: BoxDecoration(
        border: Border.all(color: ColorConfig.primaryColor),
        borderRadius: BorderRadius.circular(SizeConfig.size2),
      ),
      padding:  EdgeInsets.symmetric(horizontal: padding ??SizeConfig.size34),
      child: Row(
        children: [
          Image.asset(
            prefixIcon,
            width: SizeConfig.size22,
          ),
          10.width,
          Text(
            btnText,
            style: FontTextStyleConfig.tabTextStyle,
          ),
        ],
      ),
    ).tap(onTap);
  }
}
