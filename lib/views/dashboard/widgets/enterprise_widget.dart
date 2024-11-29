import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_context.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/add_enterprise_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_table_title_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_top_buttons_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';

Widget enterpriseWidget(
    {required DashboardController dashboardController,required MqsDashboardController mqsDashboardController,
    required BuildContext context}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(
          children: [
            enterpriseTopButtonsWidget(
              dashboardController: dashboardController,
              mqsDashboardController: mqsDashboardController,
              context: context,
            ),
            SizeConfig.size26.height,
            Expanded(
              child: dashboardController.searchedEnterprises.isEmpty
                  ? Text(
                      StringConfig.dashboard.noDataFound,
                      style: FontTextStyleConfig.subtitleStyle,
                    ).center
                  : SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: SizeConfig.size25),
                      child: Column(
                        children: [
                          enterpriseTableTitleWidget(context: context),
                          for (int i = dashboardController.offset.value;
                              i < dashboardController.getMaxOffset();
                              i++)
                            enterpriseTableRowWidget(
                              isSelected: i ==
                                      dashboardController.viewIndex.value &&
                                  !dashboardController.isAddEnterprise.value,
                              dashboardController: dashboardController,
                              context: context,
                              index: i,
                            ),
                          enterpriseTableBottomWidget(
                              dashboardController: dashboardController),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      if (context.width > SizeConfig.size1500 &&
          (dashboardController.searchedEnterprises.isNotEmpty ||
              dashboardController.isAddEnterprise.value)) ...[
        SizeConfig.size20.width,
        Expanded(
          child: dashboardController.isAddEnterprise.value ||
                  dashboardController.isEditEnterprise.value
              ? addEnterpriseWidget(
                  dashboardController: dashboardController, context: context)
              : dashboardController.selectedViewIndex.value > (-1)
                  ? enterpriseDetailWidget(
                      dashboardController: dashboardController)
                  : Container(),
        ),
      ],
    ],
  );
}
