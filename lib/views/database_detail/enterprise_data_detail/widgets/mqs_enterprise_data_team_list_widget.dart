import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget mqsEnterpriseDataTeamListWidget({required EnterpriseDataController enterpriseDataController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsTeamList,
        isShowContent: enterpriseDataController.showMqsTeamList.value,
      ).tap(() {
        enterpriseDataController.showMqsTeamList.value =
            !enterpriseDataController.showMqsTeamList.value;
      }),
      if (enterpriseDataController.showMqsTeamList.value) ...[
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
                  StringConfig.dashboard.teamName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Text(
                  StringConfig.dashboard.teamEmailAddress,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Text(
                  StringConfig.dashboard.teamMemberLimit,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Text(
                  StringConfig.dashboard.enable,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
            ],
          ),
        ),
        for (int i = 0;
            i < enterpriseDataController.enterpriseDetail.mqsTeamList.length;
            i++)
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: SizeConfig.size14, vertical: SizeConfig.size14),
            decoration:
                i == enterpriseDataController.enterpriseDetail.mqsTeamList.length - 1
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
                        .enterpriseDetail.mqsTeamList[i].mqsTeamName,
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    enterpriseDataController
                        .enterpriseDetail.mqsTeamList[i].mqsTeamEmail,
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    "${enterpriseDataController.enterpriseDetail.mqsTeamList[i].mqsTeamMembersLimit}",
                    style: FontTextStyleConfig.tableContentTextStyle,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    "${enterpriseDataController.enterpriseDetail.mqsTeamList[i].mqsIsEnable.toString().capitalize}",
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
