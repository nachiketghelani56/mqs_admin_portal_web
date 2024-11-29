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
          flex: SizeConfig.size3.toInt(),
          child: Text(
            dashboardController.searchedUsers[index].email,
            overflow: TextOverflow.ellipsis,
            style: FontTextStyleConfig.tableTextStyle,
          ),
        ),
        Expanded(
          flex: SizeConfig.size2.toInt(),
          child: Text(
            dashboardController.searchedUsers[index].userName,
            overflow: TextOverflow.ellipsis,
            style: FontTextStyleConfig.tableTextStyle,
          ),
        ),
        Expanded(
          flex: SizeConfig.size2.toInt(),
          child: Text(
            dashboardController.searchedUsers[index].loginWith,
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
                dashboardController.viewIndex.value = index;
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
