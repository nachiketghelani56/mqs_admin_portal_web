import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';

Widget userDataDetailRowWidget({required UserDataController userDataController}) {
  return Column(
    children: [
      keyValueWrapperWidget(
        key: StringConfig.dashboard.userId,
        value: userDataController.userDetail.mqsUserID ?? "",
        isFirst: true,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.email,
        value: userDataController.userDetail.mqsEmail ?? "",

      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.firstName,
        value: userDataController.userDetail.mqsFirstName ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.lastName,
        value: userDataController.userDetail.mqsLastName ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.appVersion,
        value: userDataController.userDetail.mqsAppVersion ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.reporting.enterpriseUser,
        value:
            "${userDataController.userDetail.mqsEnterpriseUserFlag.toString().capitalize}",
      ),

      keyValueWrapperWidget(
        key: StringConfig.dashboard.registrationStatus,
        value: userDataController.userDetail.mqsRegistrationStatus ?? "",
      ),

      keyValueWrapperWidget(
        key: StringConfig.reporting.mongoDbUserId,
        value: userDataController.userDetail.mqsMONGODBUserID ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.loginWith,
        value: userDataController.userDetail.mqsUserLoginWith ?? "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.userActiveTimestamp,
        value:
            userDataController.userDetail.mqsUserActiveTimestamp?.isNotEmpty ??
                    false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(
                        userDataController.userDetail.mqsUserActiveTimestamp ??
                            ""))
                : "",
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.enterpriseCreatedTimestamp,
        value: userDataController
                    .userDetail.mqsEnterpriseCreatedTimestamp?.isNotEmpty ??
                false
            ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                DateTime.parse(userDataController
                        .userDetail.mqsEnterpriseCreatedTimestamp ??
                    ""))
            : "",
        isLast: true,
      ),
    ],
  );
}
