import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/controller/user_subscription_receipt_controller.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/widgets/user_subscription_receipt_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/widgets/user_subscription_receipt_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/widgets/user_subscription_receipt_table_title_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/widgets/user_subscription_receipt_top_buttons_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

Widget userSubscriptionReceiptWidget({
  required BuildContext context,
  required UserSubscriptionReceiptController userSubscriptionReceiptController,
  required MqsDashboardController mqsDashboardController,
  required GlobalKey<ScaffoldState> scaffoldKey,
}) {
  return Obx(
    () => userSubscriptionReceiptController.userSubscriptionReceiptLoader.value
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
                        userSubscriptionReceiptTopButtonsWidget(
                          userSubscriptionReceiptController:
                              userSubscriptionReceiptController,
                          scaffoldKey: scaffoldKey,
                          context: context,
                          mqsDashboardController: mqsDashboardController,
                        ),
                        SizeConfig.size26.height,
                        userSubscriptionReceiptController
                                .searchedUserSubRec.isEmpty
                            ? Text(
                                StringConfig.dashboard.noDataFound,
                                style: FontTextStyleConfig.subtitleStyle,
                              ).center
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    userSubscriptionReceiptTableTitleWidget(
                                        context: context),
                                    for (int i =
                                            userSubscriptionReceiptController
                                                .offset.value;
                                        i <
                                            userSubscriptionReceiptController
                                                .getMaxOffset();
                                        i++)
                                      userSubscriptionReceiptTableRowWidget(
                                          isSelected: i ==
                                              userSubscriptionReceiptController
                                                  .viewIndex.value,
                                          mqsDashboardController:
                                              mqsDashboardController,
                                          context: context,
                                          index: i,
                                          userSubscriptionReceiptController:
                                              userSubscriptionReceiptController),
                                    userSubscriptionReceiptTableBottomWidget(
                                      userSubscriptionReceiptController:
                                          userSubscriptionReceiptController,
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ).paddingOnly(
            left: SizeConfig.size40,
            right: SizeConfig.size40,
            top: SizeConfig.size25,
          ),
  );
}
