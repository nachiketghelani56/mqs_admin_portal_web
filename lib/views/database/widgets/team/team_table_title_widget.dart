import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget teamTableTitleWidget({required BuildContext context}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextStyleConfig.tableTitleDecoration.copyWith(
      border: Border(
        top: BorderSide.none,
        bottom: BorderSide(
            color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point4)),
        left: BorderSide.none,
        right: BorderSide.none,
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Expanded(
          flex: SizeConfig.size3.toInt(),
          child: Padding(
            padding: const EdgeInsets.only(right: SizeConfig.size15),
            child: Text(
              StringConfig.dashboard.teamName,
              style: FontTextStyleConfig.textFieldTextStyle.copyWith(
                fontSize: FontSizeConfig.fontSize15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Expanded(
          flex: SizeConfig.size3.toInt(),
          child: Padding(
            padding: const EdgeInsets.only(right: SizeConfig.size15),
            child: Text(
              StringConfig.dashboard.teamEmailAddress,
              style: FontTextStyleConfig.textFieldTextStyle.copyWith(
                fontSize: FontSizeConfig.fontSize15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),

        const Expanded(child: SizedBox()),
      ],
    ),
  );
}
