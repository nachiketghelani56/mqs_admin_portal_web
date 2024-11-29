import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_prefix_button.dart';
import 'package:mqs_admin_portal_web/widgets/search_text_field.dart';

Widget enterpriseTopButtonsWidget(
    {required DashboardController dashboardController,required MqsDashboardController mqsDashboardController,
    required BuildContext context}) {

  return context.width > SizeConfig.size1885
      ? Row(
          children: [
            CustomPrefixButton(
              prefixIcon: ImageConfig.filter,
              btnText: StringConfig.dashboard.filter,
              padding: SizeConfig.size15,
              onTap: () {mqsDashboardController.scaffoldKey.currentState?.openEndDrawer();
              },
            ),
            SizeConfig.size12.width,
            SearchTextField(
              controller: dashboardController.searchController,
              onChanged: (p0) {
                dashboardController.searchEnterprise();
              },
            ),
            const Spacer(),
            SizeConfig.size12.width,
            Container(
              height: SizeConfig.size46,
              decoration: FontTextStyleConfig.topOptionDecoration.copyWith(borderRadius: BorderRadius.circular(SizeConfig.size12),),
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConfig.size15),
              child: Image.asset(
                ImageConfig.import,
                width: SizeConfig.size22,
              ),
            ).tap(() {
              dashboardController.importEnterprise();
            }),
            SizeConfig.size12.width,
            Container(
              height: SizeConfig.size46,
              decoration: FontTextStyleConfig.topOptionDecoration.copyWith(borderRadius: BorderRadius.circular(SizeConfig.size12),),
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConfig.size15),
              child: Image.asset(
                ImageConfig.export,
                width: SizeConfig.size22,
              ),
            ).tap(() {
              dashboardController.exportEnterprise(dashboardController.enterprises);
            }),
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
        )
      : Row(
          children: [
            Container(
              height: SizeConfig.size46,
              decoration: FontTextStyleConfig.topOptionDecoration.copyWith(borderRadius: BorderRadius.circular(SizeConfig.size12),),
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
              decoration: FontTextStyleConfig.topOptionDecoration.copyWith(borderRadius: BorderRadius.circular(SizeConfig.size12),),
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConfig.size15),
              child: Image.asset(
                ImageConfig.import,
                width: SizeConfig.size22,
              ),
            ).tap(() {
              dashboardController.importEnterprise();
            }),
            SizeConfig.size12.width,
            Container(
              height: SizeConfig.size46,
              decoration: FontTextStyleConfig.topOptionDecoration.copyWith(borderRadius: BorderRadius.circular(SizeConfig.size12),),
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConfig.size15),
              child: Image.asset(
                ImageConfig.export,
                width: SizeConfig.size22,
              ),
            ).tap(() {
              dashboardController.exportEnterprise(dashboardController.enterprises);
            }),
            SizeConfig.size12.width,
            Container(
              height: SizeConfig.size46,
              decoration: FontTextStyleConfig.topOptionDecoration.copyWith(borderRadius: BorderRadius.circular(SizeConfig.size12),),
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConfig.size15),
              child: Image.asset(
                ImageConfig.add,
                width: SizeConfig.size22,
              ),
            ).tap(() {
              dashboardController.isEditEnterprise.value = false;
              dashboardController.isAddEnterprise.value = true;
              dashboardController.clearAllFields();
              if (context.width < SizeConfig.size1500) {
                Get.toNamed(AppRoutes.addEnterprise);
              }
            }),
          ],
        );
}
