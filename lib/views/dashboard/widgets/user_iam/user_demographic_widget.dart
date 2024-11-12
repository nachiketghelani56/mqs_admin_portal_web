import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDemographicWidget(
    {required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.demoGraphicValue,
        isShowContent: dashboardController.showDemographic.value,
      ).tap(() {
        dashboardController.showDemographic.value =
            !dashboardController.showDemographic.value;
      }),
      if (dashboardController.showDemographic.value) ...[
        SizeConfig.size10.height,
        Container(
          height: SizeConfig.size55,
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
          decoration: FontTextstyleConfig.headerDecoration,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  StringConfig.dashboard.currentSelectedAnswer,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                child: Text(
                  StringConfig.dashboard.selectedIndex,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
            ],
          ),
        ),
        for (int i = 0; i < 2; i++)
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: i == 1
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
                    'All I do is work',
                    style: FontTextstyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    '134',
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
