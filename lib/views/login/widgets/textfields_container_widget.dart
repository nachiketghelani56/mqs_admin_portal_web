import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/login/controller/login_controller.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/custom_text_field.dart';

Widget textfieldsContainerWidget({required LoginController loginController}) {
  return Container(
    width: SizeConfig.size574,
    decoration: BoxDecoration(
      color: ColorConfig.bgColor,
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(
        horizontal: SizeConfig.size37, vertical: SizeConfig.size40),
    child: Form(
      key: loginController.formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: loginController.emailController,
            label: StringConfig.login.emailID,
            validator: (p0) => Validator.emailValidator(p0 ?? ""),
          ),
          SizeConfig.size50.height,
          Obx(
            () => CustomTextField(
              controller: loginController.passwordController,
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
          SizeConfig.size60.height,
          CustomButton(
            btnText: StringConfig.login.login,
            onTap: () {
              loginController.login();
            },
          ),
        ],
      ),
    ),
  );
}
