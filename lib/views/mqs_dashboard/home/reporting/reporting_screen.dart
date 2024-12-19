import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/circle/widgets/circle_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/header_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/reporting_main_widget.dart';
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
  final MqsDashboardController _mqsDashboardController =
      Get.put(MqsDashboardController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => homeHeaderWidget(
            homeController: _homeController,
            context: context,
            scaffoldKey: scaffoldKey,
            showBack: _reportingController.reportType.value.isNotEmpty,
            onBackTap: () {
              _reportingController.reportType.value = '';
            },
          ),
        ),
        SizeConfig.size20.height,
        Expanded(
          child: Obx(
            () {
              if ([
                StringConfig.reporting.totalRegisteredUsers,
                StringConfig.reporting.activeUsers,
                StringConfig.reporting.inactiveUsers,
                StringConfig.reporting.completed,
                StringConfig.reporting.partialCompletion,
                StringConfig.reporting.skipped,
                StringConfig.reporting.activeSubscription,
                StringConfig.reporting.purchasedSubscription
              ].contains(_reportingController.reportType.value)) {
                return Column(
                  children: [
                    SizeConfig.size20.height,
                    headerWidget(title: _reportingController.reportType.value),
                    SizeConfig.size25.height,
                    Expanded(
                      child: userIAMWidget(
                        dashboardController: _dashboardController,
                        context: context,
                        mqsDashboardController: _mqsDashboardController,
                        isReport: true,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: SizeConfig.size40);
              } else if ([
                StringConfig.reporting.totalCircles,
                StringConfig.reporting.featuredCircles,
                StringConfig.reporting.flaggedCircles,
              ].contains(_reportingController.reportType.value)) {
                return Column(
                  children: [
                    SizeConfig.size20.height,
                    headerWidget(title: _reportingController.reportType.value)
                        .paddingSymmetric(horizontal: SizeConfig.size40),
                    Expanded(
                      child: circleWidget(
                        context: context,
                        circleController: _circleController,
                        reportingController: _reportingController,
                        scaffoldKey: _reportingController.circleKey,
                        isReport: true,
                      ),
                    ),
                  ],
                );
              }
              return reportingMainWidget(
                context: context,
                reportingController: _reportingController,
                dashboardController: _dashboardController,
                circleController: _circleController,
              );
            },
          ),
        ),
      ],
    );
  }
}
