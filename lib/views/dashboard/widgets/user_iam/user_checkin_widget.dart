import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userCheckInWidget({required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.checkINValue,
        isShowContent: dashboardController.showCheckIn.value,
      ).tap(() {
        dashboardController.showCheckIn.value =
            !dashboardController.showCheckIn.value;
      }),
      if (dashboardController.showCheckIn.value) ...[
        SizeConfig.size10.height,
        Container(
          height: SizeConfig.size55,
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
          decoration: FontTextstyleConfig.headerDecoration,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  StringConfig.dashboard.checkInScore,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                child: Text(
                  StringConfig.dashboard.id,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                child: Text(
                  StringConfig.dashboard.mqsCINValue,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                child: Text(
                  StringConfig.dashboard.mqsTimeStamp,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
            ],
          ),
        ),
        for (int i = 0; i < 4; i++)
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: i == 3
                ? FontTextstyleConfig.contentDecoration.copyWith(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(SizeConfig.size12),
                    ),
                  )
                : FontTextstyleConfig.contentDecoration,
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    '0.54897R979R99',
                    style: FontTextstyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    'CIN0005',
                    style: FontTextstyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    '0.54897R979R99',
                    style: FontTextstyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    '2024-11-10',
                    style: FontTextstyleConfig.tableContentTextStyle,
                  ),
                ),
              ],
            ),
          ),
      ],
    ],
  );
}
