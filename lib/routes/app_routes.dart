import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/views/add_circle/add_circle_screen.dart';
import 'package:mqs_admin_portal_web/views/add_enterprise/add_enterprise_screen.dart';
import 'package:mqs_admin_portal_web/views/add_pathway/add_pathway_screen.dart';
import 'package:mqs_admin_portal_web/views/auth_summary/auth_summary_screen.dart';
import 'package:mqs_admin_portal_web/views/circle_detail/circle_detail_screen.dart';
import 'package:mqs_admin_portal_web/views/enterprise_detail/enterprise_detail_screen.dart';
import 'package:mqs_admin_portal_web/views/login/login_screen.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/circle_summary_detail_screen.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/subscription_summary_detail_screen.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/mqs_dashboard_screen.dart';
import 'package:mqs_admin_portal_web/views/ob_summary/ob_summary_screen.dart';
import 'package:mqs_admin_portal_web/views/pathway_detail/pathway_detail_screen.dart';
import 'package:mqs_admin_portal_web/views/user_iam_detail/user_iam_detail_screen.dart';

class AppRoutes {
  static const String login = "/login";
  static const String dashboard = "/dashboard";
  static const String enterpriseDetail = "/enterprise_detail";
  static const String addEnterprise = "/add_enterprise";
  static const String userIAMDetail = "/user_iam_detail";
  static const String mqsDashboard = "/mqs_dashboard";
  static const String circleDetail = "/circle_detail";
  static const String addCircle = "/add_circle";
  static const String pathwayDetail = "/pathway_detail";
  static const String addPathway = "/add_pathway";
  static const String authSummary = "/auth_summary";
  static const String obSummary = "/ob_summary";
  static const String circleSummaryDetailScreen = "/circle_summary_detail_screen";
  static const String subscriptionSummaryDetailScreen = "/subscription_summary_detail_screen";

  static List<GetPage> get pages => [
        GetPage(name: AppRoutes.login, page: () => LoginScreen()),
        // GetPage(name: AppRoutes.dashboard, page: () => DashboardScreen()),
        GetPage(
            name: AppRoutes.enterpriseDetail,
            page: () => EnterpriseDetailScreen()),
        GetPage(
            name: AppRoutes.addEnterprise, page: () => AddEnterpriseScreen()),
        GetPage(
            name: AppRoutes.userIAMDetail, page: () => UserIAMDetailScreen()),
        GetPage(name: AppRoutes.mqsDashboard, page: () => MqsDashboardScreen()),
        GetPage(name: AppRoutes.circleDetail, page: () => CircleDetailScreen()),
        GetPage(name: AppRoutes.addCircle, page: () => AddCircleScreen()),
        GetPage(
            name: AppRoutes.pathwayDetail, page: () => PathwayDetailScreen()),
        GetPage(name: AppRoutes.addPathway, page: () => AddPathwayScreen()),
        GetPage(name: AppRoutes.authSummary, page: () => AuthSummaryScreen()),
        GetPage(name: AppRoutes.obSummary, page: () => OBSummaryScreen()),
        GetPage(name: AppRoutes.circleSummaryDetailScreen, page: () => CircleSummaryDetailScreen()),
        GetPage(name: AppRoutes.subscriptionSummaryDetailScreen, page: () => SubscriptionSummaryDetailScreen()),
      ];
}
