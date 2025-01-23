import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_drop_down.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addUserDataInformationWidget(
    {required UserDataController userDataController,
    required BuildContext context}) {
  return context.width > SizeConfig.size1500
      ? Column(
          children: [
            titleWidget(
              title: StringConfig.dashboard.userInformation,
              showArrowIcon: false,
            ),
            SizeConfig.size30.height,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    readOnly: userDataController.isEdit.value ? true : false,
                    controller: userDataController.userIdController,
                    label: StringConfig.dashboard.userId,
                    hintText: StringConfig.database.enterUserId,
                    validator: (p0) => Validator.emptyValidator(
                        p0 ?? "", StringConfig.dashboard.userId.toLowerCase()),
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomTextField(
                    controller: userDataController.mONGODBUserIDController,
                    label: StringConfig.dashboard.mongoDBUserID,
                    hintText: StringConfig.database.enterMongoDBUserID,
                  ),
                ),
              ],
            ),
            SizeConfig.size34.height,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: userDataController.firstNameController,
                    label: StringConfig.dashboard.firstName,
                    hintText: StringConfig.database.enterFirstName,
                    validator: (p0) => Validator.emptyValidator(p0 ?? "",
                        StringConfig.dashboard.firstName.toLowerCase()),
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomTextField(
                    controller: userDataController.lastNameController,
                    label: StringConfig.dashboard.lastName,
                    hintText: StringConfig.database.enterLastName,
                    validator: (p0) => Validator.emptyValidator(p0 ?? "",
                        StringConfig.dashboard.lastName.toLowerCase()),
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
                    controller: userDataController.emailController,
                    label: StringConfig.dashboard.email,
                    hintText: StringConfig.database.enterEmail,
                    validator: (p0) => Validator.emailValidator(
                        p0 ?? "", StringConfig.dashboard.email.toLowerCase()),
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomTextField(
                    controller: userDataController.appVersionController,
                    label: StringConfig.dashboard.appVersion,
                    hintText: StringConfig.database.enterAppVersion,
                  ),
                ),
              ],
            ),
            SizeConfig.size34.height,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: userDataController.registrationStatusController,
                    label: StringConfig.dashboard.registrationStatus,
                    hintText: StringConfig.database.enterRegistrationStatus,
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomTextField(
                    controller: userDataController.userLoginWithController,
                    label: StringConfig.dashboard.userLoginWith,
                    hintText: StringConfig.database.enterUserLoginWith,
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
                        userDataController.userActiveTimestampController,
                    label: StringConfig.database.userActiveTimestamp,
                    hintText: StringConfig.database.enterUserActiveTimestamp,
                    suffixIcon: ImageConfig.calendar,
                    readOnly: true,
                    // validator: (p0) => Validator.emptyValidator(
                    //     p0 ?? "",
                    //     StringConfig.dashboard.mqsSubscriptionActivationDate
                    //         .toLowerCase()),
                    onTap: () async {
                      userDataController.pickUserActivateDateTime(context,
                          userDataController.userActiveTimestampController);
                    },
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomTextField(
                    controller:
                        userDataController.enterpriseCreatedTimestampController,
                    label: StringConfig.database.enterpriseCreatedTimestamp,
                    hintText:
                        StringConfig.database.enterEnterpriseCreatedTimestamp,
                    suffixIcon: ImageConfig.calendar,
                    readOnly: true,
                    // validator: (p0) => Validator.emptyValidator(
                    //     p0 ?? "",
                    //     StringConfig.dashboard.mqsSubscriptionExpiryDate
                    //         .toLowerCase()),
                    onTap: () async {
                      userDataController.pickEnterpriseCreatedDateTime(
                          context,
                          userDataController
                              .enterpriseCreatedTimestampController);
                    },
                  ),
                ),
              ],
            ),
            SizeConfig.size34.height,
            Row(
              children: [
                Expanded(
                  child: CustomDropDown(
                    label: StringConfig.database.enterpriseUserFlag,
                    value: userDataController.enterpriseUserFlag.value,
                    items: userDataController.boolOptions,
                    onChanged: (value) {
                      userDataController.enterpriseUserFlag.value = value;
                    },
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(child: Container()),
              ],
            ),
          ],
        )
      : Column(
          children: [
            titleWidget(
              title: StringConfig.dashboard.userInformation,
              showArrowIcon: false,
            ),
            SizeConfig.size30.height,
            CustomTextField(
              controller: userDataController.userIdController,
              label: StringConfig.dashboard.userId,
              hintText: StringConfig.database.enterUserId,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.dashboard.userId.toLowerCase()),
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller: userDataController.mONGODBUserIDController,
              label: StringConfig.dashboard.mongoDBUserID,
              hintText: StringConfig.database.enterMongoDBUserID,
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller: userDataController.firstNameController,
              label: StringConfig.dashboard.firstName,
              hintText: StringConfig.database.enterFirstName,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.dashboard.firstName.toLowerCase()),
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller: userDataController.lastNameController,
              label: StringConfig.dashboard.lastName,
              hintText: StringConfig.database.enterLastName,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.dashboard.lastName.toLowerCase()),
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller: userDataController.emailController,
              label: StringConfig.dashboard.email,
              hintText: StringConfig.database.enterEmail,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.dashboard.email.toLowerCase()),
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller: userDataController.appVersionController,
              label: StringConfig.dashboard.appVersion,
              hintText: StringConfig.database.enterAppVersion,
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller: userDataController.registrationStatusController,
              label: StringConfig.dashboard.registrationStatus,
              hintText: StringConfig.database.enterRegistrationStatus,
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller: userDataController.userLoginWithController,
              label: StringConfig.dashboard.userLoginWith,
              hintText: StringConfig.database.enterUserLoginWith,
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller: userDataController.userActiveTimestampController,
              label: StringConfig.database.userActiveTimestamp,
              hintText: StringConfig.database.enterUserActiveTimestamp,
              suffixIcon: ImageConfig.calendar,
              readOnly: true,
              onTap: () async {
                userDataController.pickUserActivateDateTime(
                    context, userDataController.userActiveTimestampController);
              },
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller:
                  userDataController.enterpriseCreatedTimestampController,
              label: StringConfig.database.enterpriseCreatedTimestamp,
              hintText: StringConfig.database.enterEnterpriseCreatedTimestamp,
              suffixIcon: ImageConfig.calendar,
              readOnly: true,
              onTap: () async {
                userDataController.pickEnterpriseCreatedDateTime(context,
                    userDataController.enterpriseCreatedTimestampController);
              },
            ),
            SizeConfig.size34.height,
            CustomDropDown(
              label: StringConfig.database.enterpriseUserFlag,
              value: userDataController.enterpriseUserFlag.value,
              items: userDataController.boolOptions,
              onChanged: (value) {
                userDataController.enterpriseUserFlag.value = value;
              },
            ),
          ],
        );
}
