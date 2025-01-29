import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userCognitiveWidget({required DashboardController dashboardController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.dashboard.cognitiveDetail,
        isShowContent: dashboardController.showCognitive.value,
      ).tap(() {
        dashboardController.showCognitive.value =
            !dashboardController.showCognitive.value;
      }),
      if (dashboardController.showCognitive.value) ...[
        SizeConfig.size10.height,
        keyValueWrapperWidget(
          key: StringConfig.dashboard.cF,
          value: dashboardController.userDetail.mqsUserGrowth?.mqsCognitive?.cF
                  .toString() ??
              "",
          isFirst: true,
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.cP,
          value: dashboardController.userDetail.mqsUserGrowth?.mqsCognitive?.cP
                  .toString() ??
              "",
        ),
        keyValueWrapperWidget(
          key: StringConfig.dashboard.cR,
          value: dashboardController.userDetail.mqsUserGrowth?.mqsCognitive?.cR
                  .toString() ??
              "",
          isLast: true,
        ),
      ],
    ],
  );
}
