import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget userDataScenesWidget({required UserDataController userDataController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsScenesDetails,
        isShowContent: userDataController.showScenes.value,
      ).tap(() {
        userDataController.showScenes.value =
            !userDataController.showScenes.value;
      }),
      if (userDataController.showScenes.value) ...[
        SizeConfig.size10.height,
        for (int i = 0;
            i <
                (userDataController
                    .userDetail.mqsOnboardingDetails?.mqsScenesDetails?.length ?? 0);
            i++)
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: SizeConfig.size12, horizontal: SizeConfig.size12),
                decoration: !userDataController.sceneIndexes.contains(i)
                    ? FontTextStyleConfig.detailBottomDecoration
                    : null,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        userDataController.userDetail.mqsOnboardingDetails
                            ?.mqsScenesDetails?[i].mqsSceneID ?? '',
                        style: FontTextStyleConfig.tableBottomTextStyle
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(
                      userDataController.sceneIndexes.contains(i)
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      color: ColorConfig.primaryColor,
                    ),
                  ],
                ),
              ).tap(() {
                if (userDataController.sceneIndexes.contains(i)) {
                  userDataController.sceneIndexes.remove(i);
                } else {
                  userDataController.sceneIndexes.add(i);
                }
              }),
              if (userDataController.sceneIndexes.contains(i))
                Container(
                  padding: const EdgeInsets.only(bottom: SizeConfig.size12),
                  decoration: FontTextStyleConfig.detailBottomDecoration,
                  child: Column(
                    children: [
                      SizeConfig.size12.height,
                      keyValueWrapperWidget(
                        key: StringConfig.dashboard.mqsSceneID,
                        value: userDataController.userDetail.mqsOnboardingDetails
                            ?.mqsScenesDetails?[i].mqsSceneID ?? "",
                        isFirst: true,
                      ),
                      keyValueWrapperWidget(
                        key: StringConfig.dashboard.mqsSceneOptionGrScore,
                        value:
                            "${userDataController.userDetail.mqsOnboardingDetails?.mqsScenesDetails?[i].mqsSceneOptionGrScore}",
                      ),
                      keyValueWrapperWidget(
                        key: StringConfig.dashboard.mqsSceneOptionText,
                        value: userDataController.userDetail.mqsOnboardingDetails
                            ?.mqsScenesDetails?[i].mqsSceneOptionText ??"",
                      ),
                      keyValueWrapperWidget(
                        key: StringConfig.dashboard.mqsSceneOptionWeight,
                        value:
                            "${userDataController.userDetail.mqsOnboardingDetails?.mqsScenesDetails?[i].mqsSceneOptionWeight}",
                      ),
                      keyValueWrapperWidget(
                          key: StringConfig.dashboard.mqsSceneStScore,
                          value:
                              "${userDataController.userDetail.mqsOnboardingDetails?.mqsScenesDetails?[i].mqsSceneStScore}"),
                      keyValueWrapperWidget(
                          key: StringConfig.dashboard.mqsSceneStmt,
                          value: userDataController.userDetail.mqsOnboardingDetails
                              ?.mqsScenesDetails?[i].mqsSceneStmt ?? ""),
                      keyValueWrapperWidget(
                          key: StringConfig.dashboard.mqsTimeStamp,
                          value: userDataController.userDetail.mqsOnboardingDetails
                              ?.mqsScenesDetails?[i].mqsTimeStamp ??""),

                      keyValueWrapperWidget(
                        key: StringConfig.dashboard.mqsUserOBSceneScore,
                        value:
                            "${userDataController.userDetail.mqsOnboardingDetails?.mqsScenesDetails?[i].mqsUserOBScenesScore}",
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
