import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/home_screen.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/reporting_screen.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/widgets/side_menu_widget.dart';

class MqsDashboardScreen extends StatelessWidget {
  MqsDashboardScreen({super.key});

  final MqsDashboardController _mqsDashboardController =
      Get.put(MqsDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _mqsDashboardController.scaffoldKey,
      drawer: context.width < SizeConfig.size900
          ? sideMenuWidget(mqsDashboardController: _mqsDashboardController)
          : null,
      backgroundColor: ColorConfig.backgroundColor,
      body: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (context.width > SizeConfig.size900)
                sideMenuWidget(mqsDashboardController: _mqsDashboardController),
              Expanded(
                child: Obx(
                  () {
                    if (_mqsDashboardController.menuIndex.value == 0) {
                      if (_mqsDashboardController.subMenuIndex.value == 4) {
                        return ReportingScreen(
                            scaffoldKey: _mqsDashboardController.scaffoldKey);
                      }
                      return HomeScreen(
                          scaffoldKey: _mqsDashboardController.scaffoldKey);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
          if (context.width > SizeConfig.size900)
            Positioned(
              left: SizeConfig.size248,
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
