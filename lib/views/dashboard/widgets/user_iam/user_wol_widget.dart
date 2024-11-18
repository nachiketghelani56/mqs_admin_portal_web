import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_row_widget.dart';
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
        keyValueRowWidget(
          key: StringConfig.dashboard.family,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.family}",
          topBorder: true,
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.finance,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.finances}",
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.fun,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.fun}",
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.health,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.health}",
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.purpose,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.purpose}",
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.relationship,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.relationship}",
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.social,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.social}",
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.work,
          value:
              "${dashboardController.userDetail.onboardingModel.wOLValue.work}",
        ),
      ],
    ],
  );
}
