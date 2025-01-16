import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_drop_down.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addCircleDataFormWidget(
    {required CircleDataController circleDataController,
    required BuildContext context}) {
  return context.width > SizeConfig.size1500
      ? Column(
          children: [
            titleWidget(
              title: StringConfig.circle.circleInformation,
              showArrowIcon: false,
            ),
            SizeConfig.size30.height,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: circleDataController.postTitleController,
                    label: StringConfig.reporting.postTitle,
                    hintText: StringConfig.circle.enterPostTitle,
                    validator: (p0) => Validator.emptyValidator(p0 ?? "",
                        StringConfig.reporting.postTitle.toLowerCase()),
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomTextField(
                    controller: circleDataController.postContentController,
                    label: StringConfig.reporting.postContent,
                    hintText: StringConfig.circle.enterPostContent,
                    validator: (p0) => Validator.emptyValidator(p0 ?? "",
                        StringConfig.reporting.postContent.toLowerCase()),
                  ),
                ),
              ],
            ),
            SizeConfig.size34.height,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: circleDataController.postViewController,
                    label: StringConfig.reporting.postViews,
                    hintText: StringConfig.circle.enterPostView,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (p0) => Validator.emptyValidator(p0 ?? "",
                        StringConfig.reporting.postViews.toLowerCase()),
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomDropDown(
                    label: StringConfig.database.flag,
                    value: circleDataController.isFlag.value,
                    items: circleDataController.boolOptions,
                    onChanged: (value) {
                      circleDataController.isFlag.value = value;
                      if (value) {
                        circleDataController.flagNameController.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
            SizeConfig.size34.height,
            Row(
              children: [
                Expanded(
                  child: CustomDropDown(
                    label: StringConfig.database.mainPost,
                    value: circleDataController.isMainPost.value,
                    items: circleDataController.boolOptions,
                    onChanged: (value) {
                      circleDataController.isMainPost.value = value;
                      circleDataController.mainPostId.value = "";
                    },
                  ),
                ),
                SizeConfig.size24.width,
                Expanded(
                  child: CustomDropDown(
                    label: StringConfig.database.userGuide,
                    value: circleDataController.userIsGuide.value,
                    items: circleDataController.boolOptions,
                    onChanged: (value) {
                      circleDataController.userIsGuide.value = value;
                    },
                  ),
                ),
              ],
            ),
            if (circleDataController.isFlag.value ||
                (circleDataController.circle.isNotEmpty &&
                    !circleDataController.isMainPost.value)) ...[
              SizeConfig.size34.height,
              Row(
                children: [
                  if (circleDataController.isFlag.value &&
                      (circleDataController.circle.isNotEmpty &&
                          !circleDataController.isMainPost.value)) ...[
                    Expanded(
                      child: CustomTextField(
                        controller: circleDataController.flagNameController,
                        label: StringConfig.reporting.flagName,
                        hintText: StringConfig.circle.enterFlagName,
                        validator: (p0) => Validator.emptyValidator(p0 ?? "",
                            StringConfig.reporting.flagName.toLowerCase()),
                      ),
                    ),
                    SizeConfig.size24.width,
                    Expanded(
                      child: circleDataController.circle.isNotEmpty &&
                              !circleDataController.isMainPost.value
                          ? CustomDropDown(
                              label: StringConfig.circle.selectMainPostId,
                              value: circleDataController
                                      .mainPostId.value.isNotEmpty
                                  ? circleDataController.mainPostId.value
                                  : null,
                              validator: (p0) => Validator.emptyValidator(
                                  p0 ?? "",
                                  StringConfig.circle.postId.toLowerCase()),
                              items: circleDataController.circle
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        e.id ?? "",
                                        style: FontTextStyleConfig
                                            .textFieldTextStyle
                                            .copyWith(
                                                fontSize:
                                                    FontSizeConfig.fontSize16),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                circleDataController.mainPostId.value = value;
                              },
                            )
                          : Container(),
                    ),
                  ] else if (!(circleDataController.isFlag.value) &&
                      (circleDataController.circle.isNotEmpty &&
                          !circleDataController.isMainPost.value)) ...[
                    Expanded(
                      child: circleDataController.circle.isNotEmpty &&
                              !circleDataController.isMainPost.value
                          ? CustomDropDown(
                              label: StringConfig.circle.selectMainPostId,
                              value: circleDataController
                                      .mainPostId.value.isNotEmpty
                                  ? circleDataController.mainPostId.value
                                  : null,
                              validator: (p0) => Validator.emptyValidator(
                                  p0 ?? "",
                                  StringConfig.circle.postId.toLowerCase()),
                              items: circleDataController.circle
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        e.id ?? "",
                                        style: FontTextStyleConfig
                                            .textFieldTextStyle
                                            .copyWith(
                                                fontSize:
                                                    FontSizeConfig.fontSize16),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                circleDataController.mainPostId.value = value;
                              },
                            )
                          : Container(),
                    ),
                    SizeConfig.size24.width,
                    Expanded(
                      child: Container(),
                    ),
                  ] else ...[
                    Expanded(
                      child: CustomTextField(
                        controller: circleDataController.flagNameController,
                        label: StringConfig.reporting.flagName,
                        hintText: StringConfig.circle.enterFlagName,
                        validator: (p0) => Validator.emptyValidator(p0 ?? "",
                            StringConfig.reporting.flagName.toLowerCase()),
                      ),
                    ),
                    SizeConfig.size24.width,
                    Expanded(
                      child: Container(),
                    ),
                  ]
                ],
              ),
            ],
          ],
        )
      : Column(
          children: [
            titleWidget(
              title: StringConfig.circle.circleInformation,
              showArrowIcon: false,
            ),
            SizeConfig.size30.height,
            CustomTextField(
              controller: circleDataController.postTitleController,
              label: StringConfig.reporting.postTitle,
              hintText: StringConfig.circle.enterPostTitle,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.reporting.postTitle.toLowerCase()),
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller: circleDataController.postContentController,
              label: StringConfig.reporting.postContent,
              hintText: StringConfig.circle.enterPostContent,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.reporting.postContent.toLowerCase()),
            ),
            SizeConfig.size34.height,
            CustomTextField(
              controller: circleDataController.postViewController,
              label: StringConfig.reporting.postViews,
              hintText: StringConfig.circle.enterPostView,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.reporting.postViews.toLowerCase()),
            ),
            SizeConfig.size34.height,
            CustomDropDown(
              label: StringConfig.database.flag,
              value: circleDataController.isFlag.value,
              items: circleDataController.boolOptions,
              onChanged: (value) {
                circleDataController.isFlag.value = value;
                if (value) {
                  circleDataController.flagNameController.clear();
                }
              },
            ),
            SizeConfig.size34.height,
            CustomDropDown(
              label: StringConfig.database.mainPost,
              value: circleDataController.isMainPost.value,
              items: circleDataController.boolOptions,
              onChanged: (value) {
                circleDataController.isMainPost.value = value;
                circleDataController.mainPostId.value = "";
              },
            ),
            SizeConfig.size34.height,
            CustomDropDown(
              label: StringConfig.database.userGuide,
              value: circleDataController.userIsGuide.value,
              items: circleDataController.boolOptions,
              onChanged: (value) {
                circleDataController.userIsGuide.value = value;
              },
            ),
            if (circleDataController.isFlag.value) ...[
              SizeConfig.size34.height,
              CustomTextField(
                controller: circleDataController.flagNameController,
                label: StringConfig.reporting.flagName,
                hintText: StringConfig.circle.enterFlagName,
                validator: (p0) => Validator.emptyValidator(
                    p0 ?? "", StringConfig.reporting.flagName.toLowerCase()),
              ),
            ],
            if (circleDataController.circle.isNotEmpty &&
                !circleDataController.isMainPost.value) ...[
              SizeConfig.size34.height,
              CustomDropDown(
                label: StringConfig.circle.selectMainPostId,
                value: circleDataController.mainPostId.value.isNotEmpty
                    ? circleDataController.mainPostId.value
                    : null,
                validator: (p0) => Validator.emptyValidator(
                    p0 ?? "", StringConfig.circle.postId.toLowerCase()),
                items: circleDataController.circle
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.id ?? "",
                          style: FontTextStyleConfig.textFieldTextStyle
                              .copyWith(fontSize: FontSizeConfig.fontSize16),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  circleDataController.mainPostId.value = value;
                },
              )
            ],
          ],
        );
}
