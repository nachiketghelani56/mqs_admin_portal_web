import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  final DashboardController _dashboardController =
      Get.put(DashboardController());
  final HomeController _homeController = Get.put(HomeController());
  final MqsDashboardController _mqsDashboardController =
      Get.put(MqsDashboardController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          homeHeaderWidget(
              homeController: _homeController,
              context: context,
              scaffoldKey: scaffoldKey),
          SizeConfig.size15.height,
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                // Row(
                //   children: [
                //     if (context.width < SizeConfig.size600)
                //       IconButton(
                //         onPressed: () {
                //           _dashboardController.scaffoldKey.currentState
                //               ?.openDrawer();
                //         },
                //         icon: const Icon(
                //           Icons.menu,
                //           color: ColorConfig.primaryColor,
                //         ),
                //       ),
                //     logoWidget().center,
                //     SizeConfig.size30.width,
                //     if (context.width > SizeConfig.size600)
                //       tabsWidget(dashboardController: _dashboardController),
                //   ],
                // ),
                // SizeConfig.size34.height,
                Expanded(
                  child: Obx(
                    () {
                      if (_dashboardController.selectedTabIndex.value == 0) {
                        return enterpriseWidget(
                          dashboardController: _dashboardController,
                          mqsDashboardController: _mqsDashboardController,
                          context: context,
                        );
                      } else {
                        return userIAMWidget(
                          dashboardController: _dashboardController,
                          context: context,
                        );
                      }
                    },
                  ),
                )
              ],
            ).paddingOnly(
              left: SizeConfig.size40,
              right: SizeConfig.size40,
              top: SizeConfig.size25,
            ),
          ),
        ],
      ),
    );
  }
}
