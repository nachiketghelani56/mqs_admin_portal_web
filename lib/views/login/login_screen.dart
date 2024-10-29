import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/login/controller/login_controller.dart';
import 'package:mqs_admin_portal_web/views/login/widgets/login_detail_widget.dart';
import 'package:mqs_admin_portal_web/widgets/logo_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            logoWidget(),
            Expanded(
              child: loginDetailWidget(loginController: _loginController),
            ),
          ],
        ).paddingSymmetric(
            horizontal: SizeConfig.size40, vertical: SizeConfig.size25),
      ),
    );
  }
}
