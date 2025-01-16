import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget hashtagDataFormWidget(
    {required CircleDataController circleDataController,
    required BuildContext context}) {
  GlobalKey<FormState> hashtagFormKey = GlobalKey<FormState>();
  return Obx(
    () => context.width > SizeConfig.size1500
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget(
                title: StringConfig.circle.hashTags,
                showAddIcon: true,
              ).tap(() {
                circleDataController.hashtagController.clear();
                circleDataController.showHashTag.value = true;
              }),
              if (circleDataController.showHashTag.value)
                Form(
                  key: hashtagFormKey,
                  child: Column(
                    children: [
                      SizeConfig.size30.height,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller:
                                  circleDataController.hashtagController,
                              label: StringConfig.circle.hashTag,
                              hintText: StringConfig.circle.enterTag,
                              prefixText: '#',
                              validator: (p0) => Validator.emptyValidator(
                                  p0 ?? "",
                                  StringConfig.circle.hashTag.toLowerCase()),
                            ),
                          ),
                          SizeConfig.size24.height,
                          Expanded(
                            child: Container(),
                          ),
                        ],
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
                                circleDataController.showHashTag.value = false;
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
                                if (hashtagFormKey.currentState?.validate() ??
                                    false) {
                                  circleDataController.showHashTag.value =
                                      false;
                                  circleDataController.addHashatag();
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
                  for (int i = 0; i < circleDataController.hashtags.length; i++)
                    Container(
                      decoration: FontTextStyleConfig.optionDecoration,
                      padding: const EdgeInsets.all(SizeConfig.size10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '#${circleDataController.hashtags[i].name ?? ''}',
                            style: FontTextStyleConfig.labelTextStyle
                                .copyWith(color: ColorConfig.whiteColor),
                          ),
                          SizeConfig.size10.width,
                          Image.asset(
                            ImageConfig.close,
                            color: ColorConfig.whiteColor,
                            height: SizeConfig.size20,
                          ).tap(() {
                            circleDataController.removeHashtag(
                                id: circleDataController.hashtags[i].id);
                          }),
                        ],
                      ),
                    )
                ],
              ).paddingSymmetric(horizontal: SizeConfig.size10),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget(
                title: StringConfig.circle.hashTags,
                showAddIcon: true,
              ).tap(() {
                circleDataController.hashtagController.clear();
                circleDataController.showHashTag.value = true;
              }),
              if (circleDataController.showHashTag.value)
                Form(
                  key: hashtagFormKey,
                  child: Column(
                    children: [
                      SizeConfig.size30.height,
                      CustomTextField(
                        controller: circleDataController.hashtagController,
                        label: StringConfig.circle.hashTag,
                        hintText: StringConfig.circle.enterTag,
                        prefixText: '#',
                        validator: (p0) => Validator.emptyValidator(p0 ?? "",
                            StringConfig.circle.hashTag.toLowerCase()),
                      ),
                      SizeConfig.size18.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: SizeConfig.size120,
                            child: CustomButton(
                              btnText: StringConfig.dashboard.cancel,
                              onTap: () {
                                circleDataController.showHashTag.value = false;
                              },
                              isSelected: false,
                            ),
                          ),
                          SizeConfig.size12.width,
                          SizedBox(
                            width: SizeConfig.size120,
                            child: CustomButton(
                              btnText: StringConfig.dashboard.submit,
                              onTap: () {
                                if (hashtagFormKey.currentState?.validate() ??
                                    false) {
                                  circleDataController.showHashTag.value =
                                      false;
                                  circleDataController.addHashatag();
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
                  for (int i = 0; i < circleDataController.hashtags.length; i++)
                    Container(
                      decoration: FontTextStyleConfig.optionDecoration,
                      padding: const EdgeInsets.all(SizeConfig.size10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '#${circleDataController.hashtags[i].name ?? ''}',
                            style: FontTextStyleConfig.labelTextStyle
                                .copyWith(color: ColorConfig.whiteColor),
                          ),
                          SizeConfig.size10.width,
                          Image.asset(
                            ImageConfig.close,
                            color: ColorConfig.whiteColor,
                            height: SizeConfig.size20,
                          ).tap(() {
                            circleDataController.removeHashtag(
                                id: circleDataController.hashtags[i].id);
                          }),
                        ],
                      ),
                    )
                ],
              ).paddingSymmetric(horizontal: SizeConfig.size10),
            ],
          ),
  );
}
