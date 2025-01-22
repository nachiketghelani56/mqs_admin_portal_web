import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataChallengeStatusWidget(
    {required UserDataController userDataController}) {
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
        value: userDataController
                    .userDetail.mqsUserChallengesStatus?.mqsUserInChallenges !=
                null
            ? "${userDataController.userDetail.mqsUserChallengesStatus?.mqsUserInChallenges.toString().capitalize}"
            : "",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserChallengesTimestamp,
        value: userDataController.dateConvert(userDataController.userDetail
                .mqsUserChallengesStatus?.mqsUserChallengesTimestamp ??
            ""),
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsCompletedChallengesList,
        value: userDataController
                .userDetail.mqsUserChallengesStatus?.mqsCompletedChallengesList
                ?.map((e) => e)
                .join("   |   ") ??
            "",
        isLast: true,
      ),
    ],
  );
}
