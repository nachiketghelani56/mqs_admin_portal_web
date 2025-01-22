import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/enterprise_data_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/enterprise_data_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/enterprise_data_table_title_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/enterprise_data_top_buttons_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

Widget enterpriseDataWidget(
    {required EnterpriseDataController enterpriseDataController,
    required MqsDashboardController mqsDashboardController,
    required BuildContext context}) {
  return enterpriseDataController.enterpriseLoader.value
      ? const LoaderWidget()
      : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: enterpriseDataController.enterprises.isNotEmpty
                      ? FontTextStyleConfig.cardDecoration
                      : null,
                  padding: const EdgeInsets.all(SizeConfig.size16),
                  child: Column(
                    children: [
                      enterpriseDataTopButtonsWidget(
                        enterpriseDataController: enterpriseDataController,
                        mqsDashboardController: mqsDashboardController,
                        context: context,
                      ),
                      SizeConfig.size26.height,
                      enterpriseDataController.searchedEnterprises.isEmpty
                          ? Text(
                              StringConfig.dashboard.noDataFound,
                              style: FontTextStyleConfig.subtitleStyle,
                            ).center
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  enterpriseDataTableTitleWidget(
                                      context: context),
                                  for (int i =
                                          enterpriseDataController.offset.value;
                                      i <
                                          enterpriseDataController
                                              .getMaxOffset();
                                      i++)
                                    enterpriseDataTableRowWidget(
                                      isSelected: i ==
                                              enterpriseDataController
                                                  .viewIndex.value &&
                                          !enterpriseDataController
                                              .isAddEnterprise.value,
                                      enterpriseDataController:
                                          enterpriseDataController,
                                      mqsDashboardController:
                                          mqsDashboardController,
                                      context: context,
                                      index: i,
                                    ),
                                  enterpriseDataTableBottomWidget(
                                      enterpriseDataController:
                                          enterpriseDataController),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
}
