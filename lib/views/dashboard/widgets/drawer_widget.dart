import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/logo_widget.dart';

Widget drawerWidget({required DashboardController dashboardController}) {
  return Drawer(
    child: Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizeConfig.size50.height,
          logoWidget(mainAxisSize: MainAxisSize.min).center,
          SizeConfig.size50.height,
          for (int i = 0; i < dashboardController.tabs.length; i++)
            Container(
              decoration: BoxDecoration(
                color: dashboardController.selectedTabIndex.value == i
                    ? ColorConfig.primaryColor
                    : null,
                borderRadius: BorderRadius.circular(SizeConfig.size2),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: SizeConfig.size34,
                vertical: SizeConfig.size12,
              ),
              alignment: Alignment.center,
              child: Text(
                dashboardController.tabs[i],
                style: FontTextStyleConfig.tabTextStyle.copyWith(
                  color: dashboardController.selectedTabIndex.value == i
                      ? ColorConfig.whiteColor
                      : null,
                ),
              ),
            ).tap(() {
              dashboardController.setTabIndex(index: i);
              Get.back();
            }),
        ],
      ),
    ),
  );
}
