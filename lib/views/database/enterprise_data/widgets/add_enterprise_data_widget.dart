import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/add_mqs_enterprise_data_emp_email_list_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/add_mqs_enterprise_data_pocs_subscription_detail.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/add_mqs_enterprise_data_pocs_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/add_mqs_enterprise_data_team_list_widget.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';

Widget addEnterpriseDataWidget(
    {required EnterpriseDataController enterpriseDataController,
      required BuildContext context}) {

  GlobalKey<FormState> enterpriseFormKey = GlobalKey<FormState>();
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Form(
        key: enterpriseFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              enterpriseDataController.isEditEnterprise.value
                  ? StringConfig.dashboard.editEnterprise
                  : StringConfig.dashboard.addEnterprise,
              style: FontTextStyleConfig.textFieldTextStyle
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizeConfig.size24.height,
            addMqsEnterpriseDataPOCsWidget(
                enterpriseDataController: enterpriseDataController),
            SizeConfig.size34.height,
            addMqsEnterpriseDataTeamListWidget(enterpriseDataController: enterpriseDataController),
            SizeConfig.size34.height,
            addMqsEnterpriseDataEmpEmailListWidget(enterpriseDataController: enterpriseDataController),
            SizeConfig.size34.height,
            addMqsEnterpriseDataPOCsSubscriptionDetailWidget(
                enterpriseDataController: enterpriseDataController, context: context),
            SizeConfig.size34.height,
            CustomTextField(
              controller: enterpriseDataController.mqsEnterpriseCodeController,
              label: StringConfig.dashboard.mqsEnterPriseCode,
              hintText: StringConfig.dashboard.enterCode,
              validator: (p0) => Validator.emptyValidator(p0 ?? "",
                  StringConfig.dashboard.mqsEnterPriseCode.toLowerCase()),
            ),
            SizeConfig.size34.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: CustomButton(
                    btnText: StringConfig.dashboard.cancel,
                    onTap: () {
                      enterpriseDataController.clearAllFields();
                      enterpriseDataController.isAddEnterprise.value = false;
                      enterpriseDataController.isEditEnterprise.value = false;
                      if (Get.currentRoute == AppRoutes.addEnterpriseData) {
                        Get.back();
                      }
                    },
                    isSelected: false,
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomButton(
                    btnText: enterpriseDataController.isEditEnterprise.value
                        ? StringConfig.dashboard.update
                        : StringConfig.dashboard.submit,
                    onTap: () {
                      if (enterpriseFormKey.currentState?.validate() ?? false) {
                        enterpriseDataController.addEnterprise();
                      }
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
