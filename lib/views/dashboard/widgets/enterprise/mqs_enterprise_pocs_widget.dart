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
          decoration: FontTextStyleConfig.headerDecoration,
          child: Row(
            children: [
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Text(
                  StringConfig.dashboard.address,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Text(
                  StringConfig.dashboard.email,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: Text(
                  StringConfig.dashboard.name,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: Text(
                  StringConfig.dashboard.phoneNumber,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
            ],
          ),
        ),
        for (int i = 0;
            i < dashboardController.enterpriseDetail.mqsEnterprisePOCs.length;
            i++)
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: i ==
                    dashboardController
                            .enterpriseDetail.mqsEnterprisePOCs.length -
                        1
                ? FontTextStyleConfig.contentDecoration.copyWith(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(SizeConfig.size12),
                    ),
                  )
                : FontTextStyleConfig.contentDecoration,
            child: Row(
              children: [
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    dashboardController
                        .enterpriseDetail.mqsEnterprisePOCs[i].address,
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    dashboardController
                        .enterpriseDetail.mqsEnterprisePOCs[i].email,
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Text(
                    dashboardController
                        .enterpriseDetail.mqsEnterprisePOCs[i].name,
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Text(
                    dashboardController
                        .enterpriseDetail.mqsEnterprisePOCs[i].phoneNumber,
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
              ],
            ),
          ),
      ],
    ],
  );
}
