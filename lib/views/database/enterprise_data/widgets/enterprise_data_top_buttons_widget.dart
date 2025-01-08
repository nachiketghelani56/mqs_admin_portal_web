import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_icon_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_prefix_button.dart';
import 'package:mqs_admin_portal_web/widgets/search_text_field.dart';

Widget enterpriseDataTopButtonsWidget({
  required EnterpriseDataController enterpriseDataController,
  required MqsDashboardController mqsDashboardController,
  required BuildContext context,
}) {
  return context.width > SizeConfig.size1885
      ? Row(
          children: [
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
            if (enterpriseDataController.enterprises.isNotEmpty)
              SearchTextField(
                controller: enterpriseDataController.searchController,
                hintText: StringConfig.dashboard.searchByNameEmail,
                onChanged: (p0) {
                  enterpriseDataController.searchEnterprise();
                },
              ),
            const Spacer(),
            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.import,
              onTap: () {
                enterpriseDataController.importEnterprise();
              },
            ),
            SizeConfig.size12.width,
            if (enterpriseDataController.enterprises.isNotEmpty)
              CustomIconButton(
                icon: ImageConfig.export,
                onTap: () {
                  enterpriseDataController
                      .exportEnterprise(enterpriseDataController.enterprises);
                },
              ),
            SizeConfig.size12.width,
            CustomPrefixButton(
              prefixIcon: ImageConfig.add,
              padding: SizeConfig.size15,
              btnText: StringConfig.dashboard.addEnterprise,
              onTap: () {
                enterpriseDataController.isEditEnterprise.value = false;
                enterpriseDataController.isAddEnterprise.value = true;
                enterpriseDataController.showMqsEmpEmailList.value = false;
                enterpriseDataController.showMqsTeamList.value = false;
                enterpriseDataController.showMqsEnterprisePocsList.value =
                    false;
                enterpriseDataController.mqsEmployeeEmailList.clear();
                enterpriseDataController.mqsTeamList.clear();
                enterpriseDataController.mqsEnterprisePOCsList.clear();
                enterpriseDataController.clearAllFields();
                if (context.width < SizeConfig.size1500) {
                  Get.toNamed(AppRoutes.addEnterpriseData);
                }
              },
            ),
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
              controller: enterpriseDataController.searchController,
              hintText: StringConfig.dashboard.searchByNameEmail,
              onChanged: (p0) {
                enterpriseDataController.searchEnterprise();
              },
            ),
            const Spacer(),
            CustomIconButton(
              icon: ImageConfig.import,
              onTap: () {
                enterpriseDataController.importEnterprise();
              },
            ),
            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.export,
              onTap: () {
                enterpriseDataController
                    .exportEnterprise(enterpriseDataController.enterprises);
              },
            ),
            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.add,
              onTap: () {
                enterpriseDataController.isEditEnterprise.value = false;
                enterpriseDataController.isAddEnterprise.value = true;
                enterpriseDataController.showMqsEmpEmailList.value = false;
                enterpriseDataController.showMqsEnterprisePocsList.value =
                    false;
                enterpriseDataController.showMqsTeamList.value = false;
                enterpriseDataController.mqsEmployeeEmailList.clear();
                enterpriseDataController.mqsTeamList.clear();
                enterpriseDataController.mqsEnterprisePOCsList.clear();
                enterpriseDataController.clearAllFields();
                if (context.width < SizeConfig.size1500) {
                  Get.toNamed(AppRoutes.addEnterpriseData);
                }
              },
            ),
          ],
        );
}
