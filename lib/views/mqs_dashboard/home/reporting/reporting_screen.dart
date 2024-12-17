import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/auth_summary_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/circle_summary_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/header_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/ob_summary_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/subscription_summary_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/well_above_charts_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';

class ReportingScreen extends StatelessWidget {
  ReportingScreen({super.key, required this.scaffoldKey});

  final ReportingController _reportingController =
      Get.put(ReportingController());
  final GlobalKey<ScaffoldState> scaffoldKey;
  final HomeController _homeController = Get.put(HomeController());
  final CircleController _circleController = Get.put(CircleController());
  final DashboardController _dashboardController =
  Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          homeHeaderWidget(
              homeController: _homeController,
              context: context,
              scaffoldKey: scaffoldKey),
          SizeConfig.size40.height,
          Column(
            children: [
              headerWidget(
                  reportingController: _reportingController, context: context),
              SizeConfig.size25.height,
              authSummaryWidget(
                  context: context, reportingController: _reportingController),
              SizeConfig.size34.height,
              obSummaryWidget(
                  reportingController: _reportingController, context: context),
              SizeConfig.size25.height,
              circleSummaryWidget(
                  context: context, reportingController: _reportingController,circleController:_circleController),
              SizeConfig.size25.height,
              subscriptionSummaryWidget(
                  context: context, reportingController: _reportingController,dashboardController:_dashboardController),
              SizeConfig.size25.height,
              wellAboveChartsWidget(
                  reportingController: _reportingController, context: context),
              SizeConfig.size50.height,
            ],
          ).paddingSymmetric(horizontal: SizeConfig.size40),
        ],
      ),
    );
  }
}
