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
        StringConfig.mqsDashboard.pathway,
        StringConfig.mqsDashboard.challenge,
        StringConfig.teamChart.teamChart,
        StringConfig.mqsDashboard.reporting,
      ],
    ),
    MenuModel(
      icon: ImageConfig.documents,
      title: StringConfig.mqsDashboard.documents,
    ),
    MenuModel(
      icon: ImageConfig.profile,
      title: StringConfig.mqsDashboard.profile,
    ),
    MenuModel(
      icon: ImageConfig.settings,
      title: StringConfig.mqsDashboard.settings,
    ),
  ].obs;
  RxInt menuIndex = 0.obs, subMenuIndex = RxInt(-1);
}
