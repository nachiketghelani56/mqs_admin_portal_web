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
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

Widget enterpriseWidget(
    {required DashboardController dashboardController,
    required MqsDashboardController mqsDashboardController,
    required BuildContext context , bool isReport = false,bool isStorage= false}) {
  return
    dashboardController.enterpriseLoader.value
      ? const LoaderWidget()
      : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: !(isReport && dashboardController.enterprises.isEmpty)
                      ? FontTextStyleConfig.cardDecoration
                      : null,
                  padding: const EdgeInsets.all(SizeConfig.size16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(!isStorage)...[
                        enterpriseTopButtonsWidget(
                          dashboardController: dashboardController,
                          mqsDashboardController: mqsDashboardController,
                          context: context,
                          isReport: isReport,
                        ),
                        SizeConfig.size26.height,
                      ],

                      dashboardController.searchedEnterprises.isEmpty
                          ? Text(
                              StringConfig.dashboard.noDataFound,
                              style: FontTextStyleConfig.subtitleStyle,
                            ).center
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  enterpriseTableTitleWidget(context: context),
                                  for (int i = dashboardController.offset.value;
                                      i < dashboardController.getMaxOffset(isReport: isReport);
                                      i++)
                                    enterpriseTableRowWidget(
                                      isSelected: i ==
                                              dashboardController
                                                  .viewIndex.value &&
                                          !dashboardController
                                              .isAddEnterprise.value,
                                      dashboardController: dashboardController,
                                      context: context,
                                      index: i,
                                      isReport: isReport,
                                      isStorage: isStorage
                                    ),
                                  enterpriseTableBottomWidget(
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
                (dashboardController.searchedEnterprises.isNotEmpty ||
                    dashboardController.isAddEnterprise.value)) ...[
              SizeConfig.size20.width,
              Expanded(
                child: dashboardController.isAddEnterprise.value ||
                        dashboardController.isEditEnterprise.value
                    ? addEnterpriseWidget(
                        dashboardController: dashboardController,
                        context: context)
                    : dashboardController.viewIndex.value > (-1)
                        ? enterpriseDetailWidget(
                            dashboardController: dashboardController)
                        : Container(),
              ),
            ],
          ],
        );
}
