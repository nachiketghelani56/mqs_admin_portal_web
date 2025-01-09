import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';

Widget headerDatabaseWidget(
    {required String title,
     String subTitle ="",
    required MqsDashboardController mqsDashboardController,
    required DashboardController dashboardController,
    required int index}) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            StringConfig.database.data,
            style: FontTextStyleConfig.tabTextStyle.copyWith(
              fontSize: FontSizeConfig.fontSize18,
              color:
                  ColorConfig.primaryColor.withOpacity(SizeConfig.size0point7),
            ),
          ).hoverTap(
            () {
              mqsDashboardController.menuIndex.value = 1;
              mqsDashboardController.subMenuIndex.value = -1;
              dashboardController.setTabIndex(index: index);
            },
          ),
          SizeConfig.size10.width,
          if (subTitle.isNotEmpty) ...[
            const Icon(
              Icons.arrow_forward_ios,
              size: SizeConfig.size15,
              color: ColorConfig.primaryColor,
            ),
            SizeConfig.size10.width,
            Text(subTitle,
              style: FontTextStyleConfig.tabTextStyle.copyWith(
                fontSize: FontSizeConfig.fontSize18,
                color: ColorConfig.primaryColor
                    .withOpacity(SizeConfig.size0point7),
              ),
            ).hoverTap(() {
              mqsDashboardController.subMenuIndex.value = index;
              dashboardController.setTabIndex(index: index);
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
            title,
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
