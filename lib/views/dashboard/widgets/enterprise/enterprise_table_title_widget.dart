import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget enterpriseTableTitleWidget({required BuildContext context,}) {
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
          flex: SizeConfig.size4.toInt(),
          child: Padding(
            padding: const EdgeInsets.only(right: SizeConfig.size4),
            child: Text(
              StringConfig.dashboard.mqsEnterPriseCode,
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
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size4),
            child: Text(
              StringConfig.dashboard.subscriptionStatus,
              style: FontTextStyleConfig.textFieldTextStyle.copyWith(
                fontSize: FontSizeConfig.fontSize15,
                fontWeight: FontWeight.w700,
              ),
            ),
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
