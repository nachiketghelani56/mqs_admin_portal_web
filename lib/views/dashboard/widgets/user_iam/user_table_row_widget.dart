import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';

Widget userTableRowWidget({
  required DashboardController dashboardController,
  required bool isSelected,
  required BuildContext context,
}) {
  return Container(
    height: SizeConfig.size76,
    decoration: FontTextstyleConfig.tableRowDecoration.copyWith(
      color: isSelected ? ColorConfig.bg2Color : null,
    ),
    padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size26),
    child: Row(
      children: [
        Expanded(
          flex: SizeConfig.size3.toInt(),
          child: const Text(
            "OF9AA3ZAGFY635nBF6739FGb",
            overflow: TextOverflow.ellipsis,
            style: FontTextstyleConfig.tableTextStyle,
          ),
        ),
        const Expanded(
          child: Text(
            "Test Board",
            overflow: TextOverflow.ellipsis,
            style: FontTextstyleConfig.tableTextStyle,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConfig.eyeOpened,
                height: SizeConfig.size24,
              ).tap(() {}),
            ],
          ),
        ),
      ],
    ),
  );
}
