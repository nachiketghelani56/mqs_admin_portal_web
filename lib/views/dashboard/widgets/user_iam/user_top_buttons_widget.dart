import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_prefix_button.dart';
import 'package:mqs_admin_portal_web/widgets/search_text_field.dart';

Widget userTopButtonsWidget(
    {required DashboardController dashboardController,
    required BuildContext context}) {
  return context.width > SizeConfig.size1800
      ? Row(
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
        )
      : Row(
          children: [
            Container(
              height: SizeConfig.size46,
              decoration: FontTextStyleConfig.topOptionDecoration,
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConfig.size15),
              child: Image.asset(
                ImageConfig.filter,
                width: SizeConfig.size22,
              ),
            ).tap(() {
              dashboardController.scaffoldKey.currentState?.openEndDrawer();
            }),
            SizeConfig.size12.width,
            SearchTextField(controller: dashboardController.searchController),
            const Spacer(),
            SizeConfig.size12.width,
            Container(
              height: SizeConfig.size46,
              decoration: FontTextStyleConfig.topOptionDecoration,
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConfig.size15),
              child: Image.asset(
                ImageConfig.export,
                width: SizeConfig.size22,
              ),
            ).tap(() {}),
          ],
        );
}
