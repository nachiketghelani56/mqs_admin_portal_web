import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_list.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/custom_range_dialog.dart';

Widget obSummaryWidget(
    {required ReportingController reportingController,
    required BuildContext context}) {
  double size = context.width < SizeConfig.size600
      ? SizeConfig.size90
      : SizeConfig.size124;
  return Container(
    height: context.width < SizeConfig.size1100
        ? SizeConfig.size498
        : SizeConfig.size343,
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
                  '${StringConfig.reporting.onboardingSummary} ${reportingController.obFilter.value.isNotEmpty ? "(${reportingController.obFilter.value})" : ""}',
                  style: FontTextStyleConfig.cardTitleTextStyle,
                ),
              ),
              PopupMenuButton(
                icon: Container(
                  height: SizeConfig.size46,
                  decoration: FontTextStyleConfig.topOptionDecoration.copyWith(
                    borderRadius: BorderRadius.circular(SizeConfig.size12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size15),
                  child: Image.asset(
                    ImageConfig.filterNew,
                    width: SizeConfig.size22,
                  ),
                ),
                onSelected: (value) {
                  if (value == StringConfig.reporting.customRange) {
                    reportingController.startDateController.clear();
                    reportingController.endDateController.clear();
                    customRangeDialog(
                      context: context,
                      reportingController: reportingController,
                      type: StringConfig.reporting.onboardingSummary,
                    );
                  } else {
                    reportingController.obFilter.value = value;
                    reportingController.filterAuth();
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
              if (reportingController.obFilter.isNotEmpty)
                IconButton(
                  onPressed: () {
                    final DashboardController dashboardController = Get.find();
                    reportingController.obFilter.value = '';
                    reportingController.getOBSummary(
                        users: dashboardController.users);
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: ColorConfig.primaryColor,
                  ),
                ),
            ],
          ),
        ),
        SizeConfig.size20.height,
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: SizeConfig.size2.toInt(),
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
              if (context.width > SizeConfig.size1100) ...[
                SizeConfig.size20.height,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                      borderRadius: BorderRadius.circular(
                                          SizeConfig.size11),
                                    ),
                                  ),
                                  SizeConfig.size8.width,
                                  Flexible(
                                    child: Obx(
                                      () => Text(
                                        '$key (${value.entries.first.value.value} ${StringConfig.reporting.users})',
                                        style: FontTextStyleConfig.dateTextStyle
                                            .copyWith(
                                                color:
                                                    ColorConfig.cardTitleColor),
                                      ),
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
                ),
              ],
            ],
          ),
        ),
        if (context.width < SizeConfig.size1100)
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
                          borderRadius:
                              BorderRadius.circular(SizeConfig.size11),
                        ),
                      ),
                      SizeConfig.size8.width,
                      Flexible(
                        child: Obx(
                          () => Text(
                            '$key (${value.entries.first.value.value} ${StringConfig.reporting.users})',
                            style: FontTextStyleConfig.dateTextStyle
                                .copyWith(color: ColorConfig.cardTitleColor),
                          ),
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
