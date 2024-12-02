import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.icon, required this.onTap});

  final String icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.size46,
      decoration: FontTextStyleConfig.topOptionDecoration.copyWith(
        borderRadius: BorderRadius.circular(SizeConfig.size12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size15),
      child: Image.asset(
        icon,
        width: SizeConfig.size22,
      ),
    ).tap(() {
      onTap();
    });
  }
}
