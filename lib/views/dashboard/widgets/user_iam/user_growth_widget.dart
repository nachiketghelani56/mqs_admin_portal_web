import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userGrowthWidget({required DashboardController dashboardController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.userGrowth,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSActivityLogs,
        value: dashboardController.userDetail.mqsUserGrowth?.mqsDayStreak !=
                null
            ? "${dashboardController.userDetail.mqsUserGrowth?.mqsDayStreak.toString()}"
            : "0",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleCountry,
        value: dashboardController
                    .userDetail.mqsUserGrowth?.mqsPracticeWeekStreak !=
                null
            ? "${dashboardController.userDetail.mqsUserGrowth?.mqsPracticeWeekStreak.toString()}"
            : "0",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleAbout,
        value: dashboardController
                    .userDetail.mqsUserGrowth?.mqsReflectWeekStreak !=
                null
            ? "${dashboardController.userDetail.mqsUserGrowth?.mqsReflectWeekStreak.toString()}"
            : "0",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleName,
        value: dashboardController.dateConvert(dashboardController
                .userDetail.mqsUserGrowth?.mqsDayStreakTimestamp ??
            ""),
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleProfilePicture,
        value: dashboardController.dateConvert(dashboardController
                .userDetail.mqsUserGrowth?.mqsWeeklyResetTimestamp ??
            ""),
        isLast: true,
      ),
    ],
  );
}
