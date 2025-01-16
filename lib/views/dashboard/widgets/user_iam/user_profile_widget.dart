import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userProfileWidget({required DashboardController dashboardController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.userProfile,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        key: StringConfig.dashboard.about,
        value: dashboardController.userDetail.mqsUserProfile?.mqsAbout ?? "",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.country,
        value: dashboardController.userDetail.mqsUserProfile?.mqsCountry ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.pronouns,
        value: dashboardController.userDetail.mqsUserProfile?.mqsPronouns ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.postal,
        value: dashboardController.userDetail.mqsUserProfile?.mqsPostal ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.profession,
        value:
            dashboardController.userDetail.mqsUserProfile?.mqsProfession ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsAgeGroup,
        value: dashboardController.userDetail.mqsUserProfile?.mqsAgeGroup ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.userImageText,
        value: "${dashboardController.userDetail.mqsUserProfile?.mqsUserImage}",
        isImage: true,
        isLast: true,
      ),
    ],
  );
}
