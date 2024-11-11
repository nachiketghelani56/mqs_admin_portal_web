import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget mqsEnterprisePOCsWidget(
    {required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsEnterprisePOCs,
        isShowContent: dashboardController.showMqsEnterprisePOCs.value,
      ).tap(() {
        dashboardController.showMqsEnterprisePOCs.value =
            !dashboardController.showMqsEnterprisePOCs.value;
      }),
      if (dashboardController.showMqsEnterprisePOCs.value) ...[
        SizeConfig.size10.height,
        Container(
          height: SizeConfig.size55,
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
          decoration: FontTextstyleConfig.headerDecoration,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  StringConfig.dashboard.address,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  StringConfig.dashboard.email,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  StringConfig.dashboard.name,
                  style: FontTextstyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  StringConfig.dashboard.phoneNumber,
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
                  flex: 3,
                  child: Text(
                    'Test',
                    style: FontTextstyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'testuser546@gmail.com',
                    style: FontTextstyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Test User',
                    style: FontTextstyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '6584536243',
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
