import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/controller/team_controller.dart';
import 'package:mqs_admin_portal_web/views/database_detail/widgets/team/mqs_team_member_detail_widget.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget teamDetailWidget({required TeamController teamController}) {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(bottom: SizeConfig.size24),
    child: Container(
      padding: const EdgeInsets.all(SizeConfig.size16),
      decoration: FontTextStyleConfig.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget(
            title: StringConfig.dashboard.team,
            showArrowIcon: false,
          ),
          SizeConfig.size10.height,
          keyValueWrapperWidget(
            key: StringConfig.dashboard.organizationID,
            value: teamController.teamDetail.mqsOrganizationID ?? '',
            isFirst: true,
          ),
          keyValueWrapperWidget(
            key: StringConfig.dashboard.teamID,
            value: teamController.teamDetail.mqsTeamID ?? '',
          ),
          keyValueWrapperWidget(
            key: StringConfig.dashboard.teamName,
            value: teamController.teamDetail.mqsTeamName ?? '',
          ),
          keyValueWrapperWidget(
            key: StringConfig.dashboard.teamEmailAddress,
            value: teamController.teamDetail.mqsTeamEmail ?? '',
          ),
          keyValueWrapperWidget(
            key: StringConfig.csv.createdTimestamp,
            value: teamController.teamDetail.mqsCreatedTimestamp?.isNotEmpty ??
                    false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(
                        teamController.teamDetail.mqsCreatedTimestamp ?? ""))
                : "",
          ),
          keyValueWrapperWidget(
            key: StringConfig.csv.updatedTimestamp,
            value: teamController.teamDetail.mqsUpdatedTimestamp?.isNotEmpty ??
                    false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(
                        teamController.teamDetail.mqsUpdatedTimestamp ?? ""))
                : "",
            isLast: true,
          ),
          if (teamController.teamDetail.mqsTeamMemberDetails?.isNotEmpty ??
              false) ...[
            SizeConfig.size34.height,
            mqsTeamMemberDetailWidget(teamController: teamController),
          ],
        ],
      ),
    ),
  );
}
