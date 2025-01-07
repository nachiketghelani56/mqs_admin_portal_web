import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/database/controller/user_subscription_receipt_controller.dart';

Widget userSubscriptionReceiptTableRowWidget({
  required DashboardController dashboardController,
  required UserSubscriptionReceiptController userSubscriptionReceiptController,
  required bool isSelected,
  required BuildContext context,
  required int index,
}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextStyleConfig.cardDecoration.copyWith(
      borderRadius: BorderRadius.circular(SizeConfig.size0),
      color: isSelected ? ColorConfig.bg2Color : null,
    ),
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Expanded(
          flex: SizeConfig.size4.toInt(),
          child: Padding(
            padding: const EdgeInsets.only(right: SizeConfig.size15),
            child: Text(
              dashboardController
                  .userSubscriptionReceipts[index].mqsFirebaseUserID,
              overflow: TextOverflow.ellipsis,
              style: FontTextStyleConfig.tableTextStyle,
            ),
          ),
        ),
        Expanded(
          flex: SizeConfig.size3.toInt(),
          child: Padding(
            padding: const EdgeInsets.only(right: SizeConfig.size15),
            child: Text(
              dashboardController
                  .userSubscriptionReceipts[index].mqsSubscriptionPlatform,
              overflow: TextOverflow.ellipsis,
              style: FontTextStyleConfig.tableTextStyle,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConfig.eyeOpened,
                height: SizeConfig.size24,
              ).tap(() {
                userSubscriptionReceiptController.viewIndex.value = index;
                if (context.width < SizeConfig.size1500) {
                  Get.toNamed(AppRoutes.userSubscriptionReceiptDetail);
                }
              }),
            ],
          ),
        ),
      ],
    ),
  );
}
