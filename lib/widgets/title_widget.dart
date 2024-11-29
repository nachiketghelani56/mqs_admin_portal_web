import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget titleWidget(
    {required String title,
    bool showArrowIcon = true,
    bool isShowContent = true,
    bool showAddIcon = false}) {
  return Container(
    height: SizeConfig.size56,
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size16),
    decoration: BoxDecoration(
      color:
          ColorConfig.textFieldTextColor.withOpacity(SizeConfig.size0point06),
      borderRadius: BorderRadius.circular(SizeConfig.size12),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: FontTextStyleConfig.titleTextStyle,
          ),
        ),
        if (showAddIcon)
          const Icon(
            Icons.add,
            color: ColorConfig.primaryColor,
          )
        else if (showArrowIcon)
          Icon(
            isShowContent ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
            color: ColorConfig.primaryColor,
          ),
      ],
    ),
  );
}
