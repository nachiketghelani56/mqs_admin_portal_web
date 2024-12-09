import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/circle/circle_screen.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/dashboard_screen.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/filter_sheet_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/home_screen.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/reporting_screen.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/widgets/side_menu_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/pathway_screen.dart';
import 'package:mqs_admin_portal_web/views/team_chart/team_chart_screen.dart';

class MqsDashboardScreen extends StatelessWidget {
  MqsDashboardScreen({super.key});

  final MqsDashboardController _mqsDashboardController =
      Get.put(MqsDashboardController());
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _mqsDashboardController.scaffoldKey,
      drawer: context.width < SizeConfig.size900
          ? sideMenuWidget(
              mqsDashboardController: _mqsDashboardController,
              dashboardController: _dashboardController,
            )
          : null,
      endDrawer: filterSheetWidget(dashboardController: _dashboardController),
      backgroundColor: ColorConfig.backgroundColor,
      body: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (context.width > SizeConfig.size900)
                sideMenuWidget(
                  mqsDashboardController: _mqsDashboardController,
                  dashboardController: _dashboardController,
                ),
              Expanded(
                child: Obx(
                  () {
                    if (_mqsDashboardController.menuIndex.value == 0) {
                      if (_mqsDashboardController.subMenuIndex.value == 0) {
                        return DashboardScreen(
                            scaffoldKey: _mqsDashboardController.scaffoldKey);
                      } else if (_mqsDashboardController.subMenuIndex.value ==
                          1) {
                        return DashboardScreen(
                          scaffoldKey: _mqsDashboardController.scaffoldKey,
                          isEnterprise: false,
                        );
                      } else if (_mqsDashboardController.subMenuIndex.value ==
                          2) {
                        return CircleScreen(
                            scaffoldKey: _mqsDashboardController.scaffoldKey);
                      } else if (_mqsDashboardController.subMenuIndex.value ==
                          3) {
                        return PathwayScreen(
                            scaffoldKey: _mqsDashboardController.scaffoldKey);
                      } else if (_mqsDashboardController.subMenuIndex.value ==
                          4) {
                        return TeamChartScreen(
                            scaffoldKey: _mqsDashboardController.scaffoldKey);
                      } else if (_mqsDashboardController.subMenuIndex.value ==
                          5) {
                        return ReportingScreen(
                            scaffoldKey: _mqsDashboardController.scaffoldKey);
                      } else {
                        return HomeScreen(
                          scaffoldKey: _mqsDashboardController.scaffoldKey,
                          dashboardController: _dashboardController,
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
