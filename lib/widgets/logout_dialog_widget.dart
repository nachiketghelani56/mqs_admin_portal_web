import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/main.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/services/firebase_auth_service.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

logoutDialogWidget() {
  if (navigatorKey.currentState?.context != null) {
    return showDialog(
      context: navigatorKey.currentState!.context,
      builder: (context) {
        return AlertDialog(
          title: Image.asset(
            ImageConfig.logout,
            height: SizeConfig.size55,
            color: ColorConfig.primaryColor,
          ),
          content: Container(
            constraints:
                BoxConstraints(maxWidth: Get.width * SizeConfig.size0point45),
            child: Text(
              StringConfig.mqsDashboard.areYouSureYouWantToLogout,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: FontFamilyConfig.figtree,
                color: ColorConfig.primaryColor,
                fontSize: FontSizeConfig.fontSize16,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: SizeConfig.size140,
              child: CustomButton(
                btnText: StringConfig.mqsDashboard.cancel,
                isSelected: false,
                onTap: () {
                  Get.back();
                },
              ),
            ),
            SizedBox(
              width: SizeConfig.size140,
              child: CustomButton(
                btnText: StringConfig.mqsDashboard.logout,
                onTap: () async {
                  Get.back();
                  try {
                    await FirebaseAuthService.i.signOut();
                    Get.offAllNamed(AppRoutes.login);
                  } catch (e) {
                    errorDialogWidget(msg: e.toString());
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
