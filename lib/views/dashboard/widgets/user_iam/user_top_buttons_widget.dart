import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_prefix_button.dart';
import 'package:mqs_admin_portal_web/widgets/search_text_field.dart';

Widget userTopButtonsWidget(
    {required DashboardController dashboardController}) {
  return Row(
    children: [
      CustomPrefixButton(
        prefixIcon: ImageConfig.filter,
        btnText: StringConfig.dashboard.filter,
        onTap: () {
          dashboardController.scaffoldKey.currentState?.openEndDrawer();
        },
      ),
      SizeConfig.size12.width,
      SearchTextField(controller: dashboardController.searchController),
      const Spacer(),
      SizeConfig.size12.width,
      CustomPrefixButton(
        prefixIcon: ImageConfig.export,
        btnText: StringConfig.dashboard.export,
        onTap: () {},
      ),
    ],
  );
}
