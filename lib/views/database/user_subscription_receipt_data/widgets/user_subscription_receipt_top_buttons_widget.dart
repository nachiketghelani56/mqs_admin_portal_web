import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/controller/user_subscription_receipt_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_icon_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_prefix_button.dart';
import 'package:mqs_admin_portal_web/widgets/search_text_field.dart';

Widget userSubscriptionReceiptTopButtonsWidget({
  required UserSubscriptionReceiptController userSubscriptionReceiptController,
  required MqsDashboardController mqsDashboardController,
  required GlobalKey<ScaffoldState> scaffoldKey,
  required BuildContext context,
}) {
  return context.width > SizeConfig.size1800
      ? Row(
          children: [
            CustomPrefixButton(
              prefixIcon: ImageConfig.filter,
              btnText: StringConfig.dashboard.filter,
              padding: SizeConfig.size15,
              onTap: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
            ),
            SizeConfig.size12.width,
            if (userSubscriptionReceiptController
                .userSubscriptionReceipts.isNotEmpty)
              SearchTextField(
                controller: userSubscriptionReceiptController.searchController,
                hintText: StringConfig.dashboard.searchByUserIdStatus,
                onChanged: (p0) {
                  userSubscriptionReceiptController.searchUserSubRec();
                },
              ),
            const Spacer(),
            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.import,
              onTap: () {
                userSubscriptionReceiptController.importUserSubRec();
              },
            ),
            SizeConfig.size12.width,
            if (userSubscriptionReceiptController
                .userSubscriptionReceipts.isNotEmpty)
              CustomIconButton(
                icon: ImageConfig.export,
                onTap: () {
                  userSubscriptionReceiptController.searchController.clear();
                  userSubscriptionReceiptController.exportUserSubRec();
                },
              ),
            SizeConfig.size12.width,
            CustomPrefixButton(
              prefixIcon: ImageConfig.add,
              padding: SizeConfig.size15,
              btnText: StringConfig.database.addReceipt,
              onTap: () {
                userSubscriptionReceiptController.isEdit.value = false;
                userSubscriptionReceiptController.isAdd.value = true;
                userSubscriptionReceiptController.clearAllFields();
                mqsDashboardController.userSubRecStatus.value =
                    "add_user_sub_rec";
              },
            ),
          ],
        )
      : Row(
          children: [
            CustomIconButton(
              icon: ImageConfig.filter,
              onTap: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
            ),
            SizeConfig.size12.width,
            if (userSubscriptionReceiptController
                .userSubscriptionReceipts.isNotEmpty)
              SearchTextField(
                controller: userSubscriptionReceiptController.searchController,
                hintText: StringConfig.dashboard.searchByUserIdStatus,
                onChanged: (p0) {
                  userSubscriptionReceiptController.searchUserSubRec();
                },
              ),
            const Spacer(),
            CustomIconButton(
              icon: ImageConfig.import,
              onTap: () {
                userSubscriptionReceiptController.importUserSubRec();
              },
            ),
            SizeConfig.size12.width,
            if (userSubscriptionReceiptController
                .userSubscriptionReceipts.isNotEmpty)
              CustomIconButton(
                icon: ImageConfig.export,
                onTap: () {
                  userSubscriptionReceiptController.searchController.clear();
                  userSubscriptionReceiptController.exportUserSubRec();
                },
              ),
            SizeConfig.size12.width,
            CustomIconButton(
              icon: ImageConfig.add,
              onTap: () {
                userSubscriptionReceiptController.isEdit.value = false;
                userSubscriptionReceiptController.isAdd.value = true;
                userSubscriptionReceiptController.clearAllFields();
                mqsDashboardController.userSubRecStatus.value =
                    "add_user_sub_rec";
              },
            ),
          ],
        );
}
