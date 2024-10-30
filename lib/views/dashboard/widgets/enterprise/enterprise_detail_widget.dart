import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_detail_row_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget enterpriseDetailWidget() {
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size26),
      decoration: FontTextstyleConfig.detailMainDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ukscyu564HDG646733989GYGbgg",
            style: FontTextstyleConfig.textfieldTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizeConfig.size24.height,
          enterpriseDetailRowWidget(),
          SizeConfig.size34.height,
          titleWidget(title: "mqsEmployeeEmailList"),
          SizeConfig.size10.height,
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: BoxDecoration(
              color: ColorConfig.bg2Color.withOpacity(SizeConfig.size0point3),
              border: Border.all(
                color:
                    ColorConfig.labelColor.withOpacity(SizeConfig.size0point2),
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(SizeConfig.size12),
              ),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    'email',
                    style: FontTextstyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    'mqsCommonLogin',
                    style: FontTextstyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    'firstName',
                    style: FontTextstyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    'isSignedUp',
                    style: FontTextstyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    'lastName',
                    style: FontTextstyleConfig.tableBottomTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
