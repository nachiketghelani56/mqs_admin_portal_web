import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_list.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';

Widget teamMyQEngagementWidget() {
  return Container(
    decoration: FontTextStyleConfig.cardDecoration,
    padding: const EdgeInsets.symmetric(
        horizontal: SizeConfig.size28, vertical: SizeConfig.size33),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConfig.teamChart.teamMyQEngagement,
          style: FontTextStyleConfig.chartTitleTextStyle,
        ),
        SizeConfig.size18.height,
        Text(
          StringConfig.teamChart.teamMyQEngagementDesc,
          style: FontTextStyleConfig.chartDescTextStyle,
        ),
        SizeConfig.size10.height,
        Container(
          height: SizeConfig.size1,
          color: ColorConfig.dividerColor,
        ),
        SizeConfig.size35.height,
        const SizedBox(
          height: SizeConfig.size150,
          width: SizeConfig.size150,
          child: CircularProgressIndicator(
            value: SizeConfig.size0point93,
            strokeWidth: SizeConfig.size22,
            color: ColorConfig.primaryColor,
            backgroundColor: ColorConfig.card1Color,
          ),
        ).center,
        SizeConfig.size20.height,
        Text(
          StringConfig.teamChart.dailyLogIn,
          style: FontTextStyleConfig.chartDescTextStyle,
        ).center,
        SizeConfig.size40.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Container(
                height: SizeConfig.size13point5,
                width: SizeConfig.size13point5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConfig.primaryColor.withOpacity(
                      i == 0 ? SizeConfig.size1 : SizeConfig.size0point5),
                ),
              ),
          ].separator(SizeConfig.size30.width).toList(),
        ),
      ],
    ),
  );
}
