import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/custom_range_dialog.dart';

Widget authSummaryWidget(
    {required BuildContext context,
    required ReportingController reportingController}) {
  return Container(
    height: SizeConfig.size343,
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
                  '${StringConfig.reporting.authSummary} ${reportingController.authFilter.value.isNotEmpty ? "(${reportingController.authFilter.value})" : ""}',
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
                      type: StringConfig.reporting.authSummary,
                    );
                  } else {
                    reportingController.authFilter.value = value;
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
              if (reportingController.authFilter.isNotEmpty)
                IconButton(
                  onPressed: () {
                    reportingController.authFilter.value = '';
                    reportingController.getAuthAndOBSummary();
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
                padding: const EdgeInsets.all(SizeConfig.size10),
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
                        '${reportingController.totalRegisteredUsers.value}',
                        style: FontTextStyleConfig.cardMainTextStyle,
                      ),
                    ),
                    SizeConfig.size12.height,
                    Text(
                      StringConfig.reporting.totalRegisteredUsers,
                      textAlign: TextAlign.center,
                      style: FontTextStyleConfig.cardSubTextStyle.copyWith(),
                    ),
                  ],
                ),
              ).tap(() {
                reportingController.filterAuth(
                    type: StringConfig.reporting.totalRegisteredUsers);
                Get.toNamed(AppRoutes.authSummary);
              }),
            ),
            SizeConfig.size20.width,
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(SizeConfig.size10),
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
                        '${reportingController.activeUsers.value}',
                        style: FontTextStyleConfig.cardMainTextStyle
                            .copyWith(color: ColorConfig.card2TextColor),
                      ),
                    ),
                    SizeConfig.size12.height,
                    Text(
                      StringConfig.reporting.activeUsers,
                      textAlign: TextAlign.center,
                      style: FontTextStyleConfig.cardSubTextStyle.copyWith(),
                    ),
                  ],
                ),
              ).tap(() {
                reportingController.filterAuth(
                    type: StringConfig.reporting.activeUsers);
                Get.toNamed(AppRoutes.authSummary);
              }),
            ),
            SizeConfig.size20.width,
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(SizeConfig.size10),
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
                        '${reportingController.inactiveUsers.value}',
                        style: FontTextStyleConfig.cardMainTextStyle
                            .copyWith(color: ColorConfig.card3TextColor),
                      ),
                    ),
                    SizeConfig.size12.height,
                    Text(
                      StringConfig.reporting.inactiveUsers,
                      textAlign: TextAlign.center,
                      style: FontTextStyleConfig.cardSubTextStyle.copyWith(),
                    ),
                  ],
                ),
              ).tap(() {
                reportingController.filterAuth(
                    type: StringConfig.reporting.inactiveUsers);
                Get.toNamed(AppRoutes.authSummary);
              }),
            ),
          ],
        ),
      ],
    ),
  );
}
