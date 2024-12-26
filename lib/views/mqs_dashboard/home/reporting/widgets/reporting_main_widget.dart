import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/auth_and_ob_summary_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/circle_summary_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/header_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/overall_summary_chart_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/sign_up_life_cycle_chart_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/subscription_summary_widget.dart';

Widget reportingMainWidget(
    {required BuildContext context,
    required ReportingController reportingController,
    required DashboardController dashboardController,
    required CircleController circleController,required MqsDashboardController mqsDashboardController,}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(
        horizontal: SizeConfig.size40, vertical: SizeConfig.size20),
    child: Column(
      children: [
        headerWidget(title: StringConfig.mqsDashboard.reports,mqsDashboardController: mqsDashboardController,
          dashboardController: dashboardController,),
        SizeConfig.size25.height,
        authAndOBSummaryWidget(
          context: context,
          reportingController: reportingController,
          dashboardController: dashboardController,
        ),
        SizeConfig.size25.height,
        circleSummaryWidget(
          context: context,
          reportingController: reportingController,
          circleController: circleController,
        ),
        SizeConfig.size25.height,
        subscriptionSummaryWidget(
          context: context,
          reportingController: reportingController,
          dashboardController: dashboardController,
        ),
        SizeConfig.size25.height,
        overallSummaryChartWidget(
          reportingController: reportingController,
          context: context,
        ),
        SizeConfig.size25.height,
        signUpLifeCycleChartWidget(
          reportingController: reportingController,
          context: context,
        ),
        SizeConfig.size30.height,
      ],
    ),
  );
}
