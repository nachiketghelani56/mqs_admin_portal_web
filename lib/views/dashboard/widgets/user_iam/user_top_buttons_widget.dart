import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_icon_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_prefix_button.dart';
import 'package:mqs_admin_portal_web/widgets/search_text_field.dart';

Widget userTopButtonsWidget(
    {required DashboardController dashboardController,
    required MqsDashboardController mqsDashboardController,
    required BuildContext context,
    bool isReport = false,
    Widget? filterWidget}) {
  return context.width > SizeConfig.size1800
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
            if (!(isReport && dashboardController.users.isEmpty))
              SearchTextField(
                controller: dashboardController.searchController,
                hintText: StringConfig.dashboard.searchByNameEmail,
                onChanged: (p0) {
                  if (isReport) {
                    dashboardController.searchUser(status: "type");
                  } else {
                    dashboardController.searchUser();
                  }
                },
              ),
            const Spacer(),
            SizeConfig.size12.width,
            if (!(isReport && dashboardController.users.isEmpty))
              CustomIconButton(
                icon: ImageConfig.export,
                onTap: () {
                  dashboardController.searchController.clear();
                  dashboardController.exportUserIAM();
                },
              ),
            if (filterWidget != null) ...[
              SizeConfig.size12.width,
              filterWidget
            ],
          ],
        )
      : Row(
          children: [
            if (!isReport) ...[
              CustomIconButton(
                icon: ImageConfig.filter,
                onTap: () {
                  mqsDashboardController.scaffoldKey.currentState
                      ?.openEndDrawer();
                },
              ),
              SizeConfig.size12.width,
            ],
            if (!(isReport && dashboardController.users.isEmpty))
              SearchTextField(
                controller: dashboardController.searchController,
                hintText: StringConfig.dashboard.searchByNameEmail,
                onChanged: (p0) {
                  if (isReport) {
                    dashboardController.searchUser(status: "type");
                  } else {
                    dashboardController.searchUser();
                  }
                },
              ),
            const Spacer(),
            SizeConfig.size12.width,
            if (!(isReport && dashboardController.users.isEmpty))
              CustomIconButton(
                icon: ImageConfig.export,
                onTap: () {
                  dashboardController.searchController.clear();
                  dashboardController.exportUserIAM();
                },
              ),
            if (filterWidget != null) ...[
              SizeConfig.size12.width,
              filterWidget
            ],
          ],
        );
}
