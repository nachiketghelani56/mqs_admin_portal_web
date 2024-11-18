import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/widgets/header_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/widgets/well_above_score_widget.dart';

Widget mqsDashboardMainWidget(
    {required MqsDashboardController mqsDashboardController}) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(
            horizontal: SizeConfig.size40, vertical: SizeConfig.size15),
        color: ColorConfig.whiteColor,
        child: Row(
          children: [
            Expanded(
              child: Text(
                StringConfig.mqsDashboard.lastUpdate,
                style: FontTextStyleConfig.dateTextStyle,
              ),
            ),
            SizeConfig.size10.width,
            Image.asset(
              ImageConfig.notification,
              height: SizeConfig.size44,
              width: SizeConfig.size44,
            ),
          ],
        ),
      ),
      SizeConfig.size40.height,
      Column(
        children: [
          headerWidget(mqsDashboardController: mqsDashboardController),
          SizeConfig.size34.height,
          wellAboveScoreWidget(),
        ],
      ).paddingSymmetric(horizontal: 40),
    ],
  );
}
