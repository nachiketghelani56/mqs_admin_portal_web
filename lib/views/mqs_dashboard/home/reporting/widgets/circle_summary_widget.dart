import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/custom_range_dialog.dart';
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
        Obx(
          () => Row(
            children: [
              Expanded(
                child: Text(
                  '${StringConfig.reporting.circleSummary} ${reportingController.circleFilter.value.isNotEmpty ? "(${reportingController.circleFilter.value})" : ""}',
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
              PopupMenuButton(
                icon: Container(
                  height: SizeConfig.size50,
                  width: SizeConfig.size55,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConfig.primaryColor),
                    borderRadius: BorderRadius.circular(SizeConfig.size14),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImageConfig.filterNew,
                    height: SizeConfig.size28,
                    width: SizeConfig.size28,
                  ),
                ),
                onSelected: (value) {
                  if (value == StringConfig.reporting.customRange) {
                    reportingController.startDateController.clear();
                    reportingController.endDateController.clear();
                    customRangeDialog(
                      context: context,
                      reportingController: reportingController,
                      type: StringConfig.reporting.circleSummary,
                    );
                  } else {
                    reportingController.circleFilter.value = value;
                    reportingController.filterCircle();
                  }
                },
                itemBuilder: (context) {
                  return [
                    for (int i = 0;
                        i < reportingController.filterOpts.length;
                        i++)
                      PopupMenuItem(
                        value: reportingController.filterOpts[i],
                        child: Text(
                          reportingController.filterOpts[i],
                          style: FontTextStyleConfig.fieldTextStyle,
                        ),
                      ),
                  ];
                },
              ),
              if (reportingController.circleFilter.isNotEmpty)
                IconButton(
                  onPressed: () {
                    reportingController.circleFilter.value = '';
                    reportingController.getCircleSummary();
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: ColorConfig.primaryColor,
                  ),
                ),
            ],
          ),
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
