import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataWOLWidget({required UserDataController userDataController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsWheelOfLifeDetails,
        isShowContent: userDataController.showWOL.value,
      ).tap(() {
        userDataController.showWOL.value = !userDataController.showWOL.value;
      }),
      if (userDataController.showWOL.value) ...[
        SizeConfig.size10.height,
        keyValueWrapperWidget(
          key: StringConfig.dashboard.family,
          value: userDataController
                      .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsFamily ==
                  null
              ? ""
              : "${userDataController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsFamily}",
          isFirst: true,
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.finance,
          value: userDataController
                      .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsFinances ==
                  null
              ? ""
              : "${userDataController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsFinances}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.fun,
          value: userDataController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsFun ==
                  null
              ? ""
              : "${userDataController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsFun}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.health,
          value: userDataController
                      .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsHealth ==
                  null
              ? ""
              : "${userDataController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsHealth}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.purpose,
          value: userDataController
                      .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsPurpose ==
                  null
              ? ""
              : "${userDataController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsPurpose}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.relationship,
          value: userDataController
                      .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsRelationship ==
                  null
              ? ""
              : "${userDataController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsRelationship}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.social,
          value: userDataController
                      .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsSocial ==
                  null
              ? ""
              : "${userDataController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsSocial}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.work,
          value: userDataController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsWork ==
                  null
              ? ""
              : "${userDataController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsWork}",

        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.timestamp,
          value:  userDataController.dateConvert(userDataController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsTimestamp ?? ""),


          isLast: true,
        ),
      ],
    ],
  );
}
