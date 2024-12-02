import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_row_widget.dart';

Widget userDetailRowWidget({required DashboardController dashboardController}) {
  return Column(
    children: [
      keyValueRowWidget(
        key: StringConfig.dashboard.email,
        value: dashboardController.userDetail.email,
        isFirst: true,
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.firstName,
        value: dashboardController.userDetail.firstName,
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.lastName,
        value: dashboardController.userDetail.lastName,
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.loginWith,
        value: dashboardController.userDetail.loginWith,
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.userImage,
        value: dashboardController.userDetail.userImage,
      ),
      keyValueRowWidget(
        key: StringConfig.reporting.enterpriseUser,
        value:
            "${dashboardController.userDetail.isEnterpriseUser.toString().capitalize}",
      ),
      keyValueRowWidget(
        key: StringConfig.reporting.firebaseUserId,
        value: dashboardController.userDetail.isFirebaseUserId,
      ),
      keyValueRowWidget(
        key: StringConfig.reporting.mongoDbUserId,
        value: dashboardController.userDetail.isMongoDBUserId,
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.about,
        value: dashboardController.userDetail.about,
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.aboutValue,
        value:
            "${dashboardController.userDetail.aboutValue.toString().capitalize}",
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.country,
        value: dashboardController.userDetail.country,
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.countryValue,
        value:
            "${dashboardController.userDetail.countryValue.toString().capitalize}",
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.pronouns,
        value: dashboardController.userDetail.pronouns,
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.pronounsValue,
        value:
            "${dashboardController.userDetail.pronounsValue.toString().capitalize}",
      ),
      keyValueRowWidget(
        key: StringConfig.dashboard.isRegister,
        value: dashboardController.userDetail.isRegister,
        isLast: true,
      ),
    ],
  );
}
