import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/mqs_emp_email_list_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/mqs_enterprise_pocs_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/mqs_enterprise_subscription_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/mqs_team_list_widget.dart';

Widget enterpriseDetailWidget(
    {required DashboardController dashboardController}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size26),
      decoration: FontTextStyleConfig.detailMainDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mqsEnterprisePOCsWidget(dashboardController: dashboardController),
          SizeConfig.size34.height,
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: FontTextStyleConfig.headerDecoration,
            child: Row(
              children: [
                Expanded(
                  flex: SizeConfig.size4.toInt(),
                  child: Text(
                    StringConfig.dashboard.mqsEnterPriseCode,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    StringConfig.dashboard.isTeam,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: FontTextStyleConfig.contentDecoration.copyWith(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(SizeConfig.size12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: SizeConfig.size4.toInt(),
                  child: Text(
                    dashboardController.enterpriseDetail.mqsEnterpriseCode,
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    "${dashboardController.enterpriseDetail.mqsIsTeam.toString().capitalize}",
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          if (dashboardController.enterpriseDetail.mqsTeamList.isNotEmpty) ...[
            SizeConfig.size34.height,
            mqsTeamListWidget(dashboardController: dashboardController),
          ],
          if (dashboardController
              .enterpriseDetail.mqsEmployeeList.isNotEmpty) ...[
            SizeConfig.size34.height,
            mqsEmployeeEmailListWidget(
                dashboardController: dashboardController),
          ],
          if (dashboardController.checkEnterprisePOCsSubscriptionDetail()) ...[
            SizeConfig.size34.height,
            mqsEnterpriseSubscriptionDetailWidget(
                dashboardController: dashboardController),
          ]
        ],
      ),
    ),
  );
}
