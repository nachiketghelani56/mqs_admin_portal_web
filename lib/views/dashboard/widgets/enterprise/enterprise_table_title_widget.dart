import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget enterpriseTableTitleWidget() {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextstyleConfig.tableTitleDecoration,
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Expanded(
          flex: SizeConfig.size4.toInt(),
          child: Text(
            StringConfig.dashboard.id,
            style: FontTextstyleConfig.textfieldTextStyle,
          ),
        ),
        Expanded(
          flex: SizeConfig.size4.toInt(),
          child: Text(
            StringConfig.dashboard.mqsEnterPriseCode,
            style: FontTextstyleConfig.textfieldTextStyle,
          ),
        ),
        Expanded(
          flex: SizeConfig.size2.toInt(),
          child: const SizedBox(),
        ),
      ],
    ),
  );
}
