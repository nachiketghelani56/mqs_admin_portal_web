import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/widgets/user_data_table_bottom_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/widgets/user_data_table_row_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/widgets/user_data_table_title_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/widgets/user_data_top_buttons_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

Widget userDataWidget(
    {required UserDataController userDataController,
    required MqsDashboardController mqsDashboardController,
    required BuildContext context}) {
  return userDataController.userLoader.value
      ? const LoaderWidget()
      : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: SizeConfig.size25),
                child: Container(
                  decoration: userDataController.users.isNotEmpty
                      ? FontTextStyleConfig.cardDecoration
                      : null,
                  padding: const EdgeInsets.all(SizeConfig.size16),
                  child: Column(
                    children: [
                      userDataTopButtonsWidget(
                        userDataController: userDataController,
                        context: context,
                        mqsDashboardController: mqsDashboardController,
                      ),
                      SizeConfig.size26.height,
                      userDataController.searchedUsers.isEmpty
                          ? Text(
                              StringConfig.dashboard.noDataFound,
                              style: FontTextStyleConfig.subtitleStyle,
                            ).center
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  userDataTableTitleWidget(context: context),
                                  for (int i = userDataController.offset.value;
                                      i < userDataController.getMaxOffset();
                                      i++)
                                    userDataTableRowWidget(
                                      isSelected: i ==
                                          userDataController.viewIndex.value,
                                      userDataController: userDataController,
                                      mqsDashboardController:
                                          mqsDashboardController,
                                      context: context,
                                      index: i,
                                    ),
                                  userDataTableBottomWidget(
                                      userDataController: userDataController),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        );
}
