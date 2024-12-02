import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userCheckInWidget({required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.checkINValue,
        isShowContent: dashboardController.showCheckIn.value,
      ).tap(() {
        dashboardController.showCheckIn.value =
            !dashboardController.showCheckIn.value;
      }),
      if (dashboardController.showCheckIn.value) ...[
        SizeConfig.size10.height,
        Container(
          height: SizeConfig.size55,
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
          decoration: FontTextStyleConfig.headerDecoration,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  StringConfig.dashboard.checkInScore,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                child: Text(
                  StringConfig.dashboard.id,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                child: Text(
                  StringConfig.dashboard.mqsCINValue,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                child: Text(
                  StringConfig.dashboard.mqsTimeStamp,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
            ],
          ),
        ),
        for (int i = 0;
            i <
                dashboardController
                    .userDetail.onboardingModel.checkInValue.length;
            i++)
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: SizeConfig.size14, vertical: SizeConfig.size14),
            decoration: i ==
                    dashboardController
                            .userDetail.onboardingModel.checkInValue.length -
                        1
                ? FontTextStyleConfig.contentDecoration.copyWith(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(SizeConfig.size12),
                    ),
                  )
                : FontTextStyleConfig.contentDecoration,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${dashboardController.userDetail.onboardingModel.checkInValue[i].checkInScore}",
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    dashboardController
                        .userDetail.onboardingModel.checkInValue[i].id,
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    "${dashboardController.userDetail.onboardingModel.checkInValue[i].mqsCINValue}",
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    DateFormat('dd-MM-yyyy').format(DateTime.parse(
                        dashboardController.userDetail.onboardingModel
                            .checkInValue[i].mqsTimestamp)),
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
              ],
            ),
          ),
      ],
    ],
  );
}
