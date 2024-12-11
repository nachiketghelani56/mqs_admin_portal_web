import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/learn_activty_form_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/module_list_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/widgets/practice_activity_form_widget.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_image_field.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget moduleFormWidget({required PathwayController pathwayController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.pathway.modules,
        showAddIcon: true,
      ).tap(() {
        pathwayController.clearModuleFields();
        pathwayController.showModules.value = true;
      }),
      if (pathwayController.showModules.value)
        Form(
          key: pathwayController.moduleFormKey,
          child: Column(
            children: [
              SizeConfig.size30.height,
              CustomTextField(
                controller: pathwayController.moduleIdController,
                label: StringConfig.pathway.moduleID,
                hintText: StringConfig.pathway.moduleID,
                validator: (p0) => Validator.emptyValidator(
                    p0 ?? "", StringConfig.pathway.moduleID.toLowerCase()),
              ),
              SizeConfig.size34.height,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: pathwayController.moduleTitleController,
                      label: StringConfig.pathway.moduleTitle,
                      hintText: StringConfig.pathway.enterModuleTitle,
                      validator: (p0) => Validator.emptyValidator(p0 ?? "",
                          StringConfig.pathway.moduleTitle.toLowerCase()),
                    ),
                  ),
                  SizeConfig.size15.width,
                  Expanded(
                    child: CustomTextField(
                      controller: pathwayController.moduleSubtitleController,
                      label: StringConfig.pathway.moduleSubtitle,
                      hintText: StringConfig.pathway.enterModuleSubtitle,
                      validator: (p0) => Validator.emptyValidator(p0 ?? "",
                          StringConfig.pathway.moduleSubtitle.toLowerCase()),
                    ),
                  ),
                ],
              ),
              SizeConfig.size34.height,
              CustomImageField(
                image: pathwayController.moduleTileImage.value,
                label: StringConfig.pathway.moduleTileImage,
                onTap: () async {
                  Uint8List? image = await pathwayController.pickImage();
                  if (image != null) {
                    pathwayController.moduleTileImage.value = image;
                  }
                },
              ),
              SizeConfig.size34.height,
              learnActivityFormWidget(pathwayController: pathwayController),
              SizeConfig.size34.height,
              practiceActivityFormWidget(pathwayController: pathwayController),
              SizeConfig.size18.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: SizeConfig.size162,
                    child: CustomButton(
                      btnText: StringConfig.dashboard.cancel,
                      onTap: () {
                        pathwayController.showModules.value = false;
                      },
                      isSelected: false,
                    ),
                  ),
                  SizeConfig.size12.width,
                  SizedBox(
                    width: SizeConfig.size162,
                    child: CustomButton(
                      btnText: pathwayController.editModuleIndex.value >= 0
                          ? StringConfig.dashboard.update
                          : StringConfig.dashboard.submit,
                      onTap: () {
                        if (pathwayController.moduleFormKey.currentState
                                ?.validate() ??
                            false) {
                          pathwayController.showModules.value = false;
                          if (pathwayController.editModuleIndex.value >= 0) {
                            pathwayController.editModule();
                          } else {
                            pathwayController.addModule();
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
      moduleListWidget(pathwayController: pathwayController),
    ],
  );
}
