import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';

class CommonIconButton extends StatelessWidget {
  const CommonIconButton(
      {super.key,
        required this.icon,
        required this.onTap,
        required this.color});

  final String icon;
  final void Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.size10),
          color: color.withOpacity(SizeConfig.size0point1)),
      child: Image.asset(
        icon,
        height: SizeConfig.size24,
        width: SizeConfig.size24,
      ).paddingAll(SizeConfig.size8).tap(onTap),
    );
  }
}