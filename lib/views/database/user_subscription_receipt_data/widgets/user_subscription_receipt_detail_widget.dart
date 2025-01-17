import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/controller/user_subscription_receipt_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userSubscriptionReceiptDetailWidget(
    {required UserSubscriptionReceiptController
        userSubscriptionReceiptController}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget(
            title: StringConfig.database.subscriptionReceipt,
            showArrowIcon: false,
          ),
          SizeConfig.size10.height,
          keyValueWrapperWidget(
            key: StringConfig.reporting.firebaseUserId,
            value: userSubscriptionReceiptController
                    .userSubscriptionReceiptDetail.mqsFirebaseUserID ??
                "",
            isFirst: true,
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.mongoDbUserId,
            value: userSubscriptionReceiptController
                    .userSubscriptionReceiptDetail.mqsMONGODBUserID ??
                "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.appSpecificSharedSecret,
            value: userSubscriptionReceiptController
                    .userSubscriptionReceiptDetail.mqsAppSpecificSharedSecret ??
                "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.localVerificationData,
            value: userSubscriptionReceiptController
                    .userSubscriptionReceiptDetail.mqsLocalVerificationData ??
                "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.serverVerificationData,
            value: userSubscriptionReceiptController
                    .userSubscriptionReceiptDetail.mqsServerVerificationData ??
                "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.purchaseId,
            value: userSubscriptionReceiptController
                    .userSubscriptionReceiptDetail.mqsPurchaseID ??
                "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.transactionId,
            value: userSubscriptionReceiptController
                    .userSubscriptionReceiptDetail.mqsTransactionID ??
                "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.subscriptionStatus,
            value: userSubscriptionReceiptController
                    .userSubscriptionReceiptDetail.mqsSubscriptionStatus ??
                "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.subscriptionActivePlan,
            value: userSubscriptionReceiptController
                    .userSubscriptionReceiptDetail.mqsSubscriptionActivePlan ??
                "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.subscriptionPlatform,
            value: userSubscriptionReceiptController
                    .userSubscriptionReceiptDetail.mqsSubscriptionPlatform ??
                "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.source,
            value: userSubscriptionReceiptController
                    .userSubscriptionReceiptDetail.mqsSource ??
                "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.reporting.packageName,
            value: userSubscriptionReceiptController
                    .userSubscriptionReceiptDetail.mqsPackageName ??
                "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.dashboard.mqsSubscriptionActivationDate,
            value: (userSubscriptionReceiptController
                            .userSubscriptionReceiptDetail
                            .mqsSubscriptionActivationTimestamp)
                        ?.isNotEmpty ??
                    false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(userSubscriptionReceiptController
                            .userSubscriptionReceiptDetail
                            .mqsSubscriptionActivationTimestamp ??
                        ""))
                : "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.dashboard.mqsSubscriptionRenewalDate,
            value: (userSubscriptionReceiptController
                            .userSubscriptionReceiptDetail
                            .mqsSubscriptionRenewalTimestamp)
                        ?.isNotEmpty ??
                    false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(userSubscriptionReceiptController
                            .userSubscriptionReceiptDetail
                            .mqsSubscriptionRenewalTimestamp ??
                        ""))
                : "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.dashboard.mqsSubscriptionExpiryDate,
            value: (userSubscriptionReceiptController
                            .userSubscriptionReceiptDetail
                            .mqsSubscriptionExpiryTimestamp)
                        ?.isNotEmpty ??
                    false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(userSubscriptionReceiptController
                            .userSubscriptionReceiptDetail
                            .mqsSubscriptionExpiryTimestamp ??
                        ""))
                : "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.csv.createdTimestamp,
            value: (userSubscriptionReceiptController
                            .userSubscriptionReceiptDetail.mqsCreatedTimestamp)
                        ?.isNotEmpty ??
                    false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(userSubscriptionReceiptController
                            .userSubscriptionReceiptDetail
                            .mqsCreatedTimestamp ??
                        ""))
                : "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.csv.updatedTimestamp,
            value: (userSubscriptionReceiptController
                            .userSubscriptionReceiptDetail.mqsUpdatedTimestamp)
                        ?.isNotEmpty ??
                    false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(userSubscriptionReceiptController
                            .userSubscriptionReceiptDetail
                            .mqsUpdatedTimestamp ??
                        ""))
                : "",
            isLast: true,
          ),
        ],
      ),
    ),
  );
}
