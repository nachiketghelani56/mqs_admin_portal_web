import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/views/login/login_screen.dart';

class AppRoutes {
  static const String login = "/login";
  static const String dashboard = "/dashboard";

  static List<GetPage> get pages => [
        GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
      ];
}
