import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/ob_options_widget.dart';

Widget obSummaryWidget(
    {required ReportingController reportingController,
    required BuildContext context,
    required DashboardController dashboardController}) {
  double size = context.width > SizeConfig.size1500
      ? SizeConfig.size202
      : context.width > SizeConfig.size700
          ? SizeConfig.size150
          : SizeConfig.size100;
  double stroke = context.width > SizeConfig.size1500
      ? SizeConfig.size30
      : context.width > SizeConfig.size700
          ? SizeConfig.size20
          : SizeConfig.size15;
  return Container(
    height: context.width < SizeConfig.size1100
        ? SizeConfig.size498
        : SizeConfig.size380,
    padding: const EdgeInsets.all(SizeConfig.size24),
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
              // PopupMenuButton(
              //   icon: Container(
              //     height: SizeConfig.size46,
              //     decoration: FontTextStyleConfig.topOptionDecoration.copyWith(
              //       borderRadius: BorderRadius.circular(SizeConfig.size12),
              //     ),
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: SizeConfig.size15),
              //     child: Image.asset(
              //       ImageConfig.filterNew,
              //       width: SizeConfig.size22,
              //     ),
              //   ),
              //   onSelected: (value) {
              //     if (value == StringConfig.reporting.customRange) {
              //       reportingController.startDateController.clear();
              //       reportingController.endDateController.clear();
              //       customRangeDialog(
              //         context: context,
              //         reportingController: reportingController,
              //         type: StringConfig.reporting.onboardingSummary,
              //       );
              //     } else {
              //       reportingController.obFilter.value = value;
              //       reportingController.filterOnboarding(filterType: value);
              //     }
              //   },
              //   itemBuilder: (context) {
              //     return [
              //       for (int i = 0;
              //           i < reportingController.filterOpts.length;
              //           i++)
              //         PopupMenuItem(
              //           value: reportingController.filterOpts[i],
              //           child: Text(
              //             reportingController.filterOpts[i],
              //             style: FontTextStyleConfig.fieldTextStyle,
              //           ),
              //         ),
              //     ];
              //   },
              // ),
              // if (reportingController.obFilter.isNotEmpty)
              //   IconButton(
              //     onPressed: () async {
              //       reportingController.startDateController.clear();
              //       reportingController.endDateController.clear();
              //       reportingController.obFilter.value = '';
              //       reportingController.getOBSummary(
              //           users: await UserRepository.i.getUsers());
              //     },
              //     icon: const Icon(
              //       Icons.refresh,
              //       color: ColorConfig.primaryColor,
              //     ),
              //   ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: size,
                        width: size,
                        child: CircularProgressIndicator(
                          value: reportingController.completedOB.value.isNaN
                              ? SizeConfig.size0
                              : reportingController.completedOB.value,
                          strokeWidth: stroke,
                          color: ColorConfig.card3TextColor,
                          backgroundColor: ColorConfig.card3Color,
                        ),
                      ),
                      SizedBox(
                        height: size,
                        width: size,
                        child: CircularProgressIndicator(
                          value: reportingController
                                  .partialCompletedOB.value.isNaN
                              ? SizeConfig.size0
                              : reportingController.partialCompletedOB.value,
                          strokeWidth: stroke,
                          color: ColorConfig.card2TextColor,
                          backgroundColor: ColorConfig.card2Color,
                        ),
                      ),
                      SizedBox(
                        height: size,
                        width: size,
                        child: CircularProgressIndicator(
                          value: reportingController.skippedOB.value.isNaN
                              ? SizeConfig.size0
                              : reportingController.skippedOB.value,
                          strokeWidth: stroke,
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
                      ...obOptionsWidget(
                        reportingController: reportingController,
                        dashboardController: dashboardController,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        if (context.width < SizeConfig.size1100)
          ...obOptionsWidget(
            reportingController: reportingController,
            dashboardController: dashboardController,
          ),
      ],
    ),
  );
}
