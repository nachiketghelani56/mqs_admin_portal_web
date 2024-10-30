import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';

Widget enterpriseTableRowWidget() {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextstyleConfig.tableRowDecoration,
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Expanded(
          flex: SizeConfig.size4.toInt(),
          child: const Text(
            "Ukscyu564HDG646733989GYGbgg",
            overflow: TextOverflow.ellipsis,
            style: FontTextstyleConfig.tableTextStyle,
          ),
        ),
        Expanded(
          flex: SizeConfig.size4.toInt(),
          child: const Text(
            "1234",
            overflow: TextOverflow.ellipsis,
            style: FontTextstyleConfig.tableTextStyle,
          ),
        ),
        Expanded(
          flex: SizeConfig.size2.toInt(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConfig.eyeOpened,
                height: SizeConfig.size24,
              ).tap(() {}),
              SizeConfig.size32.width,
              Image.asset(
                ImageConfig.edit,
                height: SizeConfig.size24,
              ).tap(() {}),
              SizeConfig.size32.width,
              Image.asset(
                ImageConfig.delete,
                height: SizeConfig.size24,
              ).tap(() {}),
            ],
          ),
        ),
      ],
    ),
  );
}
