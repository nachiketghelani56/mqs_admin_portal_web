import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addMqsEnterprisePOCsSubscriptionDetailWidget(
    {required DashboardController dashboardController,
    required BuildContext context}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsEnterpriseSubscriptionDetail,
        showArrowIcon: false,
      ),
      SizeConfig.size30.height,
      CustomTextField(
        controller: dashboardController.subscriptionActivePlanController,
        label: StringConfig.dashboard.subscriptionActivePlan,
        hintText: StringConfig.dashboard.enterSubscriptionActivePlan,
        validator: (p0) => Validator.emptyValidator(p0 ?? "",
            StringConfig.dashboard.subscriptionActivePlan.toLowerCase()),
      ),
      SizeConfig.size34.height,
      CustomTextField(
        controller: dashboardController.subscriptionStatusController,
        label: StringConfig.dashboard.subscriptionStatus,
        hintText: StringConfig.dashboard.enterSubscriptionStatus,
        validator: (p0) => Validator.emptyValidator(
            p0 ?? "", StringConfig.dashboard.subscriptionStatus.toLowerCase()),
      ),
      SizeConfig.size34.height,
      if (dashboardController.isEditEnterprise.value) ...[
        CustomTextField(
          controller: dashboardController.mqsSubscriptionRenewalDateController,
          label: StringConfig.dashboard.mqsSubscriptionRenewalDate,
          hintText: StringConfig.dashboard.enterRenewalDate,
          suffixIcon: ImageConfig.calendar,
          readOnly: true,
          onTap: () async {
            dashboardController.pickRenewalDateTime(context,
                dashboardController.mqsSubscriptionRenewalDateController);
          },
        ),
        SizeConfig.size34.height,
      ],
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomTextField(
              controller:
                  dashboardController.mqsSubscriptionStartDateController,
              label: StringConfig.dashboard.mqsSubscriptionActivationDate,
              hintText: StringConfig.dashboard.enterActivationDate,
              suffixIcon: ImageConfig.calendar,
              readOnly: true,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "",
                  StringConfig.dashboard.mqsSubscriptionActivationDate
                      .toLowerCase()),
              onTap: () async {
                dashboardController.pickStartDateTime(context,
                    dashboardController.mqsSubscriptionStartDateController);
              },
            ),
          ),
          SizeConfig.size24.width,
          Expanded(
            child: CustomTextField(
              controller:
                  dashboardController.mqsSubscriptionExpiryDateController,
              label: StringConfig.dashboard.mqsSubscriptionExpiryDate,
              hintText: StringConfig.dashboard.enterExpiryDate,
              suffixIcon: ImageConfig.calendar,
              readOnly: true,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "",
                  StringConfig.dashboard.mqsSubscriptionExpiryDate
                      .toLowerCase()),
              onTap: () async {
                dashboardController.pickExpiryDateTime(context,
                    dashboardController.mqsSubscriptionStartDateController);
              },
            ),
          ),
        ],
      ),
    ],
  );
}
