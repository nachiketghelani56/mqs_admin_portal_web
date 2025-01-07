import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/controller/team_controller.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/team/team_detail_widget.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/team/team_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/team/team_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/database/widgets/team/team_table_title_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

Widget teamWidget({
  required BuildContext context,
  required TeamController teamController,
  required GlobalKey<ScaffoldState> scaffoldKey,
}) {
  return Obx(
    () => teamController.teamLoader.value
        ? const LoaderWidget()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: SizeConfig.size25),
                  child: Container(
                    decoration: FontTextStyleConfig.cardDecoration,
                    padding: const EdgeInsets.all(SizeConfig.size16),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              teamTableTitleWidget(context: context),
                              for (int i = teamController.offset.value;
                                  i < teamController.getMaxOffset();
                                  i++)
                                teamTableRowWidget(
                                    isSelected:
                                        i == teamController.viewIndex.value,
                                    context: context,
                                    index: i,
                                    teamController: teamController),
                              teamTableBottomWidget(
                                teamController: teamController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (context.width > SizeConfig.size1500 &&
                  teamController.team.isNotEmpty) ...[
                SizeConfig.size20.width,
                Expanded(
                  child: teamController.viewIndex.value >= 0
                      ? teamDetailWidget(teamController: teamController)
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ).paddingOnly(
            left: SizeConfig.size40,
            right: SizeConfig.size40,
            top: SizeConfig.size25,
          ),
  );
}
