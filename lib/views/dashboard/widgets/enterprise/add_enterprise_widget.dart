import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/main.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/add_mqs_emp_email_list_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/add_mqs_enterprise_location_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/enterprise/add_mqs_enterprise_pocs_widget.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';

Widget addEnterpriseWidget({required DashboardController dashboardController}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size26),
      decoration: FontTextstyleConfig.detailMainDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringConfig.dashboard.addEnterprise,
            style: FontTextstyleConfig.textfieldTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizeConfig.size24.height,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: dashboardController.subscriptionController,
                  label: StringConfig.dashboard.subscription,
                  hintText: StringConfig.dashboard.enterSubscription,
                ),
              ),
              SizeConfig.size24.width,
              Expanded(
                child: CustomTextField(
                  controller: dashboardController.idController,
                  label: StringConfig.dashboard.id,
                  hintText: StringConfig.dashboard.enterId,
                ),
              ),
            ],
          ),
          SizeConfig.size34.height,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: dashboardController.mqsEnterpriseCodeController,
                  label: StringConfig.dashboard.mqsEnterPriseCode,
                  hintText: StringConfig.dashboard.enterCode,
                ),
              ),
              SizeConfig.size24.width,
              Expanded(
                child: CustomTextField(
                  controller: dashboardController.mqsEnterpriseNameController,
                  label: StringConfig.dashboard.mqsEnterPriseName,
                  hintText: StringConfig.dashboard.enterName,
                ),
              ),
            ],
          ),
          SizeConfig.size34.height,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller:
                      dashboardController.mqsSubscriptionExpiryDateController,
                  label: StringConfig.dashboard.mqsSubscriptionExpiryDate,
                  hintText: StringConfig.dashboard.enterExpiryDate,
                  suffixIcon: ImageConfig.calendar,
                  readOnly: true,
                  onTap: () async {
                    if (navigatorKey.currentState?.context != null) {
                      DateTime? date = await showDatePicker(
                        context: navigatorKey.currentState!.context,
                        firstDate: DateTime(0),
                        lastDate: DateTime(3000),
                        initialDate: DateTime.now(),
                      );
                      if (date != null) {
                        dashboardController.mqsSubscriptionExpiryDateController
                            .text = DateFormat('dd/MM/yyyy').format(date);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
          SizeConfig.size34.height,
          addMqsEmpEmailListWidget(dashboardController: dashboardController),
          SizeConfig.size34.height,
          addMqsEnterpriseLocationDetailWidget(
              dashboardController: dashboardController),
          SizeConfig.size34.height,
          addMqsEnterprisePOCsWidget(dashboardController: dashboardController),
          SizeConfig.size34.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: CustomButton(
                  btnText: StringConfig.dashboard.cancel,
                  onTap: () {
                    dashboardController.isAddEnterprise.value = false;
                  },
                  isSelected: false,
                ),
              ),
              SizeConfig.size24.width,
              Expanded(
                child: CustomButton(
                  btnText: StringConfig.dashboard.add,
                  onTap: () {
                    dashboardController.isAddEnterprise.value = false;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
