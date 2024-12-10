import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_drop_down.dart';
import 'package:mqs_admin_portal_web/widgets/custom_image_field.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addPathwayFormWidget({required PathwayController pathwayController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.pathway.pathwayInformation,
        showArrowIcon: false,
      ),
      SizeConfig.size30.height,
      CustomTextField(
        controller: pathwayController.idController,
        label: StringConfig.pathway.pathwayID,
        hintText: StringConfig.pathway.enterPathwayID,
        validator: (p0) => Validator.emptyValidator(
            p0 ?? "", StringConfig.pathway.pathwayID.toLowerCase()),
      ),
      SizeConfig.size34.height,
      CustomTextField(
        controller: pathwayController.titleController,
        label: StringConfig.pathway.pathwayTitle,
        hintText: StringConfig.pathway.enterPathwayTitle,
        validator: (p0) => Validator.emptyValidator(
            p0 ?? "", StringConfig.pathway.pathwayTitle.toLowerCase()),
      ),
      SizeConfig.size34.height,
      CustomTextField(
        controller: pathwayController.subtitleController,
        label: StringConfig.pathway.pathwaySubtitle,
        hintText: StringConfig.pathway.enterPathwaySubtitle,
        validator: (p0) => Validator.emptyValidator(
            p0 ?? "", StringConfig.pathway.pathwaySubtitle.toLowerCase()),
      ),
      SizeConfig.size34.height,
      CustomDropDown(
        label: StringConfig.pathway.pathwayType,
        value: pathwayController.selectedPathwayType.value.isNotEmpty
            ? pathwayController.selectedPathwayType.value
            : null,
        items: pathwayController.pathwayTypes
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: FontTextStyleConfig.textFieldTextStyle
                      .copyWith(fontSize: FontSizeConfig.fontSize16),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          pathwayController.selectedPathwayType.value = value;
        },
      ),
      SizeConfig.size34.height,
      CustomImageField(
        image: pathwayController.pathwayImage.value,
        label: StringConfig.pathway.pathwayImage,
        onTap: () async {
          Uint8List? image = await pathwayController.pickImage();
          if (image != null) {
            pathwayController.pathwayImage.value = image;
          }
        },
      ),
      SizeConfig.size34.height,
      CustomImageField(
        image: pathwayController.pathwayIntroImage.value,
        label: StringConfig.pathway.pathwayIntroImage,
        onTap: () async {
          Uint8List? image = await pathwayController.pickImage();
          if (image != null) {
            pathwayController.pathwayIntroImage.value = image;
          }
        },
      ),
      SizeConfig.size34.height,
      CustomImageField(
        image: pathwayController.pathwayTileImage.value,
        label: StringConfig.pathway.pathwayTileImage,
        onTap: () async {
          Uint8List? image = await pathwayController.pickImage();
          if (image != null) {
            pathwayController.pathwayTileImage.value = image;
          }
        },
      ),
      SizeConfig.size34.height,
      CustomTextField(
        controller: pathwayController.aboutPathwayController,
        label: StringConfig.pathway.aboutPathway,
        hintText: StringConfig.pathway.enterAboutPathway,
        validator: (p0) => Validator.emptyValidator(
            p0 ?? "", StringConfig.pathway.aboutPathway.toLowerCase()),
      ),
      SizeConfig.size34.height,
      CustomTextField(
        controller: pathwayController.learningObjController,
        label: StringConfig.pathway.learningObj,
        hintText: StringConfig.pathway.enterLearningObj,
        validator: (p0) => Validator.emptyValidator(
            p0 ?? "", StringConfig.pathway.learningObj.toLowerCase()),
      ),
      SizeConfig.size34.height,
      CustomTextField(
        controller: pathwayController.coachInstructionsController,
        label: StringConfig.pathway.pathwayCoachInstructions,
        hintText: StringConfig.pathway.enterPathwayCoachInstructions,
        validator: (p0) => Validator.emptyValidator(p0 ?? "",
            StringConfig.pathway.pathwayCoachInstructions.toLowerCase()),
      ),
      SizeConfig.size34.height,
      Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: pathwayController.durationController,
              label: StringConfig.pathway.pathwayDuration,
              hintText: StringConfig.pathway.enterPathwayDuration,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.pathway.pathwayDuration.toLowerCase()),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          SizeConfig.size15.width,
          Expanded(
            child: CustomTextField(
              controller: pathwayController.levelController,
              label: StringConfig.pathway.pathwayLevel,
              hintText: StringConfig.pathway.enterPathwayLevel,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.pathway.pathwayLevel.toLowerCase()),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ],
      ),
    ],
  );
}
