import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_table_title_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam/user_top_buttons_widget.dart';

Widget userIAMWidget(
    {required DashboardController dashboardController,
    required BuildContext context}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          children: [
            userTopButtonsWidget(
              dashboardController: dashboardController,
              context: context,
            ),
            SizeConfig.size26.height,
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: SizeConfig.size25),
                child: Column(
                  children: [
                    userTableTitleWidget(context: context),
                    for (int i = 0; i < 10; i++)
                      userTableRowWidget(
                        isSelected: i == 2,
                        dashboardController: dashboardController,
                        context: context,
                      ),
                    userTableBottomWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      if (context.width > SizeConfig.size1500) ...[
        SizeConfig.size20.width,
        Expanded(
          child: userDetailWidget(dashboardController: dashboardController),
        ),
      ],
    ],
  );
}
