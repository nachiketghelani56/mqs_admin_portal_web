import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_icon_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_prefix_button.dart';
import 'package:mqs_admin_portal_web/widgets/search_text_field.dart';

Widget enterpriseTopButtonsWidget({
  required DashboardController dashboardController,
  required MqsDashboardController mqsDashboardController,
  required BuildContext context,
  bool isReport = false,
}) {
  return context.width > SizeConfig.size1885
      ? Row(
          children: [
            if (!isReport) ...[
              CustomPrefixButton(
                prefixIcon: ImageConfig.filter,
                btnText: StringConfig.dashboard.filter,
                padding: SizeConfig.size15,
                onTap: () {
                  mqsDashboardController.scaffoldKey.currentState
                      ?.openEndDrawer();
                },
              ),
              SizeConfig.size12.width,
            ],
            if (!(isReport && dashboardController.enterprises.isEmpty))
              SearchTextField(
                controller: dashboardController.searchController,
                hintText: StringConfig.dashboard.searchByNameEmail,
                onChanged: (p0) {
                  dashboardController.searchEnterprise();
                },
              ),
            const Spacer(),
            if (!isReport) ...[
              SizeConfig.size12.width,
              CustomIconButton(
                icon: ImageConfig.import,
                onTap: () {
                  dashboardController.importEnterprise();
                },
              ),
              SizeConfig.size12.width,
            ],
            if (!(isReport && dashboardController.enterprises.isEmpty))
              CustomIconButton(
                icon: ImageConfig.export,
                onTap: () {
                  dashboardController
                      .exportEnterprise(dashboardController.enterprises);
                },
              ),
            if (!isReport) ...[
              SizeConfig.size12.width,
              CustomPrefixButton(
                prefixIcon: ImageConfig.add,
                padding: SizeConfig.size15,
                btnText: StringConfig.dashboard.addEnterprise,
                onTap: () {
                  dashboardController.isEditEnterprise.value = false;
                  dashboardController.isAddEnterprise.value = true;
                  dashboardController.showMqsEmpEmailList.value = false;
                  dashboardController.showMqsTeamList.value = false;
                  dashboardController.mqsEmployeeEmailList.clear();
                  dashboardController.mqsTeamList.clear();
                  dashboardController.clearAllFields();
                  if (context.width < SizeConfig.size1500) {
                    Get.toNamed(AppRoutes.addEnterprise);
                  }
                },
              ),
            ],
          ],
        )
      : Row(
          children: [
            CustomIconButton(
              icon: ImageConfig.filter,
              onTap: () {
                mqsDashboardController.scaffoldKey.currentState
                    ?.openEndDrawer();
              },
            ),
            SizeConfig.size12.width,
            SearchTextField(
              controller: dashboardController.searchController,
              hintText: StringConfig.dashboard.searchByNameEmail,
              onChanged: (p0) {
                dashboardController.searchEnterprise();
              },
            ),
            const Spacer(),
            // SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.import,
              onTap: () {
                dashboardController.importEnterprise();
              },
            ),
            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.export,
              onTap: () {
                dashboardController
                    .exportEnterprise(dashboardController.enterprises);
              },
            ),
            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.add,
              onTap: () {
                dashboardController.isEditEnterprise.value = false;
                dashboardController.isAddEnterprise.value = true;
                dashboardController.showMqsEmpEmailList.value = false;
                dashboardController.showMqsTeamList.value = false;
                dashboardController.mqsEmployeeEmailList.clear();
                dashboardController.mqsTeamList.clear();
                dashboardController.clearAllFields();
                if (context.width < SizeConfig.size1500) {
                  Get.toNamed(AppRoutes.addEnterprise);
                }
              },
            ),
          ],
        );
}
