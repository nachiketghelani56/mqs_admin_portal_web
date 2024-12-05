import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_drop_down.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addCircleFormWidget({required CircleController circleController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.circle.circleInformation,
        showArrowIcon: false,
      ),
      SizeConfig.size30.height,
      CustomTextField(
        controller: circleController.postTitleController,
        label: StringConfig.reporting.postTitle,
        hintText: StringConfig.circle.enterPostTitle,
        validator: (p0) => Validator.emptyValidator(
            p0 ?? "", StringConfig.reporting.postTitle.toLowerCase()),
      ),
      SizeConfig.size34.height,
      CustomTextField(
        controller: circleController.postContentController,
        label: StringConfig.reporting.postContent,
        hintText: StringConfig.circle.enterPostContent,
        validator: (p0) => Validator.emptyValidator(
            p0 ?? "", StringConfig.reporting.postContent.toLowerCase()),
      ),
      SizeConfig.size34.height,
      CustomTextField(
        controller: circleController.postViewController,
        label: StringConfig.reporting.postViews,
        hintText: StringConfig.circle.enterPostView,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (p0) => Validator.emptyValidator(
            p0 ?? "", StringConfig.reporting.postViews.toLowerCase()),
      ),
      SizeConfig.size34.height,
      CustomDropDown(
        label: StringConfig.reporting.isFlag,
        value: circleController.isFlag.value,
        items: circleController.boolOptions,
        onChanged: (value) {
          circleController.isFlag.value = value;
          if (value) {
            circleController.flagNameController.clear();
          }
        },
      ),
      if (circleController.isFlag.value) ...[
        SizeConfig.size34.height,
        CustomTextField(
          controller: circleController.flagNameController,
          label: StringConfig.reporting.flagName,
          hintText: StringConfig.circle.enterFlagName,
          validator: (p0) => Validator.emptyValidator(
              p0 ?? "", StringConfig.reporting.flagName.toLowerCase()),
        ),
      ],
      SizeConfig.size34.height,
      Row(
        children: [
          Expanded(
            child: CustomDropDown(
              label: StringConfig.reporting.isMainPost,
              value: circleController.isMainPost.value,
              items: circleController.boolOptions,
              onChanged: (value) {
                circleController.isMainPost.value = value;
              },
            ),
          ),
          SizeConfig.size15.width,
          Expanded(
            child: CustomDropDown(
              label: StringConfig.reporting.userIsGuide,
              value: circleController.userIsGuide.value,
              items: circleController.boolOptions,
              onChanged: (value) {
                circleController.userIsGuide.value = value;
              },
            ),
          ),
        ],
      ),
    ],
  );
}
