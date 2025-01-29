import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataTechniquesWidget(
    {required UserDataController userDataController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.techniquesDetail,
        isShowContent: userDataController.showTechnique.value,
      ).tap(() {
        userDataController.showTechnique.value =
            !userDataController.showTechnique.value;
      }),
      if (userDataController.showTechnique.value) ...[
        SizeConfig.size10.height,
        keyValueWrapperWidget(
          key: StringConfig.dashboard.t1,
          value: userDataController.userDetail.mqsUserGrowth?.mqsTechniques?.t1
                  .toString() ??
              "",
          isFirst: true,
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.t2,
          value: userDataController.userDetail.mqsUserGrowth?.mqsTechniques?.t2
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.t3,
          value: userDataController.userDetail.mqsUserGrowth?.mqsTechniques?.t3
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.t4,
          value: userDataController.userDetail.mqsUserGrowth?.mqsTechniques?.t4
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.t5,
          value: userDataController.userDetail.mqsUserGrowth?.mqsTechniques?.t5
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.t6,
          value: userDataController.userDetail.mqsUserGrowth?.mqsTechniques?.t6
                  .toString() ??
              "",
          isLast: true,
        ),
      ],
    ],
  );
}
