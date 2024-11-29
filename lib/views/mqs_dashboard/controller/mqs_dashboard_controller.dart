import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/menu_model.dart';

class MqsDashboardController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  List<MenuModel> menuItems = [
    MenuModel(
      icon: ImageConfig.home,
      title: StringConfig.mqsDashboard.home,
      subtitles: [
        StringConfig.dashboard.enterprise,
        StringConfig.dashboard.userIAM,
        StringConfig.teamChart.teamChart,
        StringConfig.mqsDashboard.reporting,
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
