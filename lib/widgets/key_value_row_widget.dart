import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget keyValueRowWidget(
    {required String key,
    required String value,
    bool topBorder = false,
    bool bottomBorder = true}) {
  return Container(
    decoration: topBorder
        ? FontTextStyleConfig.detailDecoration
        : bottomBorder
            ? FontTextStyleConfig.detailBottomDecoration
            : null,
    child: IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: SizeConfig.size12),
              child: Text(
                key,
                style: FontTextStyleConfig.tableTextStyle,
              ),
            ),
          ),
          Container(
            width: SizeConfig.size1,
            color: ColorConfig.textFieldTextColor.withOpacity(.14),
          ),
          Expanded(
            flex: SizeConfig.size2.toInt(),
            child: Container(
              padding: const EdgeInsets.only(
                top: SizeConfig.size12,
                bottom: SizeConfig.size12,
                left: SizeConfig.size20,
              ),
              child: Text(
                value,
                style: FontTextStyleConfig.tableTextStyle,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
