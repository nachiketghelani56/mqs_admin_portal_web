import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userSubscriptionDetailWidget(
    {required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.userSubscriptionReceipt,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        key: StringConfig.reporting.appSpecificSharedSecret,
        value: dashboardController
                .userSubscriptionDetail?.mqsAppSpecificSharedSecret ??
            "",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.localVerificationData,
        value: dashboardController
                .userSubscriptionDetail?.mqsLocalVerificationData ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.purchaseId,
        value: dashboardController.userSubscriptionDetail?.mqsPurchaseID ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.serverVerificationData,
        value: dashboardController
                .userSubscriptionDetail?.mqsServerVerificationData ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.transactionId,
        value:
            dashboardController.userSubscriptionDetail?.mqsTransactionID ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.subscriptionStatus,
          value: dashboardController
                .userSubscriptionDetail?.mqsSubscriptionStatus ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.subscriptionActivePlan,
        value: dashboardController
                .userSubscriptionDetail?.mqsSubscriptionActivePlan ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.subscriptionPlatform,
        value: dashboardController
                .userSubscriptionDetail?.mqsSubscriptionPlatform ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.source,
        value: dashboardController.userSubscriptionDetail?.mqsSource ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.packageName,
        value: dashboardController.userSubscriptionDetail?.mqsPackageName ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsSubscriptionExpiryDate,
        value: (dashboardController.userSubscriptionDetail?.mqsSubscriptionExpiryTimestamp ?? "")
                .isNotEmpty
            ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                DateTime.parse(
                    dashboardController.userSubscriptionDetail?.mqsSubscriptionExpiryTimestamp ??
                        ""))
            : "",

      ),
      keyValueWrapperWidget(
        key: StringConfig.csv.createdTimestamp,
        value: (dashboardController.userSubscriptionDetail?.mqsCreatedTimestamp ?? "")
            .isNotEmpty
            ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
            DateTime.parse(
                dashboardController.userSubscriptionDetail?.mqsCreatedTimestamp ??
                    ""))
            : "",

      ),
      keyValueWrapperWidget(
        key: StringConfig.csv.updatedTimestamp,
        value: (dashboardController.userSubscriptionDetail?.mqsUpdatedTimestamp ?? "")
            .isNotEmpty
            ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
            DateTime.parse(
                dashboardController.userSubscriptionDetail?.mqsUpdatedTimestamp ??
                    ""))
            : "",
        isLast: true,
      ),
    ],
  );
}
