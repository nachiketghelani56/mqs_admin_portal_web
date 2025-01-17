import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/controller/user_subscription_receipt_controller.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/widgets/add_user_subscription_receipt_widget.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/header_database_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/controller/home_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/widgets/home_header_widget.dart';

class AddUserSubscriptionReceiptScreen extends StatelessWidget {
  AddUserSubscriptionReceiptScreen({super.key, this.scaffoldKey});

  final DashboardController _dashboardController =
      Get.put(DashboardController());
  final MqsDashboardController _mqsDashboardController =
      Get.put(MqsDashboardController());
  final HomeController _homeController = Get.put(HomeController());
  final UserSubscriptionReceiptController _userSubscriptionReceiptController =
      Get.put(UserSubscriptionReceiptController());
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        homeHeaderWidget(
          homeController: _homeController,
          context: context,
          scaffoldKey: scaffoldKey as GlobalKey<ScaffoldState>,
        ),
        SizeConfig.size25.height,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size40),
          child: headerDatabaseWidget(
            title: _userSubscriptionReceiptController.isEdit.value
                ? StringConfig.database.editSubscriptionReceipt
                : StringConfig.database.addSubscriptionReceipt,
            mqsDashboardController: _mqsDashboardController,
            dashboardController: _dashboardController,
            index: 6,
            subTitle: StringConfig.database.subscriptionReceipt,
          ),
        ),
        SizeConfig.size25.height,
        Expanded(
          child: Obx(
            () {
              return Padding(
                padding: const EdgeInsets.only(
                    left: SizeConfig.size40,
                    right: SizeConfig.size40,
                    bottom: SizeConfig.size25),
                child: addUserSubscriptionReceiptWidget(
                    userSubscriptionReceiptController:
                        _userSubscriptionReceiptController,
                    mqsDashboardController: _mqsDashboardController,
                    context: context),
              );
            },
          ),
        )
      ],
    );
  }
}
