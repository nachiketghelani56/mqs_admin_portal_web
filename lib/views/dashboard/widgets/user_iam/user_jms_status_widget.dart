import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userJMSStatusWidget({required DashboardController dashboardController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.userJMSStatus,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserInPathway,
        value:dashboardController.userDetail.mqsUserJMStatus?.mqsUserInPathway != null?
            "${dashboardController.userDetail.mqsUserJMStatus?.mqsUserInPathway.toString().capitalize}" : "",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPathwayID,
        value:
            dashboardController.userDetail.mqsUserJMStatus?.mqsUserPathwayID ??
                "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsUserPathwayLevel,
        value:dashboardController
            .userDetail.mqsUserJMStatus?.mqsUserPathwayLevel != null ?dashboardController
                .userDetail.mqsUserJMStatus?.mqsUserPathwayLevel
                .toString() ??
            "" : "0",

      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsPathwayScreenList,
        value:
        dashboardController
            .userDetail.mqsUserJMStatus?.mqsPathwayScreenList?.map((e)=>e).join("   |   ") ?? "",

      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsCompletedPathwayList,
        value:
        dashboardController
            .userDetail.mqsUserJMStatus?.mqsCompletedPathwayList?.map((e)=>e).join("   |   ")?? "",
        isLast: true,
      ),
    ],
  );
}
