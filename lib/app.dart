import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/main.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/services/firebase_auth_service.dart';

class MQSAdminPortalWeb extends StatelessWidget {
  const MQSAdminPortalWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: StringConfig.mqsAdminPortalWeb,
      defaultTransition: Transition.fadeIn,
      scrollBehavior: const MaterialScrollBehavior().copyWith(overscroll: false,
        dragDevices: {PointerDeviceKind.mouse},
      ),
      theme: ThemeData.light(useMaterial3: true).copyWith(
        appBarTheme: const AppBarTheme(centerTitle: false),
        dialogBackgroundColor: ColorConfig.whiteColor,
        cardColor: ColorConfig.whiteColor,
        scaffoldBackgroundColor: ColorConfig.whiteColor,
        colorScheme: const ColorScheme.light(
          primary: ColorConfig.primaryColor,
          surfaceTint: ColorConfig.whiteColor,
          error: ColorConfig.errorColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuthService.i.user != null
          ? AppRoutes.mqsDashboard
          : AppRoutes.login,
      // initialRoute: AppRoutes.mqsDashboard,
      getPages: AppRoutes.pages,
    );
  }
}
