import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget userTableTitleWidget({required BuildContext context}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextStyleConfig.tableTitleDecoration,
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        if (context.width > SizeConfig.size900)
          Expanded(
            flex: SizeConfig.size3.toInt(),
            child: Text(
              StringConfig.dashboard.userId,
              style: FontTextStyleConfig.textFieldTextStyle,
            ),
          ),
        Expanded(
          child: Text(
            StringConfig.dashboard.userName,
            style: FontTextStyleConfig.textFieldTextStyle,
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    ),
  );
}
