import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/enterprise_detail_row_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/mqs_emp_email_list_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/mqs_enterprise_location_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/mqs_enterprise_pocs_widget.dart';

Widget enterpriseDetailWidget(
    {required DashboardController dashboardController}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size26),
      decoration: FontTextstyleConfig.detailMainDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ukscyu564HDG646733989GYGbgg",
            style: FontTextstyleConfig.textfieldTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizeConfig.size24.height,
          enterpriseDetailRowWidget(),
          SizeConfig.size34.height,
          mqsEmployeeEmailListWidget(dashboardController: dashboardController),
          SizeConfig.size34.height,
          mqsEnterpriseLocationDetailWidget(
              dashboardController: dashboardController),
          SizeConfig.size34.height,
          mqsEnterprisePOCsWidget(dashboardController: dashboardController),
        ],
      ),
    ),
  );
}
