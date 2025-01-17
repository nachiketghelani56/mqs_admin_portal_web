import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/controller/user_subscription_receipt_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';

Widget addUserSubscriptionReceiptWidget(
    {required UserSubscriptionReceiptController
        userSubscriptionReceiptController,
    required MqsDashboardController mqsDashboardController,
    required BuildContext context}) {
  GlobalKey<FormState> userSubRecFormKey = GlobalKey<FormState>();
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Form(
        key: userSubRecFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userSubscriptionReceiptController.isEdit.value
                  ? StringConfig.database.editSubscriptionReceiptInformation
                  : StringConfig.database.addSubscriptionReceiptInformation,
              style: FontTextStyleConfig.textFieldTextStyle
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizeConfig.size24.height,
            context.width > SizeConfig.size1500
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              readOnly:
                                  userSubscriptionReceiptController.isEdit.value
                                      ? true
                                      : false,
                              controller: userSubscriptionReceiptController
                                  .firebaseIdController,
                              label: StringConfig.reporting.firebaseUserId,
                              hintText:
                                  StringConfig.database.enterFirebaseUserId,
                              validator: (p0) => Validator.emptyValidator(
                                  p0 ?? "",
                                  StringConfig.reporting.firebaseUserId
                                      .toLowerCase()),
                            ),
                          ),
                          SizeConfig.size24.width,
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .mONGODBUserIDController,
                              label: StringConfig.reporting.mongoDbUserId,
                              hintText:
                                  StringConfig.database.enterMongoDbUserId,
                            ),
                          ),
                        ],
                      ),
                      SizeConfig.size34.height,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .appSpecificSharedSecretController,
                              label: StringConfig
                                  .reporting.appSpecificSharedSecret,
                              hintText: StringConfig
                                  .database.enterAppSpecificSharedSecret,
                            ),
                          ),
                          SizeConfig.size24.width,
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .localVerificationDataController,
                              label:
                                  StringConfig.reporting.localVerificationData,
                              hintText: StringConfig
                                  .database.enterLocalVerificationData,
                            ),
                          ),
                        ],
                      ),
                      SizeConfig.size34.height,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .packageNameController,
                              label: StringConfig.reporting.packageName,
                              hintText: StringConfig.database.enterPackageName,
                            ),
                          ),
                          SizeConfig.size24.width,
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .purchaseIDController,
                              label: StringConfig.reporting.purchaseId,
                              hintText: StringConfig.database.enterPurchaseId,
                            ),
                          ),
                        ],
                      ),
                      SizeConfig.size34.height,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .serverVerificationDataController,
                              label:
                                  StringConfig.reporting.serverVerificationData,
                              hintText: StringConfig
                                  .database.enterServerVerificationData,
                            ),
                          ),
                          SizeConfig.size24.width,
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .sourceController,
                              label: StringConfig.reporting.source,
                              hintText: StringConfig.database.enterSource,
                            ),
                          ),
                        ],
                      ),
                      SizeConfig.size34.height,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .subscriptionActivePlanController,
                              label:
                                  StringConfig.reporting.subscriptionActivePlan,
                              hintText: StringConfig
                                  .database.enterSubscriptionActivePlan,
                            ),
                          ),
                          SizeConfig.size24.width,
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .subscriptionPlatformController,
                              label:
                                  StringConfig.reporting.subscriptionPlatform,
                              hintText: StringConfig
                                  .database.enterSubscriptionPlatform,
                            ),
                          ),
                        ],
                      ),
                      SizeConfig.size34.height,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .transactionIDController,
                              label: StringConfig.reporting.transactionId,
                              hintText:
                                  StringConfig.database.enterTransactionId,
                            ),
                          ),
                          SizeConfig.size24.width,
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .subscriptionStatusController,
                              label: StringConfig.reporting.subscriptionStatus,
                              hintText:
                                  StringConfig.database.enterSubscriptionStatus,
                            ),
                          ),
                        ],
                      ),
                      SizeConfig.size34.height,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .subscriptionActivationTimestampController,
                              label: StringConfig
                                  .dashboard.mqsSubscriptionActivationDate,
                              hintText:
                                  StringConfig.database.enterActivationDate,
                              suffixIcon: ImageConfig.calendar,
                              readOnly: true,
                              validator: (p0) => Validator.emptyValidator(
                                  p0 ?? "",
                                  StringConfig
                                      .dashboard.mqsSubscriptionActivationDate
                                      .toLowerCase()),
                              onTap: () async {
                                userSubscriptionReceiptController.pickStartDateTime(
                                    context,
                                    userSubscriptionReceiptController
                                        .subscriptionActivationTimestampController);
                              },
                            ),
                          ),
                          SizeConfig.size24.width,
                          Expanded(
                            child: CustomTextField(
                              controller: userSubscriptionReceiptController
                                  .subscriptionExpiryTimestampController,
                              label: StringConfig
                                  .dashboard.mqsSubscriptionExpiryDate,
                              hintText: StringConfig.database.enterExpiryDate,
                              suffixIcon: ImageConfig.calendar,
                              readOnly: true,
                              validator: (p0) => Validator.emptyValidator(
                                  p0 ?? "",
                                  StringConfig
                                      .dashboard.mqsSubscriptionExpiryDate
                                      .toLowerCase()),
                              onTap: () async {
                                userSubscriptionReceiptController
                                    .pickExpiryDateTime(
                                        context,
                                        userSubscriptionReceiptController
                                            .subscriptionExpiryTimestampController);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizeConfig.size34.height,
                      if (userSubscriptionReceiptController.isEdit.value) ...[
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: userSubscriptionReceiptController
                                    .subscriptionRenewalController,
                                label: StringConfig
                                    .dashboard.mqsSubscriptionRenewalDate,
                                hintText:
                                    StringConfig.database.enterRenewalDate,
                                suffixIcon: ImageConfig.calendar,
                                readOnly: true,
                                onTap: () async {
                                  userSubscriptionReceiptController
                                      .pickRenewalDateTime(
                                          context,
                                          userSubscriptionReceiptController
                                              .subscriptionRenewalController);
                                },
                              ),
                            ),
                            SizeConfig.size24.width,
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                        SizeConfig.size34.height,
                      ],
                    ],
                  )
                : Column(
                    children: [
                      CustomTextField(
                        readOnly: userSubscriptionReceiptController.isEdit.value
                            ? true
                            : false,
                        controller: userSubscriptionReceiptController
                            .firebaseIdController,
                        label: StringConfig.reporting.firebaseUserId,
                        hintText: StringConfig.database.enterFirebaseUserId,
                        validator: (p0) => Validator.emptyValidator(
                            p0 ?? "",
                            StringConfig.reporting.firebaseUserId
                                .toLowerCase()),
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller: userSubscriptionReceiptController
                            .mONGODBUserIDController,
                        label: StringConfig.reporting.mongoDbUserId,
                        hintText: StringConfig.database.enterMongoDbUserId,
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller: userSubscriptionReceiptController
                            .appSpecificSharedSecretController,
                        label: StringConfig.reporting.appSpecificSharedSecret,
                        hintText:
                            StringConfig.database.enterAppSpecificSharedSecret,
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller: userSubscriptionReceiptController
                            .localVerificationDataController,
                        label: StringConfig.reporting.localVerificationData,
                        hintText:
                            StringConfig.database.enterLocalVerificationData,
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller: userSubscriptionReceiptController
                            .packageNameController,
                        label: StringConfig.reporting.packageName,
                        hintText: StringConfig.database.enterPackageName,
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller: userSubscriptionReceiptController
                            .purchaseIDController,
                        label: StringConfig.reporting.purchaseId,
                        hintText: StringConfig.database.enterPurchaseId,
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller: userSubscriptionReceiptController
                            .serverVerificationDataController,
                        label: StringConfig.reporting.serverVerificationData,
                        hintText:
                            StringConfig.database.enterServerVerificationData,
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller:
                            userSubscriptionReceiptController.sourceController,
                        label: StringConfig.reporting.source,
                        hintText: StringConfig.database.enterSource,
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller: userSubscriptionReceiptController
                            .subscriptionActivePlanController,
                        label: StringConfig.reporting.subscriptionActivePlan,
                        hintText:
                            StringConfig.database.enterSubscriptionActivePlan,
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller: userSubscriptionReceiptController
                            .subscriptionPlatformController,
                        label: StringConfig.reporting.subscriptionPlatform,
                        hintText:
                            StringConfig.database.enterSubscriptionPlatform,
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller: userSubscriptionReceiptController
                            .transactionIDController,
                        label: StringConfig.reporting.transactionId,
                        hintText: StringConfig.database.enterTransactionId,
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller: userSubscriptionReceiptController
                            .subscriptionStatusController,
                        label: StringConfig.reporting.subscriptionStatus,
                        hintText: StringConfig.database.enterSubscriptionStatus,
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller: userSubscriptionReceiptController
                            .subscriptionActivationTimestampController,
                        label: StringConfig
                            .dashboard.mqsSubscriptionActivationDate,
                        hintText: StringConfig.database.enterActivationDate,
                        suffixIcon: ImageConfig.calendar,
                        readOnly: true,
                        validator: (p0) => Validator.emptyValidator(
                            p0 ?? "",
                            StringConfig.dashboard.mqsSubscriptionActivationDate
                                .toLowerCase()),
                        onTap: () async {
                          userSubscriptionReceiptController.pickStartDateTime(
                              context,
                              userSubscriptionReceiptController
                                  .subscriptionActivationTimestampController);
                        },
                      ),
                      SizeConfig.size34.height,
                      CustomTextField(
                        controller: userSubscriptionReceiptController
                            .subscriptionExpiryTimestampController,
                        label: StringConfig.dashboard.mqsSubscriptionExpiryDate,
                        hintText: StringConfig.database.enterExpiryDate,
                        suffixIcon: ImageConfig.calendar,
                        readOnly: true,
                        validator: (p0) => Validator.emptyValidator(
                            p0 ?? "",
                            StringConfig.dashboard.mqsSubscriptionExpiryDate
                                .toLowerCase()),
                        onTap: () async {
                          userSubscriptionReceiptController.pickExpiryDateTime(
                              context,
                              userSubscriptionReceiptController
                                  .subscriptionExpiryTimestampController);
                        },
                      ),
                      SizeConfig.size34.height,
                      if (userSubscriptionReceiptController.isEdit.value) ...[
                        CustomTextField(
                          controller: userSubscriptionReceiptController
                              .subscriptionRenewalController,
                          label:
                              StringConfig.dashboard.mqsSubscriptionRenewalDate,
                          hintText: StringConfig.database.enterRenewalDate,
                          suffixIcon: ImageConfig.calendar,
                          readOnly: true,
                          onTap: () async {
                            userSubscriptionReceiptController
                                .pickRenewalDateTime(
                                    context,
                                    userSubscriptionReceiptController
                                        .subscriptionRenewalController);
                          },
                        ),
                        SizeConfig.size34.height,
                      ],
                    ],
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  onTap: () {
                    userSubscriptionReceiptController.isEdit.value = false;
                    userSubscriptionReceiptController.isAdd.value = false;
                    mqsDashboardController.userSubRecStatus.value = "";
                  },
                  isSelected: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size40),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size40),
                    child: Text(
                      userSubscriptionReceiptController.isEdit.value
                          ? StringConfig.dashboard.update
                          : StringConfig.dashboard.submit,
                      style: FontTextStyleConfig.buttonTextStyle
                          .copyWith(color: null),
                    ),
                  ),
                  onTap: () {
                    if (userSubRecFormKey.currentState?.validate() ?? false) {
                      userSubscriptionReceiptController.addUserSubRec();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
