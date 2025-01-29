import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataMindSkillWidget(
    {required UserDataController userDataController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.mindSkillsDetail,
        isShowContent: userDataController.showMindSkill.value,
      ).tap(() {
        userDataController.showMindSkill.value =
            !userDataController.showMindSkill.value;
      }),
      if (userDataController.showMindSkill.value) ...[
        SizeConfig.size10.height,
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms1,
          value: userDataController.userDetail.mqsUserGrowth?.mqsMindSkills?.mS1
                  .toString() ??
              "",
          isFirst: true,
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms2,
          value: userDataController.userDetail.mqsUserGrowth?.mqsMindSkills?.mS2
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms3,
          value: userDataController.userDetail.mqsUserGrowth?.mqsMindSkills?.mS3
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms4,
          value: userDataController.userDetail.mqsUserGrowth?.mqsMindSkills?.mS4
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms5,
          value: userDataController.userDetail.mqsUserGrowth?.mqsMindSkills?.mS5
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms6,
          value: userDataController.userDetail.mqsUserGrowth?.mqsMindSkills?.mS6
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.ms7,
          value: userDataController.userDetail.mqsUserGrowth?.mqsMindSkills?.mS7
                  .toString() ??
              "",
          isLast: true,
        ),
      ],
    ],
  );
}
