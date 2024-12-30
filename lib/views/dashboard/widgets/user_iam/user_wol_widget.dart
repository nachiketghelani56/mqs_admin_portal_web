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
                      .userDetail.onboardingModel.mqsWheelOfLifeDetails.family ==
                  null
              ? ""
              : "${dashboardController.userDetail.onboardingModel.mqsWheelOfLifeDetails.family}",
          isFirst: true,
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.finance,
          value: dashboardController
                      .userDetail.onboardingModel.mqsWheelOfLifeDetails.finances ==
                  null
              ? ""
              : "${dashboardController.userDetail.onboardingModel.mqsWheelOfLifeDetails.finances}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.fun,
          value: dashboardController.userDetail.onboardingModel.mqsWheelOfLifeDetails.fun ==
                  null
              ? ""
              : "${dashboardController.userDetail.onboardingModel.mqsWheelOfLifeDetails.fun}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.health,
          value: dashboardController
                      .userDetail.onboardingModel.mqsWheelOfLifeDetails.health ==
                  null
              ? ""
              : "${dashboardController.userDetail.onboardingModel.mqsWheelOfLifeDetails.health}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.purpose,
          value: dashboardController
                      .userDetail.onboardingModel.mqsWheelOfLifeDetails.purpose ==
                  null
              ? ""
              : "${dashboardController.userDetail.onboardingModel.mqsWheelOfLifeDetails.purpose}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.relationship,
          value: dashboardController
                      .userDetail.onboardingModel.mqsWheelOfLifeDetails.relationship ==
                  null
              ? ""
              : "${dashboardController.userDetail.onboardingModel.mqsWheelOfLifeDetails.relationship}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.social,
          value: dashboardController
                      .userDetail.onboardingModel.mqsWheelOfLifeDetails.social ==
                  null
              ? ""
              : "${dashboardController.userDetail.onboardingModel.mqsWheelOfLifeDetails.social}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.work,
          value: dashboardController.userDetail.onboardingModel.mqsWheelOfLifeDetails.work ==
                  null
              ? ""
              : "${dashboardController.userDetail.onboardingModel.mqsWheelOfLifeDetails.work}",
          isLast: true,
        ),
      ],
    ],
  );
}
