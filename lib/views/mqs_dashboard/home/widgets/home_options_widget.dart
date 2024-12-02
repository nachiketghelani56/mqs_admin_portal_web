import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';

Widget homeOptionsWidget(
    {required HomeController homeController,
    required MqsDashboardController mqsDashboardController,
    required DashboardController dashboardController}) {
  return Wrap(
    spacing: SizeConfig.size34,
    runSpacing: SizeConfig.size34,
    children: [
      for (int i = 0; i < homeController.options.length; i++)
        GestureDetector(
          onTap: () {
            mqsDashboardController.subMenuIndex.value = i;
            mqsDashboardController.isShowHome.value = true;
            if (i < 2) {
              dashboardController.setTabIndex(index: i);
            }
          },
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                height: SizeConfig.size254,
                width: SizeConfig.size343,
                decoration: FontTextStyleConfig.cardDecoration,
                margin: const EdgeInsets.only(top: SizeConfig.size14),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      homeController.options[i].icon,
                      height: SizeConfig.size72,
                      width: SizeConfig.size72,
                    ),
                    SizeConfig.size12.height,
                    Text(
                      homeController.options[i].title,
                      style: FontTextStyleConfig.cardSubTextStyle
                          .copyWith(color: ColorConfig.primaryColor),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.size100,
                height: SizeConfig.size24,
                decoration: FontTextStyleConfig.folderDecoration,
              ),
            ],
          ),
        )
    ],
  );
}
