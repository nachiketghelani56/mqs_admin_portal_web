import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_check_in_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_demographic_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_scenes_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_wol_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userOnboardingDataWidget(
    {required DashboardController dashboardController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.onboardingData,
        showArrowIcon: false,
      ),
      if (dashboardController
          .userDetail.onboardingModel.checkInValue.isNotEmpty) ...[
        SizeConfig.size24.height,
        userCheckInWidget(dashboardController: dashboardController),
      ],
      if (dashboardController
          .userDetail.onboardingModel.demoGraphicValue.isNotEmpty) ...[
        SizeConfig.size34.height,
        userDemographicWidget(dashboardController: dashboardController),
      ],
      if (dashboardController
          .userDetail.onboardingModel.scenesValue.isNotEmpty) ...[
        SizeConfig.size34.height,
        userScenesWidget(dashboardController: dashboardController),
      ],
      if(dashboardController.userDetail.onboardingModel.wOLValue
          .toJson()
          .toString() !=
          "{}")
        ...[
          SizeConfig.size34.height,
          userWOLWidget(dashboardController: dashboardController),
        ],

    ],
  );
}
