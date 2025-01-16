import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userWOLWidget({required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsWheelOfLifeDetails,
        isShowContent: dashboardController.showWOL.value,
      ).tap(() {
        dashboardController.showWOL.value = !dashboardController.showWOL.value;
      }),
      if (dashboardController.showWOL.value) ...[
        SizeConfig.size10.height,
        keyValueWrapperWidget(
          key: StringConfig.dashboard.family,
          value: dashboardController
                      .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsFamily ==
                  null
              ? ""
              : "${dashboardController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsFamily}",
          isFirst: true,
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.finance,
          value: dashboardController
                      .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsFinances ==
                  null
              ? ""
              : "${dashboardController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsFinances}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.fun,
          value: dashboardController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsFun ==
                  null
              ? ""
              : "${dashboardController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsFun}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.health,
          value: dashboardController
                      .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsHealth ==
                  null
              ? ""
              : "${dashboardController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsHealth}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.purpose,
          value: dashboardController
                      .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsPurpose ==
                  null
              ? ""
              : "${dashboardController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsPurpose}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.relationship,
          value: dashboardController
                      .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsRelationship ==
                  null
              ? ""
              : "${dashboardController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsRelationship}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.social,
          value: dashboardController
                      .userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsSocial ==
                  null
              ? ""
              : "${dashboardController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsSocial}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.work,
          value: dashboardController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsWork ==
                  null
              ? ""
              : "${dashboardController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsWork}",

        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.timestamp,
          value:  dashboardController.dateConvert(dashboardController.userDetail.mqsOnboardingDetails?.mqsWheelOfLifeDetails?.mqsTimestamp ?? ""),


          isLast: true,
        ),
      ],
    ],
  );
}
