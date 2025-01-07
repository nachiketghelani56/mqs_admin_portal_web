import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/database/controller/database_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';

Widget databaseOptionsWidget({
  required DatabaseController databaseController,
  required MqsDashboardController mqsDashboardController,  required DashboardController dashboardController,
  required BuildContext context,
}) {
  return Wrap(
    spacing: SizeConfig.size34,
    runSpacing: SizeConfig.size34,
    children: [
      for (int i = 0; i < databaseController.options.length; i++)
        GestureDetector(
          onTap: () {
            mqsDashboardController.subMenuIndex.value = i;
            mqsDashboardController.setTrueAtIndex(1);
            dashboardController.setTabIndex(index: i);
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      databaseController.options[i].icon ?? "",
                      height: SizeConfig.size72,
                      width: SizeConfig.size72,
                    ),
                    SizeConfig.size12.height,
                    Text(
                      databaseController.options[i].title,
                      textAlign: TextAlign.center,
                      style: FontTextStyleConfig.subMenuTextStyle.copyWith(
                        color: ColorConfig.primaryColor,
                        fontSize: FontSizeConfig.fontSize20,
                      ),
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
