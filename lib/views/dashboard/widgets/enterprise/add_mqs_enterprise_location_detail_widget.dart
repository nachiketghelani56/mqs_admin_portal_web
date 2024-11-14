import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/title_widget.dart';

Widget addMqsEnterpriseLocationDetailWidget(
    {required DashboardController dashboardController}) {
  return Column(
    children: [
      titleWidget(
        title: StringConfig.dashboard.mqsEnterpriseLocationDetails,
        showArrowIcon: false,
      ),
      SizeConfig.size30.height,
      Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: dashboardController.addressController,
              label: StringConfig.dashboard.address,
              hintText: StringConfig.dashboard.enterAddress,
              validator: (p0) => Validator.emptyValidator(
                  p0 ?? "", StringConfig.dashboard.address),
            ),
          ),
        ],
      ),
      SizeConfig.size34.height,
      Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: dashboardController.pinCodeController,
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
