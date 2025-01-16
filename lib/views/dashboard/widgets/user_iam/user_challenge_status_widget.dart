import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userChallengeStatusWidget(
    {required DashboardController dashboardController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.userChallengesStatus,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserInPathway,
        value: dashboardController
                    .userDetail.mqsUserChallengesStatus?.mqsUserInChallenges !=
                null
            ? "${dashboardController.userDetail.mqsUserChallengesStatus?.mqsUserInChallenges.toString().capitalize}"
            : "",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserChallengesTimestamp,
        value: dashboardController.dateConvert(dashboardController.userDetail
                .mqsUserChallengesStatus?.mqsUserChallengesTimestamp ??
            ""),
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsCompletedChallengesList,
        value: dashboardController
                .userDetail.mqsUserChallengesStatus?.mqsCompletedChallengesList
                ?.map((e) => e)
                .join("   |   ") ??
            "",
        isLast: true,
      ),
    ],
  );
}
