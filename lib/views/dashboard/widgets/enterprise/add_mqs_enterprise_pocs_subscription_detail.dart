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
        title: StringConfig.dashboard.mqsEnterprisePOCsSubscriptionDetail,
        showArrowIcon: false,
      ),
      SizeConfig.size30.height,
      CustomTextField(
        controller: dashboardController.subscriptionActivePlanController,
        label: StringConfig.dashboard.subscriptionActivePlan,
        hintText: StringConfig.dashboard.enterSubscriptionActivePlan,
        validator: (p0) => Validator.emptyValidator(
            p0 ?? "", StringConfig.dashboard.subscriptionActivePlan),
      ),
      SizeConfig.size34.height,
      CustomTextField(
        controller: dashboardController.subscriptionStatusController,
        label: StringConfig.dashboard.subscriptionStatus,
        hintText: StringConfig.dashboard.enterSubscriptionStatus,
        validator: (p0) => Validator.emptyValidator(
            p0 ?? "", StringConfig.dashboard.subscriptionStatus),
      ),
      SizeConfig.size34.height,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomTextField(
              controller:
                  dashboardController.mqsSubscriptionStartDateController,
              label: StringConfig.dashboard.mqsSubscriptionStartDate,
              hintText: StringConfig.dashboard.enterStartDate,
              suffixIcon: ImageConfig.calendar,
              readOnly: true,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.dashboard.mqsSubscriptionStartDate),
              onTap: () async {
                dashboardController.pickStartDateTime(context, dashboardController.mqsSubscriptionStartDateController);
                // DateTime? date = await showDatePicker(
                //   context: context,
                //   firstDate: DateTime(0),
                //   lastDate: DateTime(3000),
                //   initialDate: DateTime.now(),
                // );
                // if (date != null) {
                //   dashboardController.mqsSubscriptionStartDateController.text =
                //       '${date.day}-${date.month}-${date.year}';
                //
                //   dashboardController.startDate.value = date.toIso8601String();
                // }
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
                  p0 ?? "", StringConfig.dashboard.mqsSubscriptionExpiryDate),
              onTap: () async {
                dashboardController.pickExpiryDateTime(context, dashboardController.mqsSubscriptionStartDateController);
                // DateTime? date = await showDatePicker(
                //   context: context,
                //   firstDate: dashboardController.startDate.value.isNotEmpty
                //       ? DateTime.parse(
                //           dashboardController.startDate.value,
                //         )
                //       : DateTime.now(),
                //   lastDate: DateTime(3000),
                //   initialDate: dashboardController.startDate.value.isNotEmpty
                //       ? DateTime.parse(
                //           dashboardController.startDate.value,
                //         )
                //       : DateTime.now(),
                // );
                // if (date != null) {
                //   dashboardController.mqsSubscriptionExpiryDateController.text =
                //       '${date.day}-${date.month}-${date.year}';
                //   dashboardController.expiryDate.value = date.toIso8601String();
                // }
              },
            ),
          ),
        ],
      ),
    ],
  );
}
