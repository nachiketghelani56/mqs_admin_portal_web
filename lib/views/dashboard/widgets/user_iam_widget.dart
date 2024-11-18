import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
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
              child: dashboardController.users.isEmpty
                  ? Text(
                      StringConfig.dashboard.noDataFound,
                      style: FontTextStyleConfig.subtitleStyle,
                    ).center
                  : SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: SizeConfig.size25),
                      child: Column(
                        children: [
                          userTableTitleWidget(context: context),
                          for (int i = dashboardController.offset.value;
                              i < dashboardController.getMaxOffset();
                              i++)
                            userTableRowWidget(
                              isSelected:
                                  i == dashboardController.viewIndex.value,
                              dashboardController: dashboardController,
                              context: context,
                              index: i,
                            ),
                          userTableBottomWidget(
                              dashboardController: dashboardController),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      if (context.width > SizeConfig.size1500 &&
          dashboardController.users.isNotEmpty) ...[
        SizeConfig.size20.width,
        Expanded(
          child: userDetailWidget(dashboardController: dashboardController),
        ),
      ],
    ],
  );
}
