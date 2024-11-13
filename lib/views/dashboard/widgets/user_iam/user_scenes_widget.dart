import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_row_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userScenesWidget({required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.scenesValue,
        isShowContent: dashboardController.showScenes.value,
      ).tap(() {
        dashboardController.showScenes.value =
            !dashboardController.showScenes.value;
      }),
      if (dashboardController.showScenes.value) ...[
        SizeConfig.size10.height,
        for (int i = 0; i < 4; i++)
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: SizeConfig.size12, horizontal: SizeConfig.size12),
            decoration: FontTextStyleConfig.detailBottomDecoration,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'SC000$i',
                        style: FontTextStyleConfig.tableBottomTextStyle
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(
                      dashboardController.sceneIndexes.contains(i)
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      color: ColorConfig.primaryColor,
                    ),
                  ],
                ),
                if (dashboardController.sceneIndexes.contains(i)) ...[
                  SizeConfig.size12.height,
                  keyValueRowWidget(
                    key: StringConfig.dashboard.mqsSceneID,
                    value: 'SC000$i',
                  ),
                  keyValueRowWidget(
                    key: StringConfig.dashboard.mqsSceneOptionGrScore,
                    value: '1',
                  ),
                  keyValueRowWidget(
                    key: StringConfig.dashboard.mqsSceneOptionText,
                    value:
                        'The Drift-Away Dinner: You taste the meal but and phone notifications keep pulling your focus away.',
                  ),
                  keyValueRowWidget(
                    key: StringConfig.dashboard.mqsSceneOptionWeight,
                    value: '2',
                  ),
                  keyValueRowWidget(
                    key: StringConfig.dashboard.mqsSceneStScore,
                    value: '1',
                  ),
                  keyValueRowWidget(
                    key: StringConfig.dashboard.mqsSceneStmt,
                    value:
                        'You are eating your favorite meal. How Present are you with the ?',
                  ),
                  keyValueRowWidget(
                    key: StringConfig.dashboard.mqsTimeStamp,
                    value: '2024-10-10T18:18:00.972307',
                  ),
                  keyValueRowWidget(
                    key: StringConfig.dashboard.mqsUserOBRegDate,
                    value: '2024-10-10T18:18:00.972307',
                  ),
                  keyValueRowWidget(
                    key: StringConfig.dashboard.mqsUserOBSceneScore,
                    value: '2',
                    bottomBorder: false,
                  ),
                ],
              ],
            ),
          ).tap(() {
            if (dashboardController.sceneIndexes.contains(i)) {
              dashboardController.sceneIndexes.remove(i);
            } else {
              dashboardController.sceneIndexes.add(i);
            }
          }),
      ],
    ],
  );
}
