import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';

Widget circleSummaryWidget(
    {required BuildContext context,
    required ReportingController reportingController}) {
  return Container(
    padding: const EdgeInsets.all(SizeConfig.size24),
    decoration: FontTextStyleConfig.cardDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                StringConfig.reporting.circleSummary,
                style: FontTextStyleConfig.cardTitleTextStyle,
              ),
            ),
            SizedBox(
              width: SizeConfig.size124,
              child: CustomButton(
                isSelected: false,
                btnText: StringConfig.dashboard.export,
                onTap: () {
                  reportingController.exportCircleSummary();
                },
              ),
            ),
          ],
        ),
        SizeConfig.size24.height,
        Row(
          children: [
            Expanded(
              child: Container(
                height: SizeConfig.size202,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.size12),
                  color: ColorConfig.card1Color,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        '${reportingController.totalCircles.value}',
                        style: FontTextStyleConfig.cardMainTextStyle,
                      ),
                    ),
                    SizeConfig.size12.height,
                    Text(
                      StringConfig.reporting.totalCircles,
                      textAlign: TextAlign.center,
                      style: FontTextStyleConfig.cardSubTextStyle.copyWith(
                          fontSize: context.width < SizeConfig.size600
                              ? FontSizeConfig.fontSize18
                              : null),
                    ),
                  ],
                ),
              ),
            ),
            SizeConfig.size34.width,
            Expanded(
              child: Container(
                height: SizeConfig.size202,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.size12),
                  color: ColorConfig.card2Color,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        '${reportingController.featuredCircles.value}',
                        style: FontTextStyleConfig.cardMainTextStyle
                            .copyWith(color: ColorConfig.card2TextColor),
                      ),
                    ),
                    SizeConfig.size12.height,
                    Text(
                      StringConfig.reporting.featuredCircles,
                      textAlign: TextAlign.center,
                      style: FontTextStyleConfig.cardSubTextStyle.copyWith(
                          fontSize: context.width < SizeConfig.size600
                              ? FontSizeConfig.fontSize18
                              : null),
                    ),
                  ],
                ),
              ),
            ),
            SizeConfig.size34.width,
            Expanded(
              child: Container(
                height: SizeConfig.size202,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.size12),
                  color: ColorConfig.card3Color,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        '${reportingController.flaggedCircles.value}',
                        style: FontTextStyleConfig.cardMainTextStyle
                            .copyWith(color: ColorConfig.card3TextColor),
                      ),
                    ),
                    SizeConfig.size12.height,
                    Text(
                      StringConfig.reporting.flaggedCircles,
                      textAlign: TextAlign.center,
                      style: FontTextStyleConfig.cardSubTextStyle.copyWith(
                          fontSize: context.width < SizeConfig.size600
                              ? FontSizeConfig.fontSize18
                              : null),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
