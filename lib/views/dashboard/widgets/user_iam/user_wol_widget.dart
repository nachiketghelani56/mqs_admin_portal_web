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
        title: StringConfig.dashboard.wOLValue,
        isShowContent: dashboardController.showWOL.value,
      ).tap(() {
        dashboardController.showWOL.value = !dashboardController.showWOL.value;
      }),
      if (dashboardController.showWOL.value) ...[
        SizeConfig.size10.height,
        keyValueWrapperWidget(
          key: StringConfig.dashboard.family,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.family}",
          isFirst: true,
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.finance,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.finances}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.fun,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.fun}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.health,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.health}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.purpose,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.purpose}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.relationship,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.relationship}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.social,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.social}",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.work,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.work}",
          isLast: true,
        ),
      ],
    ],
  );
}
