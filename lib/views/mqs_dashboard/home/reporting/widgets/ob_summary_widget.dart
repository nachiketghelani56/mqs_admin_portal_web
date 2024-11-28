import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_list.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';

Widget obSummaryWidget(
    {required ReportingController reportingController,
    required BuildContext context}) {
  double size = context.width < SizeConfig.size600
      ? SizeConfig.size90
      : SizeConfig.size124;
  return Container(
    height: SizeConfig.size498,
    padding: const EdgeInsets.all(SizeConfig.size24),
    decoration: FontTextStyleConfig.cardDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConfig.reporting.onboardingSummary,
          style: FontTextStyleConfig.cardTitleTextStyle,
        ),
        SizeConfig.size20.height,
        Expanded(
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: size,
                  width: size,
                  child: CircularProgressIndicator(
                    value: reportingController.completedOB.value,
                    strokeWidth: SizeConfig.size20,
                    color: ColorConfig.card3TextColor,
                    backgroundColor: ColorConfig.card3Color,
                  ),
                ),
                SizedBox(
                  height: size,
                  width: size,
                  child: CircularProgressIndicator(
                    value: reportingController.partialCompletedOB.value,
                    strokeWidth: SizeConfig.size20,
                    color: ColorConfig.card2TextColor,
                    backgroundColor: ColorConfig.card2Color,
                  ),
                ),
                SizedBox(
                  height: size,
                  width: size,
                  child: CircularProgressIndicator(
                    value: reportingController.skippedOB.value,
                    strokeWidth: SizeConfig.size20,
                    color: ColorConfig.card1TextColor,
                    backgroundColor: ColorConfig.card1Color,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizeConfig.size20.height,
        ...reportingController.circleChartOpts
            .map(
              (key, value) => MapEntry(
                key,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: SizeConfig.size4,
                      width: SizeConfig.size14,
                      decoration: BoxDecoration(
                        color: value.entries.first.key,
                        borderRadius: BorderRadius.circular(SizeConfig.size11),
                      ),
                    ),
                    SizeConfig.size8.width,
                    Obx(
                      () => Text(
                        '$key (${value.entries.first.value.value} ${StringConfig.reporting.users})',
                        style: FontTextStyleConfig.dateTextStyle
                            .copyWith(color: ColorConfig.cardTitleColor),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .values
            .toList()
            .separator(SizeConfig.size24.height),
      ],
    ),
  );
}
