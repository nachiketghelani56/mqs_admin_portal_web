import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addMqsEnterpriseDataPOCsSubscriptionDetailWidget(
    {required EnterpriseDataController enterpriseDataController,
    required BuildContext context}) {
  return context.width > SizeConfig.size1500
      ? Column(
          children: [
            titleWidget(
              title: StringConfig.dashboard.mqsEnterpriseSubscriptionDetail,
              showArrowIcon: false,
            ),
            SizeConfig.size30.height,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: enterpriseDataController
                        .subscriptionActivePlanController,
                    label: StringConfig.dashboard.subscriptionActivePlan,
                    hintText:
                        StringConfig.dashboard.enterSubscriptionActivePlan,
                    validator: (p0) => Validator.emptyValidator(
                        p0 ?? "",
                        StringConfig.dashboard.subscriptionActivePlan
                            .toLowerCase()),
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomTextField(
                    controller:
                        enterpriseDataController.subscriptionStatusController,
                    label: StringConfig.dashboard.subscriptionStatus,
                    hintText: StringConfig.dashboard.enterSubscriptionStatus,
                    validator: (p0) => Validator.emptyValidator(
                        p0 ?? "",
                        StringConfig.dashboard.subscriptionStatus
                            .toLowerCase()),
                  ),
                ),
              ],
            ),
            SizeConfig.size34.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: enterpriseDataController
                        .mqsSubscriptionStartDateController,
                    label: StringConfig.dashboard.mqsSubscriptionActivationDate,
                    hintText: StringConfig.dashboard.enterActivationDate,
                    suffixIcon: ImageConfig.calendar,
                    readOnly: true,
                    validator: (p0) => Validator.emptyValidator(
                        p0 ?? "",
                        StringConfig.dashboard.mqsSubscriptionActivationDate
                            .toLowerCase()),
                    onTap: () async {
                      enterpriseDataController.pickStartDateTime(
                          context,
                          enterpriseDataController
                              .mqsSubscriptionStartDateController);
                    },
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomTextField(
                    controller: enterpriseDataController
                        .mqsSubscriptionExpiryDateController,
                    label: StringConfig.dashboard.mqsSubscriptionExpiryDate,
                    hintText: StringConfig.dashboard.enterExpiryDate,
                    suffixIcon: ImageConfig.calendar,
                    readOnly: true,
                    validator: (p0) => Validator.emptyValidator(
                        p0 ?? "",
                        StringConfig.dashboard.mqsSubscriptionExpiryDate
                            .toLowerCase()),
                    onTap: () async {
                      enterpriseDataController.pickExpiryDateTime(
                          context,
                          enterpriseDataController
                              .mqsSubscriptionStartDateController);
                    },
                  ),
                ),
              ],
            ),
            if (enterpriseDataController.isEditEnterprise.value) ...[
              SizeConfig.size34.height,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: enterpriseDataController
                          .mqsSubscriptionRenewalDateController,
                      label: StringConfig.dashboard.mqsSubscriptionRenewalDate,
                      hintText: StringConfig.dashboard.enterRenewalDate,
                      suffixIcon: ImageConfig.calendar,
                      readOnly: true,
                      onTap: () async {
                        enterpriseDataController.pickRenewalDateTime(
                            context,
                            enterpriseDataController
                                .mqsSubscriptionRenewalDateController);
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              )
            ],
          ],
        )
      : Column(
          children: [
            titleWidget(
              title: StringConfig.dashboard.mqsEnterpriseSubscriptionDetail,
              showArrowIcon: false,
            ),
            SizeConfig.size30.height,
            CustomTextField(
              controller: enterpriseDataController
                  .subscriptionActivePlanController,
              label: StringConfig.dashboard.subscriptionActivePlan,
              hintText:
                  StringConfig.dashboard.enterSubscriptionActivePlan,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "",
                  StringConfig.dashboard.subscriptionActivePlan
                      .toLowerCase()),
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller:
                  enterpriseDataController.subscriptionStatusController,
              label: StringConfig.dashboard.subscriptionStatus,
              hintText: StringConfig.dashboard.enterSubscriptionStatus,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "",
                  StringConfig.dashboard.subscriptionStatus
                      .toLowerCase()),
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller: enterpriseDataController
                  .mqsSubscriptionStartDateController,
              label: StringConfig.dashboard.mqsSubscriptionActivationDate,
              hintText: StringConfig.dashboard.enterActivationDate,
              suffixIcon: ImageConfig.calendar,
              readOnly: true,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "",
                  StringConfig.dashboard.mqsSubscriptionActivationDate
                      .toLowerCase()),
              onTap: () async {
                enterpriseDataController.pickStartDateTime(
                    context,
                    enterpriseDataController
                        .mqsSubscriptionStartDateController);
              },
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller: enterpriseDataController
                  .mqsSubscriptionExpiryDateController,
              label: StringConfig.dashboard.mqsSubscriptionExpiryDate,
              hintText: StringConfig.dashboard.enterExpiryDate,
              suffixIcon: ImageConfig.calendar,
              readOnly: true,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "",
                  StringConfig.dashboard.mqsSubscriptionExpiryDate
                      .toLowerCase()),
              onTap: () async {
                enterpriseDataController.pickExpiryDateTime(
                    context,
                    enterpriseDataController
                        .mqsSubscriptionStartDateController);
              },
            ),
            if (enterpriseDataController.isEditEnterprise.value) ...[
              SizeConfig.size34.height,
              CustomTextField(
                controller: enterpriseDataController
                    .mqsSubscriptionRenewalDateController,
                label: StringConfig.dashboard.mqsSubscriptionRenewalDate,
                hintText: StringConfig.dashboard.enterRenewalDate,
                suffixIcon: ImageConfig.calendar,
                readOnly: true,
                onTap: () async {
                  enterpriseDataController.pickRenewalDateTime(
                      context,
                      enterpriseDataController
                          .mqsSubscriptionRenewalDateController);
                },
              ),

            ],
          ],
        );
}
