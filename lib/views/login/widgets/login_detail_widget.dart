import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/login/controller/login_controller.dart';
import 'package:mqs_admin_portal_web/views/login/widgets/text_fields_container_widget.dart';

Widget loginDetailWidget({required LoginController loginController}) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StringConfig.login.loginToYourAccount,
          textAlign: TextAlign.center,
          style: FontTextStyleConfig.titleStyle,
        ),
        Text(
          StringConfig.login.fillBelowDetailToGetInWeb,
          textAlign: TextAlign.center,
          style: FontTextStyleConfig.subtitleStyle,
        ),
        SizeConfig.size42.height,
        textFieldsContainerWidget(loginController: loginController),
      ],
    ),
  ).center;
}
