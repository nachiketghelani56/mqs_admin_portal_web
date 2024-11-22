import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/main.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return const Center(
      child: SizedBox(
        height: SizeConfig.size100,
        width: SizeConfig.size100,
        child: CircularProgressIndicator(
          color: ColorConfig.hoverColor,
          strokeWidth: SizeConfig.size2,
        ),
      ),
    );
  }
}

showLoader() => navigatorKey.currentState != null
    ? showDialog(
        context: navigatorKey.currentState!.context,
        builder: (context) => const LoaderWidget(),
        barrierDismissible: false)
    : null;

hideLoader() => Get.back();
