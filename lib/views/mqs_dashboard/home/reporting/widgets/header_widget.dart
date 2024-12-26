import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';

Widget headerWidget(
    {required String title,
    required MqsDashboardController mqsDashboardController,
    required DashboardController dashboardController}) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            StringConfig.mqsDashboard.home,
            style: FontTextStyleConfig.tabTextStyle.copyWith(
              fontSize: FontSizeConfig.fontSize18,
              color:
                  ColorConfig.primaryColor.withOpacity(SizeConfig.size0point7),
            ),
          ).hoverTap(
            () {
              mqsDashboardController.menuIndex.value = 0;
              mqsDashboardController.subMenuIndex.value = -1;
            },
          ),
          SizeConfig.size10.width,
          if (![
            StringConfig.mqsDashboard.reports,
            StringConfig.dashboard.enterpriseList,
            StringConfig.dashboard.usersList,
            StringConfig.dashboard.circleList,
            StringConfig.mqsDashboard.pathway,
            StringConfig.teamChart.teamChart,
          ].contains(title))
            if (mqsDashboardController
                .getRouteName(mqsDashboardController.subMenuIndex.value)
                .isNotEmpty) ...[
              const Icon(
                Icons.arrow_forward_ios,
                size: SizeConfig.size15,
                color: ColorConfig.primaryColor,
              ),
              SizeConfig.size10.width,
              Text(
                mqsDashboardController
                    .getRouteName(mqsDashboardController.subMenuIndex.value),
                style: FontTextStyleConfig.tabTextStyle.copyWith(
                  fontSize: FontSizeConfig.fontSize18,
                  color: ColorConfig.primaryColor
                      .withOpacity(SizeConfig.size0point7),
                ),
              ).hoverTap(() {
                mqsDashboardController.subMenuIndex.value = 5;
                dashboardController.setTabIndex(index: 5);
              }),
              SizeConfig.size10.width,
            ],
          const Icon(
            Icons.arrow_forward_ios,
            size: SizeConfig.size15,
            color: ColorConfig.primaryColor,
          ),
          SizeConfig.size10.width,
          Text(
            title == StringConfig.dashboard.enterpriseList
                ? StringConfig.dashboard.enterprise
                : title == StringConfig.dashboard.usersList
                    ? StringConfig.dashboard.users
                    : title == StringConfig.dashboard.circleList
                        ? StringConfig.dashboard.circle
                        : title,
            style: FontTextStyleConfig.tabTextStyle.copyWith(
                fontSize: FontSizeConfig.fontSize19,
                color: ColorConfig.primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ],
  );
}
