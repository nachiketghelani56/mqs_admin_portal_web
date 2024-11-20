import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_list.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';

Widget wellAboveDriversWidget(
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
          StringConfig.reporting.wellAboveDrivers,
          style: FontTextStyleConfig.cardTitleTextStyle,
        ),
        SizeConfig.size20.height,
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: size,
                width: size,
                child: const CircularProgressIndicator(
                  value: 0.7,
                  strokeWidth: SizeConfig.size20,
                  color: ColorConfig.card3TextColor,
                  backgroundColor: ColorConfig.card3Color,
                ),
              ),
              SizedBox(
                height: size,
                width: size,
                child: const CircularProgressIndicator(
                  value: 0.3,
                  strokeWidth: SizeConfig.size20,
                  color: ColorConfig.card2TextColor,
                  backgroundColor: ColorConfig.card2Color,
                ),
              ),
              SizedBox(
                height: size,
                width: size,
                child: const CircularProgressIndicator(
                  value: 0.93,
                  strokeWidth: SizeConfig.size20,
                  color: ColorConfig.card1TextColor,
                  backgroundColor: ColorConfig.card2Color,
                ),
              ),
            ],
          ),
        ),
        SizeConfig.size20.height,
        ...reportingController.circleChartOpts
            .map((key, value) => MapEntry(
                  key,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: SizeConfig.size4,
                        width: SizeConfig.size14,
                        decoration: BoxDecoration(
                          color: value,
                          borderRadius:
                              BorderRadius.circular(SizeConfig.size11),
                        ),
                      ),
                      SizeConfig.size8.width,
                      Text(
                        key,
                        style: FontTextStyleConfig.dateTextStyle
                            .copyWith(color: ColorConfig.cardTitleColor),
                      )
                    ],
                  ),
                ))
            .values
            .toList()
            .separator(SizeConfig.size24.height),
      ],
    ),
  );
}
