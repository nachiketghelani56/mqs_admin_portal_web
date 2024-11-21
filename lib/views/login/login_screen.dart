import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/views/login/controller/login_controller.dart';
import 'package:mqs_admin_portal_web/views/login/widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.backgroundColor,
      body: Container(
        width: SizeConfig.size574,
        decoration: FontTextStyleConfig.cardDecoration,
        padding: const EdgeInsets.all(SizeConfig.size34),
        child: SingleChildScrollView(
          child: loginFormWidget(loginController: _loginController),
        ),
      ).center,
    );
  }
}
