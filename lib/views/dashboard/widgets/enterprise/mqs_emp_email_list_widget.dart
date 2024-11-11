import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget mqsEmployeeEmailListWidget(
    {required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsEmployeeEmailList,
        isShowContent: dashboardController.showMqsEmpEmailList.value,
      ).tap(() {
        dashboardController.showMqsEmpEmailList.value =
            !dashboardController.showMqsEmpEmailList.value;
      }),
      if (dashboardController.showMqsEmpEmailList.value) ...[
        SizeConfig.size10.height,
        Container(
          height: SizeConfig.size55,
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
          decoration: FontTextstyleConfig.headerDecoration,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  StringConfig.dashboard.email,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  StringConfig.dashboard.mqsCommonLogin,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  StringConfig.dashboard.firstName,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  StringConfig.dashboard.isSignedUp,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  StringConfig.dashboard.lastName,
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
                  flex: 4,
                  child: Text(
                    'testuser546@gmail.com',
                    style: FontTextstyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'True',
                    style: FontTextstyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Team',
                    style: FontTextstyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'True',
                    style: FontTextstyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Board',
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
