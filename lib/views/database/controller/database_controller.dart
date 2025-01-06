import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/menu_model.dart';

class DatabaseController extends GetxController {
  RxList<MenuModel> options = [
    MenuModel(
      title: StringConfig.dashboard.enterprise,
      icon: ImageConfig.enterpriseDatabase,
    ),
    MenuModel(
      title: StringConfig.dashboard.users,
      icon: ImageConfig.userDatabase,
    ),
    MenuModel(
      title: StringConfig.dashboard.circle,
      icon: ImageConfig.circleDatabase,
    ),
    MenuModel(
      title: StringConfig.mqsDashboard.pathway,
      icon: ImageConfig.pathwayDatabase,
    ),
    MenuModel(
      title: StringConfig.dashboard.team,
      icon: ImageConfig.teamDatabase,
    ),
    MenuModel(
      title: StringConfig.database.circleFlaggedPost,
      icon: ImageConfig.postDatabase,
    ),
    MenuModel(
      title: StringConfig.database.subscriptionReceipt,
      icon: ImageConfig.subscribeDatabase,
    ),
  ].obs;
}
