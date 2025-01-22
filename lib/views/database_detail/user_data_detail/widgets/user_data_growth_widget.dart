import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
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
        key: StringConfig.dashboard.mqsUserPSActivityLogs,
        value: userDataController.userDetail.mqsUserGrowth?.mqsDayStreak !=
                null
            ? "${userDataController.userDetail.mqsUserGrowth?.mqsDayStreak.toString()}"
            : "0",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleCountry,
        value: userDataController
                    .userDetail.mqsUserGrowth?.mqsPracticeWeekStreak !=
                null
            ? "${userDataController.userDetail.mqsUserGrowth?.mqsPracticeWeekStreak.toString()}"
            : "0",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleAbout,
        value: userDataController
                    .userDetail.mqsUserGrowth?.mqsReflectWeekStreak !=
                null
            ? "${userDataController.userDetail.mqsUserGrowth?.mqsReflectWeekStreak.toString()}"
            : "0",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleName,
        value: userDataController.dateConvert(userDataController
                .userDetail.mqsUserGrowth?.mqsDayStreakTimestamp ??
            ""),
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleProfilePicture,
        value: userDataController.dateConvert(userDataController
                .userDetail.mqsUserGrowth?.mqsWeeklyResetTimestamp ??
            ""),
        isLast: true,
      ),
    ],
  );
}
