import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/views/add_enterprise/add_enterprise_screen.dart';
import 'package:mqs_admin_portal_web/views/dashboard/dashboard_screen.dart';
import 'package:mqs_admin_portal_web/views/enterprise_detail/enterprise_detail_screen.dart';
import 'package:mqs_admin_portal_web/views/login/login_screen.dart';
import 'package:mqs_admin_portal_web/views/user_iam_detail/user_iam_detail_screen.dart';

class AppRoutes {
  static const String login = "/login";
  static const String dashboard = "/dashboard";
  static const String enterpriseDetail = "/enterprise_detail";
  static const String addEnterprise = "/add_enterprise";
  static const String userIAMDetail = "/user_iam_detail";

  static List<GetPage> get pages => [
        GetPage(name: AppRoutes.login, page: () => LoginScreen()),
        GetPage(name: AppRoutes.dashboard, page: () => DashboardScreen()),
        GetPage(
            name: AppRoutes.enterpriseDetail,
            page: () => EnterpriseDetailScreen()),
        GetPage(
            name: AppRoutes.addEnterprise, page: () => AddEnterpriseScreen()),
        GetPage(
            name: AppRoutes.userIAMDetail, page: () => UserIAMDetailScreen()),
      ];
}
