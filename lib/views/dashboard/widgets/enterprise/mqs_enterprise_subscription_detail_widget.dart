import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget mqsEnterpriseSubscriptionDetailWidget(
    {required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsEnterpriseSubscriptionDetail,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        isFirst: true,
        key: StringConfig.dashboard.activePlan,
        value: dashboardController.enterpriseDetail
            .mqsEnterpriseSubscriptionDetails.mqsSubscriptionActivePlan,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.status,
        value: dashboardController.enterpriseDetail
            .mqsEnterpriseSubscriptionDetails.mqsSubscriptionStatus,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.activationDate,
        value: dashboardController.dateConvert(dashboardController
            .enterpriseDetail
            .mqsEnterpriseSubscriptionDetails
            .mqsSubscriptionActivationTimestamp),
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.renewalDate,
        value: dashboardController.dateConvert(dashboardController
            .enterpriseDetail
            .mqsEnterpriseSubscriptionDetails
            .mqsSubscriptionRenewalDate),
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.expiryDate,
        value: dashboardController.dateConvert(dashboardController
            .enterpriseDetail
            .mqsEnterpriseSubscriptionDetails
            .mqsSubscriptionExpiryDate),
        isLast: true,
      ),
    ],
  );
}
