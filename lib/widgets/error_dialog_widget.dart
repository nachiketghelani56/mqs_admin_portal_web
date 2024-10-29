import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/main.dart';
import 'package:mqs_admin_portal_web/widgets/custom_button.dart';

errorDialogWidget({required String msg}) {
  if (navigatorKey.currentState?.context != null) {
    return showDialog(
      context: navigatorKey.currentState!.context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            constraints:
                BoxConstraints(maxWidth: Get.width * SizeConfig.size0point45),
            child: Text(
              msg,
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
                btnText: StringConfig.ok,
                onTap: () {
                  Get.back();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
