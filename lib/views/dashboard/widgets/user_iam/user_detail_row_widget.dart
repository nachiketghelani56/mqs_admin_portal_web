import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';

Widget userDetailRowWidget({required DashboardController dashboardController}) {
  return Column(
    children: [
      keyValueWrapperWidget(
        key: StringConfig.dashboard.email,
        value: dashboardController.userDetail.mqsEmail,
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.firstName,
        value: dashboardController.userDetail.mqsFirstName,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.lastName,
        value: dashboardController.userDetail.mqsLastName,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.loginWith,
        value: dashboardController.userDetail.loginWith,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.userImage,
        value: dashboardController.userDetail.userImage,
        isImage: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.enterpriseUser,
        value:
            "${dashboardController.userDetail.mqsEnterpriseUserFlag.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.firebaseUserId,
        value: dashboardController.userDetail.mqsFirebaseUserID,
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.mongoDbUserId,
        value: dashboardController.userDetail.isMongoDBUserId,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.about,
        value: dashboardController.userDetail.about,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.aboutValue,
        value:
            "${dashboardController.userDetail.aboutValue.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.country,
        value: dashboardController.userDetail.country,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.countryValue,
        value:
            "${dashboardController.userDetail.countryValue.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.pronouns,
        value: dashboardController.userDetail.pronouns,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.pronounsValue,
        value:
            "${dashboardController.userDetail.pronounsValue.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.skipOnboarding,
        value:
            "${dashboardController.userDetail.mqsSkipOnboarding.toString().capitalize}",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.userActiveTimestamp,
        value: dashboardController.userDetail.mqsUserActiveTimestamp.isNotEmpty
            ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                DateTime.parse(
                    dashboardController.userDetail.mqsUserActiveTimestamp))
            : "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.registrationStatus,
        value: dashboardController.userDetail.mqsRegistrationStatus,
        isLast: true,
      ),
    ],
  );
}
