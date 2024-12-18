import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/menu_model.dart';
import 'package:mqs_admin_portal_web/services/firebase_auth_service.dart';

class MqsDashboardController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  List<MenuModel> menuItems = [
    MenuModel(
      icon: ImageConfig.home,
      title: StringConfig.mqsDashboard.home,
      subtitles: FirebaseAuthService.i.isMarketingUser
          ? [StringConfig.mqsDashboard.reports]
          : [
              StringConfig.dashboard.enterprise,
              StringConfig.dashboard.users,
              StringConfig.dashboard.circle,
              StringConfig.mqsDashboard.pathway,
              StringConfig.teamChart.teamChart,
              StringConfig.mqsDashboard.reports,
            ],
    ),
  ].obs;
  RxInt menuIndex = 0.obs, subMenuIndex = RxInt(-1);
  RxBool isShowHome = false.obs;

  @override
  void onInit() {
    isShowHome.value = true;
    super.onInit();
  }
}
