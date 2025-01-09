import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget mqsEnterpriseDataEmployeeEmailListWidget(
    {required EnterpriseDataController enterpriseDataController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsEmployeeEmailList,
        isShowContent: enterpriseDataController.showMqsEmpEmailList.value,
      ).tap(() {
        enterpriseDataController.showMqsEmpEmailList.value =
            !enterpriseDataController.showMqsEmpEmailList.value;
      }),
      if (enterpriseDataController.showMqsEmpEmailList.value) ...[
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
                  StringConfig.dashboard.employeeName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Text(
                  StringConfig.dashboard.emailAddress,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Text(
                  StringConfig.dashboard.mqsCommonLogin,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Text(
                  StringConfig.dashboard.signedUp,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
            ],
          ),
        ),
        for (int i = 0;
            i < enterpriseDataController.enterpriseDetail.mqsEmployeeList.length;
            i++)
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: SizeConfig.size14, vertical: SizeConfig.size14),
            decoration: i ==
                    enterpriseDataController
                            .enterpriseDetail.mqsEmployeeList.length -
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
                    enterpriseDataController
                        .enterpriseDetail.mqsEmployeeList[i].mqsEmployeeName,
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    enterpriseDataController
                        .enterpriseDetail.mqsEmployeeList[i].mqsEmployeeEmail,
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    "${enterpriseDataController.enterpriseDetail.mqsEmployeeList[i].mqsCommonLogin.toString().capitalize}",
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    "${enterpriseDataController.enterpriseDetail.mqsEmployeeList[i].mqsIsSignUp.toString().capitalize}",
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
