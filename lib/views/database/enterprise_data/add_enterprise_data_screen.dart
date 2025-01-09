import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/add_enterprise_data_widget.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/header_database_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';

class AddEnterpriseDataScreen extends StatelessWidget {
  AddEnterpriseDataScreen({super.key, this.scaffoldKey});

  final DashboardController _dashboardController =
      Get.put(DashboardController());
  final MqsDashboardController _mqsDashboardController =
      Get.put(MqsDashboardController());
  final EnterpriseDataController _enterpriseDataController =
      Get.put(EnterpriseDataController());

  final HomeController _homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState>? scaffoldKey;

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
            title: _enterpriseDataController.isEditEnterprise.value
                ? StringConfig.dashboard.editEnterprise
                : StringConfig.dashboard.addEnterprise,
            mqsDashboardController: _mqsDashboardController,
            dashboardController: _dashboardController,
            index: 0,
            subTitle: StringConfig.dashboard.enterprise,
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
                child: addEnterpriseDataWidget(
                    enterpriseDataController: _enterpriseDataController,
                    mqsDashboardController: _mqsDashboardController,
                    context: context),
              );
            },
          ),
        )
      ],
    );
  }
}
