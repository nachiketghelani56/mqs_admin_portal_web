import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataSubscriptionDetailWidget(
    {required UserDataController userDataController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.userSubscriptionReceipt,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        key: StringConfig.reporting.appSpecificSharedSecret,
        value: userDataController
                .userSubscriptionDetail?.mqsAppSpecificSharedSecret ??
            "",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.localVerificationData,
        value: userDataController
                .userSubscriptionDetail?.mqsLocalVerificationData ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.purchaseId,
        value: userDataController.userSubscriptionDetail?.mqsPurchaseID ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.serverVerificationData,
        value: userDataController
                .userSubscriptionDetail?.mqsServerVerificationData ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.transactionId,
        value:
            userDataController.userSubscriptionDetail?.mqsTransactionID ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.subscriptionStatus,
        value:
            userDataController.userSubscriptionDetail?.mqsSubscriptionStatus ??
                "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.subscriptionActivePlan,
        value: userDataController
                .userSubscriptionDetail?.mqsSubscriptionActivePlan ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.subscriptionPlatform,
        value: userDataController
                .userSubscriptionDetail?.mqsSubscriptionPlatform ??
            "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.source,
        value: userDataController.userSubscriptionDetail?.mqsSource ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.packageName,
        value: userDataController.userSubscriptionDetail?.mqsPackageName ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.mqsSubscriptionExpiryDate,
        value: (userDataController.userSubscriptionDetail
                        ?.mqsSubscriptionExpiryTimestamp ??
                    "")
                .isNotEmpty
            ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                DateTime.parse(userDataController.userSubscriptionDetail
                        ?.mqsSubscriptionExpiryTimestamp ??
                    ""))
            : "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.csv.subscriptionActivationTimestamp,
        value: (userDataController.userSubscriptionDetail
                        ?.mqsSubscriptionActivationTimestamp ??
                    "")
                .isNotEmpty
            ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                DateTime.parse(userDataController.userSubscriptionDetail
                        ?.mqsSubscriptionActivationTimestamp ??
                    ""))
            : "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.csv.subscriptionRenewalTimestamp,
        value: (userDataController.userSubscriptionDetail
                        ?.mqsSubscriptionRenewalTimestamp ??
                    "")
                .isNotEmpty
            ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                DateTime.parse(userDataController.userSubscriptionDetail
                        ?.mqsSubscriptionRenewalTimestamp ??
                    ""))
            : "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.csv.createdTimestamp,
        value:
            (userDataController.userSubscriptionDetail?.mqsCreatedTimestamp ??
                        "")
                    .isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(userDataController
                            .userSubscriptionDetail?.mqsCreatedTimestamp ??
                        ""))
                : "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.csv.updatedTimestamp,
        value:
            (userDataController.userSubscriptionDetail?.mqsUpdatedTimestamp ??
                        "")
                    .isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(userDataController
                            .userSubscriptionDetail?.mqsUpdatedTimestamp ??
                        ""))
                : "",
        isLast: true,
      ),
    ],
  );
}
