import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget pathwayDepFormWidget({required PathwayController pathwayController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.pathway.pathwayDep,
        showAddIcon: true,
      ).tap(() {
        pathwayController.pathwayDepController.clear();
        pathwayController.showPathwayDep.value = true;
      }),
      if (pathwayController.showPathwayDep.value)
        Form(
          key: pathwayController.pathwayDepFormKey,
          child: Column(
            children: [
              SizeConfig.size30.height,
              CustomTextField(
                controller: pathwayController.pathwayDepController,
                label: StringConfig.pathway.pathwayDep,
                hintText: StringConfig.pathway.enterPathwayDep,
                validator: (p0) => Validator.emptyValidator(
                    p0 ?? "", StringConfig.pathway.pathwayDep.toLowerCase()),
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
                        pathwayController.showPathwayDep.value = false;
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
                        if (pathwayController.pathwayDepFormKey.currentState
                                ?.validate() ??
                            false) {
                          pathwayController.showPathwayDep.value = false;
                          pathwayController.addPathwayDep();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      if (pathwayController.pathwayDep.isNotEmpty) ...[
        SizeConfig.size30.height,
        Wrap(
          spacing: SizeConfig.size12,
          runSpacing: SizeConfig.size12,
          children: [
            for (int i = 0; i < pathwayController.pathwayDep.length; i++)
              Container(
                decoration: FontTextStyleConfig.optionDecoration,
                padding: const EdgeInsets.all(SizeConfig.size10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      pathwayController.pathwayDep[i],
                      style: FontTextStyleConfig.labelTextStyle
                          .copyWith(color: ColorConfig.whiteColor),
                    ),
                    SizeConfig.size10.width,
                    Image.asset(
                      ImageConfig.close,
                      color: ColorConfig.whiteColor,
                      height: SizeConfig.size20,
                    ).tap(() {
                      pathwayController.removePathwayDep(index: i);
                    }),
                  ],
                ),
              )
          ],
        ).paddingSymmetric(horizontal: SizeConfig.size10),
      ],
    ],
  );
}
