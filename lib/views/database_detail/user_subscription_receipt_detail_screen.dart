import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/database/controller/user_subscription_receipt_controller.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/user_subscription_receipt/user_subscription_receipt_detail_widget.dart';

class UserSubscriptionReceiptDetailScreen extends StatelessWidget {
  UserSubscriptionReceiptDetailScreen({super.key});

  final UserSubscriptionReceiptController _userSubscriptionReceiptController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.width > SizeConfig.size600
            ? SizeConfig.size50
            : SizeConfig.size15),
        child: Obx(
              () => userSubscriptionReceiptDetailWidget(userSubscriptionReceiptController: _userSubscriptionReceiptController),
        ),
      ),
    );
  }
}
