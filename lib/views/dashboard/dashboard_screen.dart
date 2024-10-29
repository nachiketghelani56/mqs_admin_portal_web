import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/drawer_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/tabs_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam_widget.dart';
import 'package:mqs_admin_portal_web/widgets/logo_widget.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController _dashboardController =
      Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _dashboardController.scaffoldKey,
      drawer: context.width < SizeConfig.size600
          ? drawerWidget(dashboardController: _dashboardController)
          : null,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Row(
              children: [
                if (context.width < SizeConfig.size600)
                  IconButton(
                    onPressed: () {
                      _dashboardController.scaffoldKey.currentState
                          ?.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: ColorConfig.primaryColor,
                    ),
                  ),
                logoWidget().center,
                SizeConfig.size30.width,
                if (context.width > SizeConfig.size600)
                  tabsWidget(dashboardController: _dashboardController),
              ],
            ),
            SizeConfig.size34.height,
            Expanded(
              child: Obx(
                () {
                  if (_dashboardController.selectedTabIndex.value == 0) {
                    return enterpriseWidget();
                  } else {
                    return userIAMWidget();
                  }
                },
              ),
            )
          ],
        ).paddingSymmetric(
            horizontal: SizeConfig.size40, vertical: SizeConfig.size25),
      ),
    );
  }
}
