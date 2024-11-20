import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/tab_widget.dart';

Widget headerWidget(
    {required ReportingController reportingController,
    required BuildContext context}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              StringConfig.mqsDashboard.reporting,
              style: FontTextStyleConfig.headerTextStyle,
            ),
          ),
          if (context.width > SizeConfig.size700) ...[
            SizeConfig.size24.width,
            tabWidget(reportingController: reportingController),
          ],
          SizeConfig.size24.width,
          Container(
            height: SizeConfig.size58,
            width: SizeConfig.size60,
            decoration: FontTextStyleConfig.cardDecoration,
            alignment: Alignment.center,
            child: Image.asset(
              ImageConfig.filterNew,
              height: SizeConfig.size28,
            ),
          )
        ],
      ),
      if (context.width < SizeConfig.size700) ...[
        SizeConfig.size20.height,
        tabWidget(reportingController: reportingController),
      ],
    ],
  );
}
