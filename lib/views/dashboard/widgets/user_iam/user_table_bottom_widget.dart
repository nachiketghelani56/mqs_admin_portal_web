import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';

Widget userTableBottomWidget(
    {required DashboardController dashboardController}) {
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
          '${StringConfig.dashboard.rowsPerPage} ${dashboardController.pageLimit}',
          style: FontTextStyleConfig.tableBottomTextStyle,
        ),
        SizeConfig.size5.width,
        const Spacer(),
        Text(
          '${dashboardController.offset.value + 1}-${dashboardController.getMaxOffset()} ${StringConfig.dashboard.of} ${dashboardController.searchedUsers.length}',
          style: FontTextStyleConfig.tableBottomTextStyle,
        ),
        SizeConfig.size20.width,
        IconButton(
          onPressed: () {
            dashboardController.prevPage();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: SizeConfig.size15,
            color: ColorConfig.textFieldTextColor,
          ),
        ),
        IconButton(
          onPressed: () {
            dashboardController.nextPage();
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
