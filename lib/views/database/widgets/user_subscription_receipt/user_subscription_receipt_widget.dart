import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/database/controller/user_subscription_receipt_controller.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/user_subscription_receipt/user_subscription_receipt_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/user_subscription_receipt/user_subscription_receipt_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/user_subscription_receipt/user_subscription_receipt_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/user_subscription_receipt/user_subscription_receipt_table_title_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

Widget userSubscriptionReceiptWidget({
  required BuildContext context,
  required DashboardController dashboardController,
  required UserSubscriptionReceiptController userSubscriptionReceiptController,
  required GlobalKey<ScaffoldState> scaffoldKey,
}) {
  return Obx(
    () => dashboardController.userSubscriptionReceiptLoader.value
        ? const LoaderWidget()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: SizeConfig.size25),
                  child: Container(
                    decoration: FontTextStyleConfig.cardDecoration,
                    padding: const EdgeInsets.all(SizeConfig.size16),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              userSubscriptionReceiptTableTitleWidget(
                                  context: context),
                              for (int i = userSubscriptionReceiptController
                                      .offset.value;
                                  i <
                                      userSubscriptionReceiptController
                                          .getMaxOffset();
                                  i++)
                                userSubscriptionReceiptTableRowWidget(
                                    isSelected: i ==
                                        userSubscriptionReceiptController
                                            .viewIndex.value,
                                    dashboardController: dashboardController,
                                    context: context,
                                    index: i,
                                    userSubscriptionReceiptController:
                                        userSubscriptionReceiptController),
                              userSubscriptionReceiptTableBottomWidget(
                                  userSubscriptionReceiptController:
                                      userSubscriptionReceiptController,
                                  dashboardController: dashboardController),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (context.width > SizeConfig.size1500 &&
                  dashboardController.userSubscriptionReceipts.isNotEmpty) ...[
                SizeConfig.size20.width,
                Expanded(
                  child: userSubscriptionReceiptController.viewIndex.value >= 0
                      ? userSubscriptionReceiptDetailWidget(
                          userSubscriptionReceiptController:
                              userSubscriptionReceiptController)
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ).paddingOnly(
            left: SizeConfig.size40,
            right: SizeConfig.size40,
            top: SizeConfig.size25,
          ),
  );
}
