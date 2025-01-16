import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userPrivacySettingDetailWidget(
    {required DashboardController dashboardController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.privacySettingsDetails,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSActivityLogs,
        value:
            "${dashboardController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSActivityLogs.toString().capitalize}",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleAbout,
        value:
            "${dashboardController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSCircleAbout.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleCountry,
        value:
            "${dashboardController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSCircleCountry.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleName,
        value:
            "${dashboardController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSCircleName.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCircleProfilePicture,
        value:
            "${dashboardController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSCircleProfilePicture.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSCirclePronouns,
        value:
            "${dashboardController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSCirclePronouns.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSOutreach,
        value:
            "${dashboardController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSOutreach.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPSSurveysAndStudies,
        value:
            "${dashboardController.userDetail.mqsPrivacySettingsDetails?.mqsUserPSSurveysAndStudies.toString().capitalize}",
        isLast: true,
      ),
    ],
  );
}
