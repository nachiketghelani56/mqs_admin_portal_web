import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/add_mqs_enterprise_data_emp_email_list_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/add_mqs_enterprise_data_pocs_subscription_detail.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/add_mqs_enterprise_data_pocs_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/widgets/add_mqs_enterprise_data_team_list_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/widgets/add_user_data_information_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';

Widget addUserDataWidget(
    {required UserDataController userDataController,
    required MqsDashboardController mqsDashboardController,
    required BuildContext context}) {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userDataController.isEdit.value
                ? StringConfig.database.editUserInformation
                : StringConfig.database.addUserInformation,
            style: FontTextStyleConfig.textFieldTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizeConfig.size24.height,
          Form(
            key: formKey,
            child: addUserDataInformationWidget(
                userDataController: userDataController, context: context),
          ),
          SizeConfig.size34.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                onTap: () {
                  userDataController.clearAllFields();
                  userDataController.isAdd.value = false;
                  userDataController.isEdit.value = false;
                  mqsDashboardController.userStatus.value = "";
                },
                isSelected: false,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size40),
                  child: Text(
                    StringConfig.dashboard.cancel,
                    style: FontTextStyleConfig.buttonTextStyle
                        .copyWith(color: ColorConfig.primaryColor),
                  ),
                ),
              ),
              SizeConfig.size24.width,
              CustomButton(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size40),
                  child: Text(
                    userDataController.isEdit.value
                        ? StringConfig.dashboard.update
                        : StringConfig.dashboard.submit,
                    style: FontTextStyleConfig.buttonTextStyle
                        .copyWith(color: null),
                  ),
                ),
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    userDataController.addUser();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
