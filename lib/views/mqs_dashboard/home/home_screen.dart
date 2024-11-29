import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_options_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.scaffoldKey});

  final HomeController _homeController = Get.put(HomeController());
  final MqsDashboardController _mqsDashboardController =
      Get.put(MqsDashboardController());
  final GlobalKey<ScaffoldState> scaffoldKey;

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
          homeOptionsWidget(
                  homeController: _homeController,
                  mqsDashboardController: _mqsDashboardController)
              .paddingAll(SizeConfig.size40),
        ],
      ),
    );
  }
}
