import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_context.dart';

Widget enterpriseTableTitleWidget({required BuildContext context}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextStyleConfig.tableTitleDecoration,
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Expanded(
          flex: SizeConfig.size2.toInt(),
          child: Text(
            StringConfig.dashboard.mqsEnterPriseName,
            style: FontTextStyleConfig.textFieldTextStyle,
          ),
        ),
        if (context.width > SizeConfig.size900)
          Expanded(
            flex: SizeConfig.size2.toInt(),
            child: Text(
              StringConfig.dashboard.enterpriseEmail,
              style: FontTextStyleConfig.textFieldTextStyle,
            ),
          ),
        Expanded(
          flex: SizeConfig.size2.toInt(),
          child: Text(
            StringConfig.dashboard.mqsEnterPriseCode,
            style: FontTextStyleConfig.textFieldTextStyle,
          ),
        ),
        Expanded(
          flex: SizeConfig.size2.toInt(),
          child: Text(
            StringConfig.dashboard.subscriptionStatus,
            style: FontTextStyleConfig.textFieldTextStyle,
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
