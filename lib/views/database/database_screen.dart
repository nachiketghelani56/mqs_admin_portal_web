import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/size_config.dart';
import 'package:mqs_admin_portal_web/views/database/controller/database_controller.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/database_options_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';

class DatabaseScreen extends StatelessWidget {
  DatabaseScreen({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final HomeController _homeController = Get.put(HomeController());
  final DatabaseController _databaseController =
  Get.put(DatabaseController());
  final MqsDashboardController _mqsDashboardController =
  Get.put(MqsDashboardController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          homeHeaderWidget(
              homeController: _homeController,
              context: context,
              scaffoldKey: scaffoldKey),

          databaseOptionsWidget(
            databaseController: _databaseController,
            mqsDashboardController: _mqsDashboardController,
            context: context,
          ).paddingAll(SizeConfig.size40),
        ],
      ),
    );
  }
}
