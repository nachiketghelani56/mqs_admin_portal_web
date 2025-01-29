import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataCognitiveWidget(
    {required UserDataController userDataController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.cognitiveDetail,
        isShowContent: userDataController.showCognitive.value,
      ).tap(() {
        userDataController.showCognitive.value =
            !userDataController.showCognitive.value;
      }),
      if (userDataController.showCognitive.value) ...[
        SizeConfig.size10.height,
        keyValueWrapperWidget(
          key: StringConfig.dashboard.cF,
          value: userDataController.userDetail.mqsUserGrowth?.mqsCognitive?.cF
                  .toString() ??
              "",
          isFirst: true,
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.cP,
          value: userDataController.userDetail.mqsUserGrowth?.mqsCognitive?.cP
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.cR,
          value: userDataController.userDetail.mqsUserGrowth?.mqsCognitive?.cR
                  .toString() ??
              "",
          isLast: true,
        ),
      ],
    ],
  );
}
