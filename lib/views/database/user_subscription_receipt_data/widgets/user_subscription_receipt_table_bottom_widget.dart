import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/controller/user_subscription_receipt_controller.dart';

Widget userSubscriptionReceiptTableBottomWidget({
  required UserSubscriptionReceiptController userSubscriptionReceiptController,
}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextStyleConfig.tableBottomDecoration.copyWith(
      border: Border(
        bottom: BorderSide.none,
        top: BorderSide(
            color: ColorConfig.labelColor.withOpacity(SizeConfig.size0point4)),
        left: BorderSide.none,
        right: BorderSide.none,
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Text(
          '${StringConfig.dashboard.rowsPerPage} ${userSubscriptionReceiptController.pageLimit}',
          style: FontTextStyleConfig.tableBottomTextStyle,
        ),
        SizeConfig.size5.width,
        const Spacer(),
        Text(
          '${userSubscriptionReceiptController.offset.value + 1}-${userSubscriptionReceiptController.getMaxOffset()} ${StringConfig.dashboard.of} ${userSubscriptionReceiptController.userSubscriptionReceipts.length}',
          style: FontTextStyleConfig.tableBottomTextStyle,
        ),
        SizeConfig.size20.width,
        IconButton(
          onPressed: () {
            userSubscriptionReceiptController.prevPage();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: SizeConfig.size15,
            color: ColorConfig.textFieldTextColor,
          ),
        ),
        IconButton(
          onPressed: () {
            userSubscriptionReceiptController.nextPage();
          },
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: SizeConfig.size15,
            color: ColorConfig.textFieldTextColor,
          ),
        ),
      ],
    ),
  );
}
