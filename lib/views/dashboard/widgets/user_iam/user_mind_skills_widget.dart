import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userMindSkillWidget({required DashboardController dashboardController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.mindSkillsDetail,
        isShowContent: dashboardController.showMindSkill.value,
      ).tap(() {
        dashboardController.showMindSkill.value =
            !dashboardController.showMindSkill.value;
      }),
      if (dashboardController.showMindSkill.value) ...[
        SizeConfig.size10.height,
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms1,
          value: dashboardController
                  .userDetail.mqsUserGrowth?.mqsMindSkills?.mS1
                  .toString() ??
              "",
          isFirst: true,
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms2,
          value: dashboardController
                  .userDetail.mqsUserGrowth?.mqsMindSkills?.mS2
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms3,
          value: dashboardController
                  .userDetail.mqsUserGrowth?.mqsMindSkills?.mS3
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms4,
          value: dashboardController
                  .userDetail.mqsUserGrowth?.mqsMindSkills?.mS4
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms5,
          value: dashboardController
                  .userDetail.mqsUserGrowth?.mqsMindSkills?.mS5
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms6,
          value: dashboardController
                  .userDetail.mqsUserGrowth?.mqsMindSkills?.mS6
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms7,
          value: dashboardController
                  .userDetail.mqsUserGrowth?.mqsMindSkills?.mS7
                  .toString() ??
              "",
          isLast: true,
        ),
      ],
    ],
  );
}
