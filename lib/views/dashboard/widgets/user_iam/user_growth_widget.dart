import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_cognitive_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_mind_skills_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_techniques_widget.dart';
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
        key: StringConfig.dashboard.mqsDayStreak,
        value: dashboardController.userDetail.mqsUserGrowth?.mqsDayStreak !=
                null
            ? "${dashboardController.userDetail.mqsUserGrowth?.mqsDayStreak.toString()}"
            : "0",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsPracticeWeekStreak,
        value: dashboardController
                    .userDetail.mqsUserGrowth?.mqsPracticeWeekStreak !=
                null
            ? "${dashboardController.userDetail.mqsUserGrowth?.mqsPracticeWeekStreak.toString()}"
            : "0",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsReflectWeekStreak,
        value: dashboardController
                    .userDetail.mqsUserGrowth?.mqsReflectWeekStreak !=
                null
            ? "${dashboardController.userDetail.mqsUserGrowth?.mqsReflectWeekStreak.toString()}"
            : "0",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsDayStreakTimestamp,
        value: dashboardController.dateConvert(dashboardController
                .userDetail.mqsUserGrowth?.mqsDayStreakTimestamp ??
            ""),
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsWeeklyResetTimestamp,
        value: dashboardController.dateConvert(dashboardController
                .userDetail.mqsUserGrowth?.mqsWeeklyResetTimestamp ??
            ""),
        isLast: true,

      ),

        SizeConfig.size24.height,
      userCognitiveWidget(dashboardController: dashboardController),

        SizeConfig.size24.height,
      userMindSkillWidget(dashboardController: dashboardController),

        SizeConfig.size24.height,
      userTechniquesWidget(dashboardController: dashboardController),

    ],
  );
}
