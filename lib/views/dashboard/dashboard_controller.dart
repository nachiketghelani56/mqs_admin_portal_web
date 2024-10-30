import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';

class DashboardController extends GetxController {
  RxList<String> tabs = [
    StringConfig.dashboard.enterprise,
    StringConfig.dashboard.userIAM,
  ].obs;
  RxInt selectedTabIndex = 0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final TextEditingController searchController = TextEditingController();
}
