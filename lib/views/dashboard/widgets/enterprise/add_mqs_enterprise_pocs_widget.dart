import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addMqsEnterprisePOCsWidget(
    {required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsEnterprisePOCs,
        showArrowIcon: false,
      ),
      SizeConfig.size30.height,
      CustomTextField(
        controller: dashboardController.pocNameController,
        label: StringConfig.dashboard.name,
        hintText: StringConfig.dashboard.enterName,
        validator: (p0) =>
            Validator.emptyValidator(p0 ?? "", StringConfig.dashboard.name),
      ),
      SizeConfig.size34.height,
      Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: dashboardController.pocEmailController,
              label: StringConfig.dashboard.emailAddress,
              hintText: StringConfig.dashboard.enterEmailAddress,
              validator: (p0) => Validator.emailValidator(p0 ?? ""),
            ),
          ),
        ],
      ),
      SizeConfig.size34.height,
      CustomTextField(
        controller: dashboardController.pocAddressController,
        label: StringConfig.dashboard.address,
        hintText: StringConfig.dashboard.enterAddress,
        validator: (p0) =>
            Validator.emptyValidator(p0 ?? "", StringConfig.dashboard.address),
      ),
      SizeConfig.size34.height,
      CustomTextField(
        controller: dashboardController.pocWebsiteController,
        label: StringConfig.dashboard.website,
        hintText: StringConfig.dashboard.enterWebsite,
        validator: (p0) =>
            Validator.emptyValidator(p0 ?? "", StringConfig.dashboard.website),
      ),
      SizeConfig.size34.height,
      CustomTextField(
        controller: dashboardController.pocTypeController,
        label: StringConfig.dashboard.type,
        hintText: StringConfig.dashboard.enterType,
        validator: (p0) =>
            Validator.emptyValidator(p0 ?? "", StringConfig.dashboard.type),
      ),
      SizeConfig.size34.height,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomTextField(
              controller: dashboardController.pocPhoneNumberController,
              label: StringConfig.dashboard.phoneNumber,
              hintText: StringConfig.dashboard.enterPhoneNumber,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.dashboard.phoneNumber),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
          ),
          SizeConfig.size24.width,
          Expanded(
            child: CustomTextField(
              controller: dashboardController.pocPinCodeController,
              label: StringConfig.dashboard.pinCode,
              hintText: StringConfig.dashboard.enterPinCode,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.dashboard.pinCode),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
