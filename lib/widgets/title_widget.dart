import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget titleWidget({required String title}) {
  return Container(
    height: SizeConfig.size56,
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size16),
    decoration: BoxDecoration(
      color:
          ColorConfig.textfieldTextColor.withOpacity(SizeConfig.size0point06),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: FontTextstyleConfig.titleTextStyle,
          ),
        ),
        const Icon(
          Icons.keyboard_arrow_up,
          color: ColorConfig.primaryColor,
        ),
      ],
    ),
  );
}
