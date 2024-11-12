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
          value: '2.5',
          topBorder: true,
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.finance,
          value: '2.5',
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.fun,
          value: '2.5',
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.health,
          value: '2.5',
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.mqsTimeStamp,
          value: '2024-10-10T18:18:00.972307',
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.purpose,
          value: '2.5',
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.relationship,
          value: '2.5',
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.social,
          value: '2.5',
        ),
        keyValueRowWidget(
          key: StringConfig.dashboard.work,
          value: '2.5',
        ),
      ],
    ],
  );
}
