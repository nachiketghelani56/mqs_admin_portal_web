import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          decoration: FontTextStyleConfig.headerDecoration,
          child: Row(
            children: [
              Expanded(
                flex: SizeConfig.size4.toInt(),
                child: Text(
                  StringConfig.dashboard.email,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Text(
                  StringConfig.dashboard.mqsCommonLogin,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: Text(
                  StringConfig.dashboard.firstName,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: Text(
                  StringConfig.dashboard.isSignedUp,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size2.toInt(),
                child: Text(
                  StringConfig.dashboard.lastName,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
            ],
          ),
        ),
        for (int i = 0;
            i <
                dashboardController
                    .enterpriseDetail.mqsEmployeeEmailList.length;
            i++)
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: i ==
                    dashboardController
                            .enterpriseDetail.mqsEmployeeEmailList.length -
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
                  flex: SizeConfig.size4.toInt(),
                  child: Text(
                    dashboardController
                        .enterpriseDetail.mqsEmployeeEmailList[i].email,
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    "${dashboardController.enterpriseDetail.mqsEmployeeEmailList[i].mqsCommonLogin.toString().capitalize}",
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Text(
                    dashboardController
                        .enterpriseDetail.mqsEmployeeEmailList[i].firstname,
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Text(
                    "${dashboardController.enterpriseDetail.mqsEmployeeEmailList[i].isSignedUp.toString().capitalize}",
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size2.toInt(),
                  child: Text(
                    dashboardController
                        .enterpriseDetail.mqsEmployeeEmailList[i].lastname,
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
      ],
    ],
  );
}
