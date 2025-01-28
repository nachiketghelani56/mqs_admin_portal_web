import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';

Widget headerNavigationWidget(
    {required String title,
      String subTitle ="",
      required MqsDashboardController mqsDashboardController,
      required DashboardController dashboardController,
      required int index}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: FontTextStyleConfig.navigationTextStyle,
      ),
      SizeConfig.size5.height,
      Row(
        children: [
          Text(
            StringConfig.database.data,
            style: FontTextStyleConfig.tableTextStyle.copyWith(
              color:
              ColorConfig.navigationTextColor.withOpacity(0.4),
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
            Image.asset(ImageConfig.arrowRightIcon,
              height: SizeConfig.size24,
              width: SizeConfig.size24,
            ),

            SizeConfig.size10.width,
            Flexible(
              child: Text(
                subTitle,
                overflow: TextOverflow.ellipsis,
                style: FontTextStyleConfig.tableTextStyle.copyWith(
                  color:
                  ColorConfig.navigationTextColor.withOpacity(0.4),
                ),
              ).hoverTap(() {
                mqsDashboardController.subMenuIndex.value = index;
                dashboardController.setTabIndex(index: index);
              }),
            ),
            SizeConfig.size10.width,
          ],
          Image.asset(ImageConfig.arrowRightIcon,
            height: SizeConfig.size24,
            width: SizeConfig.size24,
          ),
          SizeConfig.size10.width,
          Text(
            title,
            style: FontTextStyleConfig.tableBottomTextStyle.copyWith(
              color:
              ColorConfig.navigationTextColor,),
          ),
        ],
      ),
    ],
  );
}
