import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/controller/team_controller.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget mqsTeamMemberDetailWidget({required TeamController teamController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.database.teamMemberDetails,
        isShowContent: teamController.showMqsTeamMemberDetail.value,
      ).tap(() {
        teamController.showMqsTeamMemberDetail.value =
            !teamController.showMqsTeamMemberDetail.value;
      }),
      if (teamController.showMqsTeamMemberDetail.value) ...[
        SizeConfig.size10.height,
        Container(
          height: SizeConfig.size55,
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
          decoration: FontTextStyleConfig.headerDecoration,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size15),
                  child: Text(
                    StringConfig.database.teamMemberID,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size15),
                  child: Text(
                    StringConfig.database.teamMemberName,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: SizeConfig.size15),
                  child: Text(
                    StringConfig.database.teamMemberEmail,
                    style: FontTextStyleConfig.tableBottomTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        for (int i = 0;
            i < (teamController.teamDetail.mqsTeamMemberDetails?.length ?? 0);
            i++)
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: SizeConfig.size14, vertical: SizeConfig.size14),
            decoration: i ==
                    (teamController.teamDetail.mqsTeamMemberDetails?.length ??
                            0) -
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
                  child: Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size15),
                    child: Text(
                      teamController.teamDetail.mqsTeamMemberDetails?[i]
                              .mqsTeamMemberID ??
                          "",
                      style: FontTextStyleConfig.tableContentTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size15),
                    child: Text(
                      teamController.teamDetail.mqsTeamMemberDetails?[i]
                              .mqsTeamMemberName ??
                          "",
                      style: FontTextStyleConfig.tableContentTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: SizeConfig.size15),
                    child: Text(
                      teamController.teamDetail.mqsTeamMemberDetails?[i]
                              .mqsTeamMemberEmail ??
                          "",
                      style: FontTextStyleConfig.tableContentTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ],
  );
}
