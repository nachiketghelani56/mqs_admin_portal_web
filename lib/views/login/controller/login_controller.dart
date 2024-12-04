import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/services/firebase_auth_service.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = ObscuringTextEditingController();
  RxBool isObscurePassword = true.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  login() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        showLoader();
        User? user = await FirebaseAuthService.i.signInWithEmailPassword(
            email: emailController.text.trim(),
            password: passwordController.text);
        hideLoader();
        if (user != null) {
          Get.offAllNamed(AppRoutes.mqsDashboard);
        }
      }
    } on FirebaseAuthException catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.message ?? e.toString());
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }
}

class ObscuringTextEditingController extends TextEditingController {
  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
        TextStyle? style,
        required bool withComposing}) {
    String obscuredText =
    text.replaceAll(RegExp(r"."), "•"); // Replace characters with bullets
    return TextSpan(text: obscuredText, style: style);
  }
}
