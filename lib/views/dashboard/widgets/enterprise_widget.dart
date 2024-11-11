import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/add_enterprise_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_table_title_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_top_buttons_widget.dart';

Widget enterpriseWidget({required DashboardController dashboardController}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          children: [
            enterpriseTopButtonsWidget(
                dashboardController: dashboardController),
            SizeConfig.size26.height,
            enterpriseTableTitleWidget(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: SizeConfig.size25),
                child: Column(
                  children: [
                    for (int i = 0; i < 10; i++)
                      enterpriseTableRowWidget(
                        isSelected: i == 2,
                        dashboardController: dashboardController,
                      ),
                    enterpriseTableBottomWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      SizeConfig.size20.width,
      Expanded(
        child: dashboardController.isAddEnterprise.value
            ? addEnterpriseWidget(dashboardController: dashboardController)
            : enterpriseDetailWidget(dashboardController: dashboardController),
      ),
    ],
  );
}
