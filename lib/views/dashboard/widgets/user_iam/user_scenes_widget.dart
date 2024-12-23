import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
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
        for (int i = 0;
            i <
                dashboardController
                    .userDetail.onboardingModel.scenesValue.length;
            i++)
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: SizeConfig.size12, horizontal: SizeConfig.size12),
                decoration: !dashboardController.sceneIndexes.contains(i)
                    ? FontTextStyleConfig.detailBottomDecoration
                    : null,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        dashboardController.userDetail.onboardingModel
                            .scenesValue[i].mqsSceneID,
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
              ).tap(() {
                if (dashboardController.sceneIndexes.contains(i)) {
                  dashboardController.sceneIndexes.remove(i);
                } else {
                  dashboardController.sceneIndexes.add(i);
                }
              }),
              if (dashboardController.sceneIndexes.contains(i))
                Container(
                  padding: const EdgeInsets.only(bottom: SizeConfig.size12),
                  decoration: FontTextStyleConfig.detailBottomDecoration,
                  child: Column(
                    children: [
                      SizeConfig.size12.height,
                      keyValueWrapperWidget(
                        key: StringConfig.dashboard.mqsSceneID,
                        value: dashboardController.userDetail.onboardingModel
                            .scenesValue[i].mqsSceneID,
                        isFirst: true,
                      ),
                      keyValueWrapperWidget(
                        key: StringConfig.dashboard.mqsSceneOptionGrScore,
                        value:
                            "${dashboardController.userDetail.onboardingModel.scenesValue[i].mqsSceneOptionGrScore}",
                      ),
                      keyValueWrapperWidget(
                        key: StringConfig.dashboard.mqsSceneOptionText,
                        value: dashboardController.userDetail.onboardingModel
                            .scenesValue[i].mqsSceneOptionText,
                      ),
                      keyValueWrapperWidget(
                        key: StringConfig.dashboard.mqsSceneOptionWeight,
                        value:
                            "${dashboardController.userDetail.onboardingModel.scenesValue[i].mqsSceneOptionWeight}",
                      ),
                      keyValueWrapperWidget(
                          key: StringConfig.dashboard.mqsSceneStScore,
                          value:
                              "${dashboardController.userDetail.onboardingModel.scenesValue[i].mqsSceneStScore}"),
                      keyValueWrapperWidget(
                          key: StringConfig.dashboard.mqsSceneStmt,
                          value: dashboardController.userDetail.onboardingModel
                              .scenesValue[i].mqsSceneStmt),
                      keyValueWrapperWidget(
                          key: StringConfig.dashboard.mqsTimeStamp,
                          value: dashboardController.userDetail.onboardingModel
                              .scenesValue[i].mqsTimeStamp),
                      keyValueWrapperWidget(
                          key: StringConfig.dashboard.mqsUserOBRegDate,
                          value: dashboardController.userDetail.onboardingModel
                              .scenesValue[i].mqsUserOBRegDate),
                      keyValueWrapperWidget(
                        key: StringConfig.dashboard.mqsUserOBSceneScore,
                        value:
                            "${dashboardController.userDetail.onboardingModel.scenesValue[i].mqsUserOBScenesScore}",
                        isLast: true,
                      ),
                    ],
                  ),
                ),
            ],
          ),
      ],
    ],
  );
}
