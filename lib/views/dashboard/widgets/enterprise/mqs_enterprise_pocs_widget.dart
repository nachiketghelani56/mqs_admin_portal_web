import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
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
      Container(
        height: SizeConfig.size55,
        padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
        decoration: FontTextStyleConfig.headerDecoration,
        child: Row(
          children: [
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.name,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size4.toInt(),
              child: Text(
                dashboardController
                    .enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseName,
                style: FontTextStyleConfig.tableContentTextStyle,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: SizeConfig.size55,
        padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
        decoration: FontTextStyleConfig.contentDecoration,
        child: Row(
          children: [
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.email,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size4.toInt(),
              child: Text(
                dashboardController
                    .enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseEmail,
                style: FontTextStyleConfig.tableContentTextStyle,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: SizeConfig.size55,
        padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
        decoration: FontTextStyleConfig.contentDecoration,
        child: Row(
          children: [
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.address,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size4.toInt(),
              child: Text(
                dashboardController
                    .enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseAddress,
                style: FontTextStyleConfig.tableContentTextStyle,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: SizeConfig.size55,
        padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
        decoration: FontTextStyleConfig.contentDecoration,
        child: Row(
          children: [
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.phoneNumber,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size4.toInt(),
              child: Text(
                dashboardController.enterpriseDetail.mqsEnterprisePOCs
                    .mqsEnterprisePhoneNumber,
                style: FontTextStyleConfig.tableContentTextStyle,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: SizeConfig.size55,
        padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
        decoration: FontTextStyleConfig.contentDecoration,
        child: Row(
          children: [
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.type,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size4.toInt(),
              child: Text(
                dashboardController
                    .enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseType,
                style: FontTextStyleConfig.tableContentTextStyle,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: SizeConfig.size55,
        padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
        decoration: FontTextStyleConfig.contentDecoration,
        child: Row(
          children: [
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.website,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size4.toInt(),
              child: Text(
                dashboardController
                    .enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseWebsite,
                style: FontTextStyleConfig.tableContentTextStyle,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: SizeConfig.size55,
        padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
        decoration: FontTextStyleConfig.contentDecoration,
        child: Row(
          children: [
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.pinCodeText,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size4.toInt(),
              child: Text(
                dashboardController
                    .enterpriseDetail.mqsEnterprisePOCs.mqsEnterprisePincode,
                style: FontTextStyleConfig.tableContentTextStyle,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: SizeConfig.size55,
        padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
        decoration: FontTextStyleConfig.contentDecoration.copyWith(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(SizeConfig.size12),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                StringConfig.dashboard.signedUp,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
              flex: SizeConfig.size4.toInt(),
              child: Text(
                "${dashboardController.enterpriseDetail.mqsEnterprisePOCs.mqsIsSignUp.toString().capitalize}",
                style: FontTextStyleConfig.tableContentTextStyle,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
