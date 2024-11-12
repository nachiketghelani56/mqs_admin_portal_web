import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget userTableTitleWidget() {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextstyleConfig.tableTitleDecoration,
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Expanded(
          flex: SizeConfig.size3.toInt(),
          child: Text(
            StringConfig.dashboard.userId,
            style: FontTextstyleConfig.textfieldTextStyle,
          ),
        ),
        Expanded(
          child: Text(
            StringConfig.dashboard.userName,
            style: FontTextstyleConfig.textfieldTextStyle,
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    ),
  );
}
