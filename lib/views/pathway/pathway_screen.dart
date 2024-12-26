import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/header_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/pathway_widget.dart';

class PathwayScreen extends StatelessWidget {
  PathwayScreen({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final HomeController _homeController = Get.find();
  final PathwayController _pathwayController = Get.put(PathwayController());

  final DashboardController _dashboardController =
  Get.put(DashboardController());
  final MqsDashboardController _mqsDashboardController =
  Get.put(MqsDashboardController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        homeHeaderWidget(
            homeController: _homeController,
            context: context,
            scaffoldKey: scaffoldKey),
        SizeConfig.size25.height,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size40),
          child: headerWidget(
            title: StringConfig.mqsDashboard.pathway,
            mqsDashboardController: _mqsDashboardController,
            dashboardController: _dashboardController,
          ),
        ),
        Expanded(
          child: pathwayWidget(
            context: context,
            pathwayController: _pathwayController,
            scaffoldKey: scaffoldKey,
          ),
        ),
      ],
    );
  }
}
