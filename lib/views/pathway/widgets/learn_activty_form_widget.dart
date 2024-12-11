import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/learn_activity_list_widget.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_drop_down.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget learnActivityFormWidget({required PathwayController pathwayController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.pathway.learnActivity,
        showAddIcon: true,
      ).tap(() {
        pathwayController.clearLearnActivityFields();
        pathwayController.showLearnActivty.value = true;
      }),
      if (pathwayController.showLearnActivty.value)
        Form(
          key: pathwayController.learnActFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeConfig.size30.height,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: pathwayController.learnActIdController,
                      label: StringConfig.pathway.activityID,
                      hintText: StringConfig.pathway.enter +
                          StringConfig.pathway.activityID.toLowerCase(),
                      validator: (p0) => Validator.emptyValidator(p0 ?? "",
                          StringConfig.pathway.activityID.toLowerCase()),
                    ),
                  ),
                  SizeConfig.size15.width,
                  Expanded(
                    child: CustomTextField(
                      controller: pathwayController.learnActTitleController,
                      label: StringConfig.pathway.activityTitle,
                      hintText: StringConfig.pathway.enter +
                          StringConfig.pathway.activityTitle.toLowerCase(),
                      validator: (p0) => Validator.emptyValidator(p0 ?? "",
                          StringConfig.pathway.activityTitle.toLowerCase()),
                    ),
                  ),
                ],
              ),
              SizeConfig.size34.height,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller:
                          pathwayController.learnActNavigateToScreenController,
                      label: StringConfig.pathway.navigateToScreen,
                      hintText: StringConfig.pathway.enter +
                          StringConfig.pathway.navigateToScreen.toLowerCase(),
                      validator: (p0) => Validator.emptyValidator(p0 ?? "",
                          StringConfig.pathway.navigateToScreen.toLowerCase()),
                    ),
                  ),
                  SizeConfig.size15.width,
                  Expanded(
                    child: CustomTextField(
                      controller: pathwayController.learnActRefIdController,
                      label: StringConfig.pathway.activtyRefID,
                      hintText: StringConfig.pathway.enter +
                          StringConfig.pathway.activtyRefID.toLowerCase(),
                      validator: (p0) => Validator.emptyValidator(p0 ?? "",
                          StringConfig.pathway.activtyRefID.toLowerCase()),
                    ),
                  ),
                ],
              ),
              SizeConfig.size34.height,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: pathwayController.learnActRefQueController,
                      label: StringConfig.pathway.activityReflectionQuestion,
                      hintText: StringConfig.pathway.enter +
                          StringConfig.pathway.activityReflectionQuestion
                              .toLowerCase(),
                      validator: (p0) => Validator.emptyValidator(
                          p0 ?? "",
                          StringConfig.pathway.activityReflectionQuestion
                              .toLowerCase()),
                    ),
                  ),
                  SizeConfig.size15.width,
                  Expanded(
                    child: CustomTextField(
                      controller: pathwayController.learnActBenefitsController,
                      label: StringConfig.pathway.activityBenefits,
                      hintText: StringConfig.pathway.enter +
                          StringConfig.pathway.activityBenefits.toLowerCase(),
                      validator: (p0) => Validator.emptyValidator(p0 ?? "",
                          StringConfig.pathway.activityBenefits.toLowerCase()),
                    ),
                  ),
                ],
              ),
              SizeConfig.size34.height,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller:
                          pathwayController.learnActCoachInstructionsController,
                      label: StringConfig.pathway.activityCoachInstructions,
                      hintText: StringConfig.pathway.enter +
                          StringConfig.pathway.activityCoachInstructions
                              .toLowerCase(),
                      validator: (p0) => Validator.emptyValidator(
                          p0 ?? "",
                          StringConfig.pathway.activityCoachInstructions
                              .toLowerCase()),
                    ),
                  ),
                  SizeConfig.size15.width,
                  Expanded(
                    child: CustomTextField(
                      controller: pathwayController.learnActDurationController,
                      label: StringConfig.pathway.activityDuration,
                      hintText: StringConfig.pathway.enter +
                          StringConfig.pathway.activityDuration.toLowerCase(),
                      validator: (p0) => Validator.emptyValidator(p0 ?? "",
                          StringConfig.pathway.activityDuration.toLowerCase()),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              SizeConfig.size34.height,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller:
                          pathwayController.learnActLessonDetailController,
                      label: StringConfig.pathway.activityLessonDetail,
                      hintText: StringConfig.pathway.enter +
                          StringConfig.pathway.activityLessonDetail
                              .toLowerCase(),
                      validator: (p0) => Validator.emptyValidator(
                          p0 ?? "",
                          StringConfig.pathway.activityLessonDetail
                              .toLowerCase()),
                    ),
                  ),
                  SizeConfig.size15.width,
                  Expanded(
                    child: CustomTextField(
                      controller: pathwayController.learnActMqsInfoController,
                      label: StringConfig.pathway.mqsInfo,
                      hintText: StringConfig.pathway.enter +
                          StringConfig.pathway.mqsInfo.toLowerCase(),
                      validator: (p0) => Validator.emptyValidator(
                          p0 ?? "", StringConfig.pathway.mqsInfo.toLowerCase()),
                    ),
                  ),
                ],
              ),
              SizeConfig.size34.height,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller:
                          pathwayController.learnActAudioLessonController,
                      label: StringConfig.pathway.activityAudioLesson,
                      hintText: StringConfig.pathway.chooseAudio,
                      validator: (p0) => Validator.emptyValidator(
                          p0 ?? "",
                          StringConfig.pathway.activityAudioLesson
                              .toLowerCase()),
                      readOnly: true,
                      onTap: () async {
                        Map<String, Uint8List?> audio =
                            await pathwayController.pickAudio();
                        if (audio.isNotEmpty) {
                          pathwayController.learnActAudioLessonController.text =
                              audio.keys.first;
                          pathwayController.learnAudio.value =
                              audio.values.first ?? Uint8List(0);
                        }
                      },
                    ),
                  ),
                  SizeConfig.size15.width,
                  Expanded(
                    child: CustomTextField(
                      controller:
                          pathwayController.learnActVideoLessonController,
                      label: StringConfig.pathway.activityVideoLesson,
                      hintText: StringConfig.pathway.chooseVideo,
                      validator: (p0) => Validator.emptyValidator(
                          p0 ?? "",
                          StringConfig.pathway.activityVideoLesson
                              .toLowerCase()),
                      readOnly: true,
                      onTap: () async {
                        Map<String, Uint8List?> video =
                            await pathwayController.pickVideo();
                        if (video.isNotEmpty) {
                          pathwayController.learnActVideoLessonController.text =
                              video.keys.first;
                          pathwayController.learnVideo.value =
                              video.values.first ?? Uint8List(0);
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizeConfig.size34.height,
              CustomDropDown(
                label: StringConfig.pathway.activityScreenHandoff,
                value: pathwayController.learnActScreenHandoff.value,
                items: pathwayController.boolOptions,
                onChanged: (value) {
                  pathwayController.learnActScreenHandoff.value = value;
                },
              ),
              SizeConfig.size34.height,
              titleWidget(
                title: StringConfig.pathway.activitySkills,
                showAddIcon: true,
              ).tap(() {
                pathwayController.learnActSkillController.clear();
                pathwayController.showLearnActSkills.value = true;
              }),
              if (pathwayController.showLearnActSkills.value)
                Form(
                  key: pathwayController.learnActSkillFormKey,
                  child: Column(
                    children: [
                      SizeConfig.size30.height,
                      CustomTextField(
                        controller: pathwayController.learnActSkillController,
                        label: StringConfig.pathway.activitySkill,
                        hintText: StringConfig.pathway.enter +
                            StringConfig.pathway.activitySkill.toLowerCase(),
                        validator: (p0) => Validator.emptyValidator(p0 ?? "",
                            StringConfig.pathway.activitySkill.toLowerCase()),
                      ),
                      SizeConfig.size18.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: SizeConfig.size162,
                            child: CustomButton(
                              btnText: StringConfig.dashboard.cancel,
                              onTap: () {
                                pathwayController.showLearnActSkills.value =
                                    false;
                              },
                              isSelected: false,
                            ),
                          ),
                          SizeConfig.size12.width,
                          SizedBox(
                            width: SizeConfig.size162,
                            child: CustomButton(
                              btnText: StringConfig.dashboard.submit,
                              onTap: () {
                                if (pathwayController
                                        .learnActSkillFormKey.currentState
                                        ?.validate() ??
                                    false) {
                                  pathwayController.showLearnActSkills.value =
                                      false;
                                  pathwayController.addLearnActSkill();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (pathwayController.learnActSkills.isNotEmpty) ...[
                SizeConfig.size30.height,
                Wrap(
                  spacing: SizeConfig.size12,
                  runSpacing: SizeConfig.size12,
                  children: [
                    for (int i = 0;
                        i < pathwayController.learnActSkills.length;
                        i++)
                      Container(
                        decoration: FontTextStyleConfig.optionDecoration,
                        padding: const EdgeInsets.all(SizeConfig.size10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              pathwayController.learnActSkills[i],
                              style: FontTextStyleConfig.labelTextStyle
                                  .copyWith(color: ColorConfig.whiteColor),
                            ),
                            SizeConfig.size10.width,
                            Image.asset(
                              ImageConfig.close,
                              color: ColorConfig.whiteColor,
                              height: SizeConfig.size20,
                            ).tap(() {
                              pathwayController.removeLearnActSkill(index: i);
                            }),
                          ],
                        ),
                      )
                  ],
                ).paddingSymmetric(horizontal: SizeConfig.size10),
              ],
              SizeConfig.size18.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: SizeConfig.size162,
                    child: CustomButton(
                      btnText: StringConfig.dashboard.cancel,
                      onTap: () {
                        pathwayController.showLearnActivty.value = false;
                      },
                      isSelected: false,
                    ),
                  ),
                  SizeConfig.size12.width,
                  SizedBox(
                    width: SizeConfig.size162,
                    child: CustomButton(
                      btnText: pathwayController.editLearnActIndex.value >= 0
                          ? StringConfig.dashboard.update
                          : StringConfig.dashboard.submit,
                      onTap: () {
                        if (pathwayController.learnActFormKey.currentState
                                ?.validate() ??
                            false) {
                          pathwayController.showLearnActivty.value = false;
                          if (pathwayController.editLearnActIndex.value >= 0) {
                            pathwayController.editLearnActivity();
                          } else {
                            pathwayController.addLearnActivity();
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      learnActivityListWidget(pathwayController: pathwayController),
    ],
  );
}
