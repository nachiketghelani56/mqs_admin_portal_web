import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_row_widget.dart';
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
      keyValueRowWidget(
        key: StringConfig.reporting.subscriptionStatus,
        value: dashboardController
                .userSubscriptionDetail?.mqsUserSubscriptionStatus ??
            "",
        isFirst: true,
      ),
      keyValueRowWidget(
        key: StringConfig.reporting.subscriptionActivePlan,
        value: dashboardController
                .userSubscriptionDetail?.mqsSubscriptionActivePlan ??
            "",
      ),
      keyValueRowWidget(
        key: StringConfig.reporting.subscriptionPlatform,
        value: dashboardController
                .userSubscriptionDetail?.mqsSubscriptionPlatform ??
            "",
      ),
      keyValueRowWidget(
        key: StringConfig.reporting.source,
        value: dashboardController.userSubscriptionDetail?.mqsSource ?? "",
      ),
      keyValueRowWidget(
        key: StringConfig.reporting.packageName,
        value: dashboardController.userSubscriptionDetail?.mqsPackageName ?? "",
      ),
      keyValueRowWidget(
        key: StringConfig.reporting.expiryDate,
        value: (dashboardController.userSubscriptionDetail?.mqsExpiryDate ?? "")
                .isNotEmpty
            ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                DateTime.parse(
                    dashboardController.userSubscriptionDetail?.mqsExpiryDate ??
                        ""))
            : "",
        isLast: true,
      ),
    ],
  );
}
