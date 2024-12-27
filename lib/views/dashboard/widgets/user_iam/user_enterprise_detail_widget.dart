import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userEnterpriseDetailWidget(
    {required DashboardController dashboardController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.enterpriseDetail,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        key: StringConfig.dashboard.individualID,
        value:
            dashboardController.userDetail.mqsEnterpriseDetails.mqsIndividualID,
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.individualValid,
        value:
            "${dashboardController.userDetail.mqsEnterpriseDetails.mqsIndividualValid.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.organizationID,
        value: dashboardController
                .userDetail.mqsEnterpriseDetails.mqsOrganizationID.isNotEmpty
            ? dashboardController
                .userDetail.mqsEnterpriseDetails.mqsOrganizationID
            : dashboardController.userDetail.enterpriseId,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.organizationValid,
        value:
            "${dashboardController.userDetail.mqsEnterpriseDetails.mqsOrganizationValid.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.teamID,
        value: dashboardController.userDetail.mqsEnterpriseDetails.mqsTeamID,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.teamValid,
        value:
            "${dashboardController.userDetail.mqsEnterpriseDetails.mqsTeamValid.toString().capitalize}",
        isLast: true,
      ),
    ],
  );
}
