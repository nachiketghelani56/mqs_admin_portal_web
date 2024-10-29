import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/login/controller/login_controller.dart';
import 'package:mqs_admin_portal_web/views/login/widgets/textfields_container_widget.dart';

Widget loginDetailWidget({required LoginController loginController}) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StringConfig.login.loginToYourAccount,
          textAlign: TextAlign.center,
          style: FontTextstyleConfig.titleStyle,
        ),
        Text(
          StringConfig.login.fillBelowDetailToGetInWeb,
          textAlign: TextAlign.center,
          style: FontTextstyleConfig.subtitleStyle,
        ),
        SizeConfig.size42.height,
        textfieldsContainerWidget(loginController: loginController),
      ],
    ),
  ).center;
}
