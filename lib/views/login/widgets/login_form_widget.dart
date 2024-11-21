import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/login/controller/login_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';
import 'package:mqs_admin_portal_web/widgets/logo_widget.dart';

Widget loginFormWidget({required LoginController loginController}) {
  return Form(
    key: loginController.formKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        logoWidget(mainAxisSize: MainAxisSize.min),
        SizeConfig.size50.height,
        CustomTextField(
          controller: loginController.emailController,
          autofillHints: const [],
          label: StringConfig.login.emailID,
          validator: (p0) => Validator.emailValidator(p0 ?? ""),
        ),
        SizeConfig.size24.height,
        Obx(
          () => CustomTextField(
            controller: loginController.passwordController,
            autofillHints: const [],
            label: StringConfig.login.password,
            suffixIcon: loginController.isObscurePassword.value
                ? ImageConfig.eyeOpened
                : ImageConfig.eyeClosed,
            isObscure: loginController.isObscurePassword.value,
            onSuffixIconTap: () {
              loginController.isObscurePassword.value =
                  !loginController.isObscurePassword.value;
            },
            validator: (p0) => Validator.passwordValidator(p0 ?? ""),
          ),
        ),
        SizeConfig.size40.height,
        CustomButton(
          btnText: StringConfig.login.login,
          onTap: () {
            loginController.login();
          },
        ),
      ],
    ),
  );
}
