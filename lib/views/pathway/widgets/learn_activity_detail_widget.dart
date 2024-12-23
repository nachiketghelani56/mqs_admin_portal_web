import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';

Widget? learnActivityDetailWidget(
    {required PathwayController pathwayController, required int index}) {
  if (pathwayController.showLearnActivty.value) {
    return Column(
      children: [
        for (int j = 0;
            j < pathwayController.modules[index].mqsLearnActivity.length;
            j++)
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: SizeConfig.size12),
                decoration: FontTextStyleConfig.detailBottomDecoration,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        pathwayController.modules[index].mqsLearnActivity[j].id,
                        style: FontTextStyleConfig.tableContentTextStyle,
                      ),
                    ),
                    Icon(
                      pathwayController.learnActIndex.value == j
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      color: ColorConfig.primaryColor,
                    ),
                  ],
                ),
              ).tap(() {
                if (pathwayController.learnActIndex.value == j) {
                  pathwayController.learnActIndex.value = -1;
                } else {
                  pathwayController.learnActIndex.value = j;
                }
              }),
              if (pathwayController.learnActIndex.value == j) ...[
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityTitle,
                  value: pathwayController
                      .modules[index].mqsLearnActivity[j].mqsActivityTitle,
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activtyRefID,
                  value: pathwayController
                      .modules[index].mqsLearnActivity[j].mqsActivityRefID,
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityScreenHandoff,
                  value:
                      "${pathwayController.modules[index].mqsLearnActivity[j].mqsActivityScreenHandoff}",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activitySkills,
                  value: pathwayController
                      .modules[index].mqsLearnActivity[j].mqsActivitySkill
                      .join(", "),
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.navigateToScreen,
                  value: pathwayController
                      .modules[index].mqsLearnActivity[j].mqsNavigateToScreen,
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityStatus,
                  value:
                      "${pathwayController.modules[index].mqsLearnActivity[j].mqsActivityStatus}",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.completionDate,
                  value: pathwayController.modules[index].mqsLearnActivity[j]
                          .mqsActivityCompletionDate.isNotEmpty
                      ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                          DateTime.parse(pathwayController.modules[index]
                              .mqsLearnActivity[j].mqsActivityCompletionDate))
                      : pathwayController.modules[index].mqsLearnActivity[j]
                          .mqsActivityCompletionDate,
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.addToFav,
                  value:
                      "${pathwayController.modules[index].mqsLearnActivity[j].addToFav}",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityAudioLesson,
                  value: pathwayController.modules[index].mqsLearnActivity[j]
                          .activity?.mqsActivityAudioLesson ??
                      "",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityBenefits,
                  value: pathwayController.modules[index].mqsLearnActivity[j]
                          .activity?.mqsActivityBenefits ??
                      "",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityCoachInstructions,
                  value: pathwayController.modules[index].mqsLearnActivity[j]
                          .activity?.mqsActivityCoachInstructions ??
                      "",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityDuration,
                  value:
                      "${pathwayController.modules[index].mqsLearnActivity[j].activity?.mqsActivityDuration}",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityLessonDetail,
                  value: pathwayController.modules[index].mqsLearnActivity[j]
                          .activity?.mqsActivityLessonDetail ??
                      "",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityReflectionQuestion,
                  value: pathwayController.modules[index].mqsLearnActivity[j]
                          .activity?.mqsActivityReflectionQuestion ??
                      "",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityVideoLesson,
                  value: pathwayController.modules[index].mqsLearnActivity[j]
                          .activity?.mqsActivityVideoLesson ??
                      "",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.mqsInfo,
                  value: pathwayController.modules[index].mqsLearnActivity[j]
                          .activity?.mqsInfo ??
                      "",
                ),
              ],
            ],
          ),
      ],
    );
  }
  return null;
}
