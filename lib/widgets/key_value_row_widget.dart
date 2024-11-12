import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

Widget keyValueRowWidget(
    {required String key,
    required String value,
    bool topBorder = false,
    bool bottomBorder = true}) {
  return Container(
    decoration: topBorder
        ? FontTextstyleConfig.detailDecoration
        : bottomBorder
            ? FontTextstyleConfig.detailBottomDecoration
            : null,
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: SizeConfig.size12),
            child: Text(
              key,
              style: FontTextstyleConfig.tableTextStyle,
            ),
          ),
        ),
        Expanded(
          flex: SizeConfig.size2.toInt(),
          child: Container(
            padding: const EdgeInsets.only(
              top: SizeConfig.size12,
              bottom: SizeConfig.size12,
              left: SizeConfig.size20,
            ),
            decoration: FontTextstyleConfig.detailLeftDecoration,
            child: Text(
              value,
              style: FontTextstyleConfig.tableTextStyle,
            ),
          ),
        ),
      ],
    ),
  );
}
