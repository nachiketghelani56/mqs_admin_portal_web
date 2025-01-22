import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataEnterpriseDetailWidget(
    {required UserDataController userDataController}) {
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
        value: userDataController
                .userDetail.mqsEnterpriseDetails?.mqsIndividualID ??
            "",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.individualValid,
        value:
            "${userDataController.userDetail.mqsEnterpriseDetails?.mqsIndividualValid.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.organizationID,
        value: userDataController
                .userDetail.mqsEnterpriseDetails?.mqsOrganizationID ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.organizationName,
        value: userDataController
                .userDetail.mqsEnterpriseDetails?.mqsOrganizationName ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.organizationEmail,
        value: userDataController
                .userDetail.mqsEnterpriseDetails?.mqsOrganizationEmail ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.organizationValid,
        value:
            "${userDataController.userDetail.mqsEnterpriseDetails?.mqsOrganizationValid.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.teamID,
        value: userDataController.userDetail.mqsEnterpriseDetails?.mqsTeamID ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.teamValid,
        value:
            "${userDataController.userDetail.mqsEnterpriseDetails?.mqsTeamValid.toString().capitalize}",
        isLast: true,
      ),
    ],
  );
}
