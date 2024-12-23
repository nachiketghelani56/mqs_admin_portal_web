import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/widgets/key_value_warpper_widget.dart';
import 'package:mqs_admin_portal_web/widgets/audio_key_value_row_widget.dart';

Widget? practiceActivityDetailWidget(
    {required PathwayController pathwayController, required int index}) {
  if (pathwayController.showPracActivity.value) {
    return Column(
      children: [
        for (int j = 0;
            j < pathwayController.modules[index].mqsPracticeActivity.length;
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
                        pathwayController
                            .modules[index].mqsPracticeActivity[j].id,
                        style: FontTextStyleConfig.tableContentTextStyle,
                      ),
                    ),
                    Icon(
                      pathwayController.pracActIndex.value == j
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      color: ColorConfig.primaryColor,
                    ),
                  ],
                ),
              ).tap(() {
                if (pathwayController.pracActIndex.value == j) {
                  pathwayController.pracActIndex.value = -1;
                } else {
                  pathwayController.pracActIndex.value = j;
                }
              }),
              if (pathwayController.pracActIndex.value == j) ...[
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityTitle,
                  value: pathwayController
                      .modules[index].mqsPracticeActivity[j].mqsActivityTitle,
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activtyRefID,
                  value: pathwayController
                      .modules[index].mqsPracticeActivity[j].mqsActivityRefID,
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityInstruction,
                  value: pathwayController.modules[index].mqsPracticeActivity[j]
                      .mqsActivityInstruction,
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityScreenHandoff,
                  value:
                      "${pathwayController.modules[index].mqsPracticeActivity[j].mqsActivityScreenHandoff}",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activitySkills,
                  value: pathwayController
                      .modules[index].mqsPracticeActivity[j].mqsActivitySkill
                      .join(", "),
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityReqIcons,
                  value: pathwayController
                      .modules[index].mqsPracticeActivity[j].mqsActivityReqIcons
                      .join(", "),
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.navigateToScreen,
                  value: pathwayController.modules[index].mqsPracticeActivity[j]
                      .mqsNavigateToScreen,
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityStatus,
                  value:
                      "${pathwayController.modules[index].mqsPracticeActivity[j].mqsActivityStatus}",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.completionDate,
                  value: pathwayController.modules[index].mqsPracticeActivity[j]
                          .mqsActivityCompletionDate.isNotEmpty
                      ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                          DateTime.parse(pathwayController
                              .modules[index]
                              .mqsPracticeActivity[j]
                              .mqsActivityCompletionDate))
                      : pathwayController.modules[index].mqsPracticeActivity[j]
                          .mqsActivityCompletionDate,
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.addToFav,
                  value:
                      "${pathwayController.modules[index].mqsPracticeActivity[j].addToFav}",
                ),
                audioKeyValueRowWidget(
                  key: StringConfig.pathway.activityAudioLesson,
                  value: pathwayController.modules[index].mqsPracticeActivity[j]
                      .activity?.mqsActivityAudioLesson ??
                      "",
                  url: pathwayController.modules[index].mqsPracticeActivity[j]
                      .activity?.mqsActivityAudioLesson ?? "",

                  audioController: pathwayController,
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityBenefits,
                  value: pathwayController.modules[index].mqsPracticeActivity[j]
                          .activity?.mqsActivityBenefits ??
                      "",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityCoachInstructions,
                  value: pathwayController.modules[index].mqsPracticeActivity[j]
                          .activity?.mqsActivityCoachInstructions ??
                      "",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityDuration,
                  value:
                      "${pathwayController.modules[index].mqsPracticeActivity[j].activity?.mqsActivityDuration}",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityLessonDetail,
                  value: pathwayController.modules[index].mqsPracticeActivity[j]
                          .activity?.mqsActivityLessonDetail ??
                      "",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityReflectionQuestion,
                  value: pathwayController.modules[index].mqsPracticeActivity[j]
                          .activity?.mqsActivityReflectionQuestion ??
                      "",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.activityVideoLesson,
                  value: pathwayController.modules[index].mqsPracticeActivity[j]
                          .activity?.mqsActivityVideoLesson ??
                      "",
                ),
                keyValueWrapperWidget(
                  key: StringConfig.pathway.mqsInfo,
                  value: pathwayController.modules[index].mqsPracticeActivity[j]
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
