import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget mqsEnterpriseDataSubscriptionDetailWidget(
    {required EnterpriseDataController enterpriseDataController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsEnterpriseSubscriptionDetail,
        showArrowIcon: false,
      ),
      SizeConfig.size10.height,
      keyValueWrapperWidget(
        isFirst: true,
        key: StringConfig.dashboard.activePlan,
        value: enterpriseDataController.enterpriseDetail
            .mqsEnterpriseSubscriptionDetails.mqsSubscriptionActivePlan,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.status,
        value: enterpriseDataController.enterpriseDetail
            .mqsEnterpriseSubscriptionDetails.mqsSubscriptionStatus,
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.activationDate,
        value: enterpriseDataController.dateConvert(enterpriseDataController
            .enterpriseDetail
            .mqsEnterpriseSubscriptionDetails
            .mqsSubscriptionActivationTimestamp),
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.renewalDate,
        value: enterpriseDataController.dateConvert(enterpriseDataController
            .enterpriseDetail
            .mqsEnterpriseSubscriptionDetails
            .mqsSubscriptionRenewalDate),
      ),
      keyValueWrapperWidget(
        key: StringConfig.dashboard.expiryDate,
        value: enterpriseDataController.dateConvert(enterpriseDataController
            .enterpriseDetail
            .mqsEnterpriseSubscriptionDetails
            .mqsSubscriptionExpiryTimestamp),
        isLast: true,
      ),
    ],
  );
}
