import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget mqsEnterpriseSubscriptionDetailWidget(
    {required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
          title: StringConfig.dashboard.mqsEnterpriseSubscriptionDetail,
          showArrowIcon: false),
      SizeConfig.size10.height,
      Container(
        height: SizeConfig.size55,
        padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
        decoration: FontTextStyleConfig.headerDecoration,
        child: Row(
          children: [
            Expanded(
              flex: SizeConfig.size3.toInt(),
              child: Text(
                StringConfig.dashboard.activePlan,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.status,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size3.toInt(),
              child: Text(
                StringConfig.dashboard.startDate,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size3.toInt(),
              child: Text(
                StringConfig.dashboard.expiryDate,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(
            horizontal: SizeConfig.size14, vertical: SizeConfig.size14),
        decoration: FontTextStyleConfig.contentDecoration.copyWith(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(SizeConfig.size12),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: SizeConfig.size3.toInt(),
              child: Text(
                dashboardController
                    .enterpriseDetail
                    .mqsEnterpriseSubscriptionDetails
                    .mqsSubscriptionActivePlan,
                style: FontTextStyleConfig.tableContentTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                dashboardController.enterpriseDetail
                    .mqsEnterpriseSubscriptionDetails.mqsSubscriptionStatus,
                style: FontTextStyleConfig.tableContentTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size3.toInt(),
              child: Text(
                dashboardController.dateConvert(dashboardController
                    .enterpriseDetail
                    .mqsEnterpriseSubscriptionDetails
                    .mqsSubscriptionStartDate),
                style: FontTextStyleConfig.tableContentTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size3.toInt(),
              child: Text(
                dashboardController.dateConvert(dashboardController
                    .enterpriseDetail
                    .mqsEnterpriseSubscriptionDetails
                    .mqsSubscriptionExpiryDate),
                style: FontTextStyleConfig.tableContentTextStyle,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
