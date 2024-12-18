import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/auth_summary_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/ob_summary_widget.dart';

Widget authAndOBSummaryWidget(
    {required BuildContext context,
    required ReportingController reportingController,
    required DashboardController dashboardController}) {
  return Container(
    decoration: FontTextStyleConfig.cardDecoration,
    child: Column(
      children: [
        authSummaryWidget(
          context: context,
          reportingController: reportingController,
          dashboardController: dashboardController,
        ),
        obSummaryWidget(
          reportingController: reportingController,
          context: context,
          dashboardController: dashboardController,
        ),
      ],
    ),
  );
}
