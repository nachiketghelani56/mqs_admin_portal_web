import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_context.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/add_enterprise_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_table_title_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_top_buttons_widget.dart';

Widget enterpriseWidget(
    {required DashboardController dashboardController,
    required BuildContext context}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          children: [
            enterpriseTopButtonsWidget(
              dashboardController: dashboardController,
              context: context,
            ),
            SizeConfig.size26.height,
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: SizeConfig.size25),
                child: Column(
                  children: [
                    enterpriseTableTitleWidget(context: context),
                    for (int i = 0; i < 10; i++)
                      enterpriseTableRowWidget(
                        isSelected: i == 2,
                        dashboardController: dashboardController,
                        context: context,
                      ),
                    enterpriseTableBottomWidget(),
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
          child: dashboardController.isAddEnterprise.value ||
                  dashboardController.isEditEnterprise.value
              ? addEnterpriseWidget(
                  dashboardController: dashboardController, context: context)
              : enterpriseDetailWidget(
                  dashboardController: dashboardController),
        ),
      ],
    ],
  );
}
