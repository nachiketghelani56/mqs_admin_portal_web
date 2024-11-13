import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';

Widget tabsWidget({required DashboardController dashboardController}) {
  return Container(
    decoration: BoxDecoration(
      color: ColorConfig.bg2Color,
      borderRadius: BorderRadius.circular(SizeConfig.size4),
    ),
    padding: const EdgeInsets.all(SizeConfig.size8),
    child: Obx(
      () => Row(
        children: [
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
              child: Text(
                dashboardController.tabs[i],
                style: FontTextStyleConfig.tabTextStyle.copyWith(
                  color: dashboardController.selectedTabIndex.value == i
                      ? ColorConfig.whiteColor
                      : null,
                ),
              ),
            ).tap(() {
              dashboardController.selectedTabIndex.value = i;
            }),
        ],
      ),
    ),
  );
}
