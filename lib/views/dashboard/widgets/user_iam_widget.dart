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
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';

Widget userIAMWidget(
    {required DashboardController dashboardController,
    required MqsDashboardController mqsDashboardController,
    required BuildContext context}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: SizeConfig.size25),
          child: Container(
            decoration: FontTextStyleConfig.cardDecoration,
            padding: const EdgeInsets.all(SizeConfig.size16),
            child: Column(
              children: [
                userTopButtonsWidget(
                  dashboardController: dashboardController,
                  context: context,
                  mqsDashboardController: mqsDashboardController,
                ),
                SizeConfig.size26.height,
                dashboardController.searchedUsers.isEmpty
                    ? Text(
                        StringConfig.dashboard.noDataFound,
                        style: FontTextStyleConfig.subtitleStyle,
                      ).center
                    : SingleChildScrollView(
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
              ],
            ),
          ),
        ),
      ),
      if (context.width > SizeConfig.size1500 &&
          dashboardController.searchedUsers.isNotEmpty) ...[
        SizeConfig.size20.width,
        Expanded(
          child: dashboardController.viewIndex.value >= 0
              ? userDetailWidget(dashboardController: dashboardController)
              : const SizedBox.shrink(),
        ),
      ],
    ],
  );
}
