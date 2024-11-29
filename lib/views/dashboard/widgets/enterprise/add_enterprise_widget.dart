import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/add_mqs_emp_email_list_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/add_mqs_enterprise_pocs_subscription_detail.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/add_mqs_enterprise_pocs_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/add_mqs_team_list_widget.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';

Widget addEnterpriseWidget(
    {required DashboardController dashboardController,
    required BuildContext context}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size26),
      decoration: FontTextStyleConfig.cardDecoration,

      child: Form(
        key: dashboardController.enterpriseFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dashboardController.isEditEnterprise.value
                  ? StringConfig.dashboard.editEnterprise
                  : StringConfig.dashboard.addEnterprise,
              style: FontTextStyleConfig.textFieldTextStyle
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizeConfig.size24.height,
            addMqsEnterprisePOCsWidget(
                dashboardController: dashboardController),
            SizeConfig.size34.height,
            addMqsTeamListWidget(dashboardController: dashboardController),
            SizeConfig.size34.height,
            addMqsEmpEmailListWidget(dashboardController: dashboardController),
            SizeConfig.size34.height,
            addMqsEnterprisePOCsSubscriptionDetailWidget(
                dashboardController: dashboardController, context: context),
            SizeConfig.size34.height,
            CustomTextField(
              controller: dashboardController.mqsEnterpriseCodeController,
              label: StringConfig.dashboard.mqsEnterPriseCode,
              hintText: StringConfig.dashboard.enterCode,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.dashboard.mqsEnterPriseCode.toLowerCase()),
            ),
            SizeConfig.size34.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: CustomButton(
                    btnText: StringConfig.dashboard.cancel,
                    onTap: () {
                      dashboardController.clearAllFields();
                      dashboardController.isAddEnterprise.value = false;
                      dashboardController.isEditEnterprise.value = false;
                      if (Get.currentRoute == AppRoutes.addEnterprise) {
                        Get.back();
                      }
                    },
                    isSelected: false,
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomButton(
                    btnText: dashboardController.isEditEnterprise.value
                        ? StringConfig.dashboard.update
                        : StringConfig.dashboard.submit,
                    onTap: () {
                      dashboardController.addEnterprise();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
