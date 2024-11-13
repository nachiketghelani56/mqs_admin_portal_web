import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';

Widget userTableRowWidget({
  required DashboardController dashboardController,
  required bool isSelected,
  required BuildContext context,
}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextStyleConfig.tableRowDecoration.copyWith(
      color: isSelected ? ColorConfig.bg2Color : null,
    ),
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        if (context.width > SizeConfig.size900)
          Expanded(
            flex: SizeConfig.size3.toInt(),
            child: const Text(
              "OF9AA3ZAGFY635nBF6739FGb",
              overflow: TextOverflow.ellipsis,
              style: FontTextStyleConfig.tableTextStyle,
            ),
          ),
        const Expanded(
          child: Text(
            "Test Board",
            overflow: TextOverflow.ellipsis,
            style: FontTextStyleConfig.tableTextStyle,
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
                if (context.width < SizeConfig.size1500) {
                  Get.toNamed(AppRoutes.userIAMDetail);
                }
              }),
            ],
          ),
        ),
      ],
    ),
  );
}
