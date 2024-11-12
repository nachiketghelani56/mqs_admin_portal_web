import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_checkin_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_demographic_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_scenes_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_wol_widget.dart';

Widget userOnboardingDataWidget(
    {required DashboardController dashboardController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        StringConfig.dashboard.onboardingData,
        style: FontTextstyleConfig.textfieldTextStyle
            .copyWith(fontWeight: FontWeight.w600),
      ),
      SizeConfig.size24.height,
      userCheckInWidget(dashboardController: dashboardController),
      SizeConfig.size34.height,
      userDemographicWidget(dashboardController: dashboardController),
      SizeConfig.size34.height,
      userScenesWidget(dashboardController: dashboardController),
      SizeConfig.size34.height,
      userWOLWidget(dashboardController: dashboardController),
    ],
  );
}
