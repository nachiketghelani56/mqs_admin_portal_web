import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_drop_down.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget practiceActivityFormWidget(
    {required PathwayController pathwayController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.pathway.practiceActivity,
        showAddIcon: true,
      ).tap(() {
        pathwayController.clearPracActivityFields();
        pathwayController.showPracActivity.value = true;
      }),
      if (pathwayController.showPracActivity.value)
        Form(
          key: pathwayController.pracActFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizeConfig.size30.height,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: pathwayController.pracActIdController,
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
                      controller: pathwayController.pracActTitleController,
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
                          pathwayController.pracActInstructionsController,
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
                      controller: pathwayController.pracActRefIdController,
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
                      controller:
                          pathwayController.pracActNavigateToScreenController,
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
                      controller: pathwayController.pracActBenefitsController,
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
                          pathwayController.pracActCoachInstructionsController,
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
                      controller: pathwayController.pracActDurationController,
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
                          pathwayController.pracActLessonDetailController,
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
                      controller: pathwayController.pracActRefQueController,
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
                ],
              ),
              SizeConfig.size34.height,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: pathwayController.pracActUIController,
                      label: StringConfig.pathway.activityUI,
                      hintText: StringConfig.pathway.enter +
                          StringConfig.pathway.activityUI.toLowerCase(),
                      validator: (p0) => Validator.emptyValidator(p0 ?? "",
                          StringConfig.pathway.activityUI.toLowerCase()),
                    ),
                  ),
                  SizeConfig.size15.width,
                  Expanded(
                    child: CustomTextField(
                      controller: pathwayController.pracActMqsInfoController,
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
                          pathwayController.pracActAudioLessonController,
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
                          pathwayController.pracActAudioLessonController.text =
                              audio.keys.first;
                          pathwayController.pracAudio.value =
                              audio.values.first ?? Uint8List(0);
                        }
                      },
                    ),
                  ),
                  SizeConfig.size15.width,
                  Expanded(
                    child: CustomTextField(
                      controller:
                          pathwayController.pracActVideoLessonController,
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
                          pathwayController.pracActVideoLessonController.text =
                              video.keys.first;
                          pathwayController.pracVideo.value =
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
                value: pathwayController.pracActScreenHandoff.value,
                items: pathwayController.boolOptions,
                onChanged: (value) {
                  pathwayController.pracActScreenHandoff.value = value;
                },
              ),
              SizeConfig.size34.height,
              titleWidget(
                title: StringConfig.pathway.activitySkills,
                showAddIcon: true,
              ).tap(() {
                pathwayController.pracActSkillController.clear();
                pathwayController.showPracActSkills.value = true;
              }),
              if (pathwayController.showPracActSkills.value)
                Form(
                  key: pathwayController.pracActSkillFormKey,
                  child: Column(
                    children: [
                      SizeConfig.size30.height,
                      CustomTextField(
                        controller: pathwayController.pracActSkillController,
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
                                pathwayController.showPracActSkills.value =
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
                                        .pracActSkillFormKey.currentState
                                        ?.validate() ??
                                    false) {
                                  pathwayController.showPracActSkills.value =
                                      false;
                                  pathwayController.addPracActSkill();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (pathwayController.pracActSkills.isNotEmpty) ...[
                SizeConfig.size30.height,
                Wrap(
                  spacing: SizeConfig.size12,
                  runSpacing: SizeConfig.size12,
                  children: [
                    for (int i = 0;
                        i < pathwayController.pracActSkills.length;
                        i++)
                      Container(
                        decoration: FontTextStyleConfig.optionDecoration,
                        padding: const EdgeInsets.all(SizeConfig.size10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              pathwayController.pracActSkills[i],
                              style: FontTextStyleConfig.labelTextStyle
                                  .copyWith(color: ColorConfig.whiteColor),
                            ),
                            SizeConfig.size10.width,
                            Image.asset(
                              ImageConfig.close,
                              color: ColorConfig.whiteColor,
                              height: SizeConfig.size20,
                            ).tap(() {
                              pathwayController.removePracActSkill(index: i);
                            }),
                          ],
                        ),
                      )
                  ],
                ).paddingSymmetric(horizontal: SizeConfig.size10),
              ],
              SizeConfig.size34.height,
              titleWidget(
                title: StringConfig.pathway.activityReqIcons,
                showAddIcon: true,
              ).tap(() {
                pathwayController.pracActReqIconController.clear();
                pathwayController.showPracActReqIcons.value = true;
              }),
              if (pathwayController.showPracActReqIcons.value)
                Form(
                  key: pathwayController.pracActReqIconFormKey,
                  child: Column(
                    children: [
                      SizeConfig.size30.height,
                      CustomTextField(
                        controller: pathwayController.pracActReqIconController,
                        label: StringConfig.pathway.activityReqIcon,
                        hintText: StringConfig.pathway.enter +
                            StringConfig.pathway.activityReqIcon.toLowerCase(),
                        validator: (p0) => Validator.emptyValidator(p0 ?? "",
                            StringConfig.pathway.activityReqIcon.toLowerCase()),
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
                                pathwayController.showPracActReqIcons.value =
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
                                        .pracActReqIconFormKey.currentState
                                        ?.validate() ??
                                    false) {
                                  pathwayController.showPracActReqIcons.value =
                                      false;
                                  pathwayController.addPracActReqIcon();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (pathwayController.pracActReqIcons.isNotEmpty) ...[
                SizeConfig.size30.height,
                Wrap(
                  spacing: SizeConfig.size12,
                  runSpacing: SizeConfig.size12,
                  children: [
                    for (int i = 0;
                        i < pathwayController.pracActReqIcons.length;
                        i++)
                      Container(
                        decoration: FontTextStyleConfig.optionDecoration,
                        padding: const EdgeInsets.all(SizeConfig.size10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              pathwayController.pracActReqIcons[i],
                              style: FontTextStyleConfig.labelTextStyle
                                  .copyWith(color: ColorConfig.whiteColor),
                            ),
                            SizeConfig.size10.width,
                            Image.asset(
                              ImageConfig.close,
                              color: ColorConfig.whiteColor,
                              height: SizeConfig.size20,
                            ).tap(() {
                              pathwayController.removePracActReqIcon(index: i);
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
                        pathwayController.showPracActivity.value = false;
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
                        if (pathwayController.pracActFormKey.currentState
                                ?.validate() ??
                            false) {
                          pathwayController.showPracActivity.value = false;
                          pathwayController.addPracActivity();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    ],
  );
}
