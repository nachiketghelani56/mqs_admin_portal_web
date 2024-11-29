import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/login/controller/login_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';

Widget loginFormWidget({required LoginController loginController}) {
  return Form(
    key: loginController.formKey,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          ImageConfig.appLogo,
          height:SizeConfig.size65,
          color: ColorConfig.primaryColor,
        ),
        // logoWidget(mainAxisSize: MainAxisSize.min),
        SizeConfig.size50.height,
        CustomTextField(
          uniqueKey: UniqueKey(),
          controller: loginController.emailController,
          autofillHints: const [],
          label: StringConfig.login.emailID,
          validator: (p0) => Validator.emailValidator(
              p0 ?? "", StringConfig.dashboard.emailAddressText),
        ),
        SizeConfig.size24.height,
        Obx(
          () => CustomTextField(
            uniqueKey: UniqueKey(),
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
            validator: (p0) => Validator.passwordValidator(
                p0 ?? "", StringConfig.firebase.password),
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
