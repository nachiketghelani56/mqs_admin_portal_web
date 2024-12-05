import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget hashtagFormWidget({required CircleController circleController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleWidget(
        title: StringConfig.circle.hashTags,
        showAddIcon: true,
      ).tap(() {
        circleController.hashtagController.clear();
        circleController.showHashTag.value = true;
      }),
      if (circleController.showHashTag.value)
        Form(
          key: circleController.hashtagFormKey,
          child: Column(
            children: [
              SizeConfig.size30.height,
              CustomTextField(
                controller: circleController.hashtagController,
                label: StringConfig.circle.hashTag,
                hintText: StringConfig.circle.enterTag,
                prefixText: '#',
                validator: (p0) => Validator.emptyValidator(
                    p0 ?? "", StringConfig.circle.hashTag.toLowerCase()),
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
                        circleController.showHashTag.value = false;
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
                        if (circleController.hashtagFormKey.currentState
                                ?.validate() ??
                            false) {
                          circleController.showHashTag.value = false;
                          circleController.addHashatag();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      SizeConfig.size30.height,
      Wrap(
        spacing: SizeConfig.size12,
        runSpacing: SizeConfig.size12,
        children: [
          for (int i = 0; i < circleController.hashtags.length; i++)
            Container(
              decoration: FontTextStyleConfig.optionDecoration,
              padding: const EdgeInsets.all(SizeConfig.size10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '#${circleController.hashtags[i].name ?? ''}',
                    style: FontTextStyleConfig.labelTextStyle
                        .copyWith(color: ColorConfig.whiteColor),
                  ),
                  SizeConfig.size10.width,
                  Image.asset(
                    ImageConfig.close,
                    color: ColorConfig.whiteColor,
                    height: SizeConfig.size20,
                  ).tap(() {
                    circleController.removeHashtag(
                        id: circleController.hashtags[i].id);
                  }),
                ],
              ),
            )
        ],
      ).paddingSymmetric(horizontal: SizeConfig.size10),
    ],
  );
}
