import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/header_database_widget.dart';
import 'package:mqs_admin_portal_web/views/database_detail/circle_data_detail/widgets/circle_data_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';

class CircleDataDetailScreen extends StatelessWidget {
  CircleDataDetailScreen({super.key, this.scaffoldKey});
  final GlobalKey<ScaffoldState>? scaffoldKey;

  final CircleDataController _circleDataController =
      Get.put(CircleDataController());
  final HomeController _homeController = Get.put(HomeController());
  final MqsDashboardController _mqsDashboardController =
      Get.put(MqsDashboardController());
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        homeHeaderWidget(
          homeController: _homeController,
          context: context,
          scaffoldKey: scaffoldKey as GlobalKey<ScaffoldState>,
        ),
        SizeConfig.size25.height,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size40),
          child: headerDatabaseWidget(
            title: StringConfig.database.viewCircle,
            mqsDashboardController: _mqsDashboardController,
            dashboardController: _dashboardController,
            index: 2,
            subTitle: StringConfig.dashboard.circle,
          ),
        ),
        SizeConfig.size25.height,
        Expanded(
          child: Obx(
            () {
              return Padding(
                padding: const EdgeInsets.only(
                    left: SizeConfig.size40,
                    right: SizeConfig.size40,
                    bottom: SizeConfig.size25),
                child: circleDataDetailWidget(
                    circleDataController: _circleDataController),
              );
            },
          ),
        )
      ],
    );
  }
}
