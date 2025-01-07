import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/database/controller/team_controller.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/header_database_widget.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/team/team_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';

class TeamCollectionScreen extends StatelessWidget {
  TeamCollectionScreen({super.key, required this.scaffoldKey});

  final HomeController _homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> scaffoldKey;
  final DashboardController _dashboardController =
      Get.put(DashboardController());
  final MqsDashboardController _mqsDashboardController =
      Get.put(MqsDashboardController());
  final TeamController _teamController = Get.put(TeamController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        homeHeaderWidget(
          homeController: _homeController,
          context: context,
          scaffoldKey: scaffoldKey,
        ),
        SizeConfig.size25.height,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size40),
          child: headerDatabaseWidget(
            title: StringConfig.reporting.team,
            mqsDashboardController: _mqsDashboardController,
            dashboardController: _dashboardController,
            index: 4,
          ),
        ),
        Expanded(
          child: teamWidget(
            context: context,
            teamController: _teamController,
            scaffoldKey: scaffoldKey,
          ),
        )
      ],
    );
  }
}
