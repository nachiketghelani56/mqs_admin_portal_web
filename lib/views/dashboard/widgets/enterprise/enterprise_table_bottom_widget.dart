import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';

Widget enterpriseTableBottomWidget() {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextstyleConfig.tableBottomDecoration,
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Text(
          '${StringConfig.dashboard.rowsPerPage} 10',
          style: FontTextstyleConfig.tableBottomTextStyle,
        ),
        SizeConfig.size5.width,
        const Icon(Icons.arrow_drop_down),
        const Spacer(),
        Text(
          '1-10 ${StringConfig.dashboard.of} 276',
          style: FontTextstyleConfig.tableBottomTextStyle,
        ),
        SizeConfig.size20.width,
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios,
            size: SizeConfig.size15,
            color: ColorConfig.textfieldTextColor,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: SizeConfig.size15,
            color: ColorConfig.textfieldTextColor,
          ),
        ),
        SizeConfig.size20.width,
      ],
    ),
  );
}
