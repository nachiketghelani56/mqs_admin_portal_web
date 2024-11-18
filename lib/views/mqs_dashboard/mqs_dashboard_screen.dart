import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/widgets/mqs_dashboard_main_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/widgets/side_menu_widget.dart';

class MqsDashboardScreen extends StatelessWidget {
  MqsDashboardScreen({super.key});

  final MqsDashboardController _mqsDashboardController =
      Get.put(MqsDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.backgroundColor,
      body: Stack(
        children: [
          Row(
            children: [
              sideMenuWidget(mqsDashboardController: _mqsDashboardController),
              Expanded(
                child: mqsDashboardMainWidget(
                    mqsDashboardController: _mqsDashboardController),
              ),
            ],
          ),
          Positioned(
            left: SizeConfig.size236,
            top: SizeConfig.size60,
            child: Image.asset(
              ImageConfig.arrowLeft,
              height: SizeConfig.size29,
              width: SizeConfig.size29,
            ),
          ),
        ],
      ),
    );
  }
}
