import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_cognitive_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_mind_skills_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/user_data_detail/widgets/user_data_techniques_widget.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataGrowthWidget({required UserDataController userDataController}) {
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
        value: userDataController.userDetail.mqsUserGrowth?.mqsDayStreak !=
                null
            ? "${userDataController.userDetail.mqsUserGrowth?.mqsDayStreak.toString()}"
            : "0",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsPracticeWeekStreak,
        value: userDataController
                    .userDetail.mqsUserGrowth?.mqsPracticeWeekStreak !=
                null
            ? "${userDataController.userDetail.mqsUserGrowth?.mqsPracticeWeekStreak.toString()}"
            : "0",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsReflectWeekStreak,
        value: userDataController
                    .userDetail.mqsUserGrowth?.mqsReflectWeekStreak !=
                null
            ? "${userDataController.userDetail.mqsUserGrowth?.mqsReflectWeekStreak.toString()}"
            : "0",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsDayStreakTimestamp,
        value: userDataController.dateConvert(userDataController
                .userDetail.mqsUserGrowth?.mqsDayStreakTimestamp ??
            ""),
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsWeeklyResetTimestamp,
        value: userDataController.dateConvert(userDataController
                .userDetail.mqsUserGrowth?.mqsWeeklyResetTimestamp ??
            ""),
        isLast: true,
      ),
      SizeConfig.size24.height,
      userDataCognitiveWidget(userDataController: userDataController),

      SizeConfig.size24.height,
      userDataMindSkillWidget(userDataController: userDataController),

      SizeConfig.size24.height,
      userDataTechniquesWidget(userDataController: userDataController),
    ],
  );
}
