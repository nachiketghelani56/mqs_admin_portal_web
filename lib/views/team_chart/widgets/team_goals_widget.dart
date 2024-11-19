import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';

Widget teamGoalsWidget() {
  return Container(
    decoration: FontTextStyleConfig.cardDecoration,
    padding: const EdgeInsets.symmetric(
        horizontal: SizeConfig.size28, vertical: SizeConfig.size33),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConfig.teamChart.teamGoals,
          style: FontTextStyleConfig.chartTitleTextStyle,
        ),
        SizeConfig.size18.height,
        Text(
          StringConfig.teamChart.teamGoalsDesc,
          style: FontTextStyleConfig.chartDescTextStyle,
        ),
        SizeConfig.size10.height,
        Container(
          height: 1,
          color: ColorConfig.dividerColor,
        ),
        SizeConfig.size10.height,
        Row(
          children: [
            Expanded(
              child: Text(
                StringConfig.teamChart.ofPathways,
                style: FontTextStyleConfig.chartDescTextStyle,
              ),
            ),
            Container(
              height: SizeConfig.size35,
              width: SizeConfig.size35,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: ColorConfig.highlightColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                '7',
                style: FontTextStyleConfig.chartDescTextStyle
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizeConfig.size6.height,
        Row(
          children: [
            Expanded(
              child: Text(
                StringConfig.teamChart.ofMomentsThatMatter,
                style: FontTextStyleConfig.chartDescTextStyle,
              ),
            ),
            Container(
              height: SizeConfig.size35,
              width: SizeConfig.size35,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: ColorConfig.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                '15',
                style: FontTextStyleConfig.chartDescTextStyle.copyWith(
                    fontWeight: FontWeight.w500, color: ColorConfig.whiteColor),
              ),
            ),
          ],
        ),
        SizeConfig.size25.height,
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: SizeConfig.size15, vertical: SizeConfig.size8),
          decoration: BoxDecoration(
            color: ColorConfig.primaryColor,
            borderRadius: BorderRadius.circular(SizeConfig.size24),
          ),
          child: Text(
            StringConfig.teamChart.showMore,
            style: FontTextStyleConfig.subMenuTextStyle.copyWith(
              color: ColorConfig.whiteColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
