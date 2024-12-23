import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget mqsEnterprisePOCsWidget(
    {required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsEnterprisePOCs,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        isFirst: true,
        key: StringConfig.dashboard.name,
        value: dashboardController
            .enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseName,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.email,
        value: dashboardController
            .enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseEmail,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.address,
        value: dashboardController
            .enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseAddress,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.phoneNumber,
        value: dashboardController
            .enterpriseDetail.mqsEnterprisePOCs.mqsEnterprisePhoneNumber,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.type,
        value: dashboardController
            .enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseType,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.website,
        value: dashboardController
            .enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseWebsite,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.pinCodeText,
        value: dashboardController
            .enterpriseDetail.mqsEnterprisePOCs.mqsEnterprisePincode,
      ),
      keyValueWrapperWidget(
        isLast: true,
        key: StringConfig.dashboard.signedUp,
        value:
            "${dashboardController.enterpriseDetail.mqsEnterprisePOCs.mqsIsSignUp.toString().capitalize}",
      ),
    ],
  );
}
