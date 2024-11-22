import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/menu_model.dart';

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxList<MenuModel> options = [
    MenuModel(
      icon: ImageConfig.onboarding,
      title: StringConfig.mqsDashboard.onboarding,
    ),
    MenuModel(
      icon: ImageConfig.communication,
      title: StringConfig.mqsDashboard.communication,
    ),
    MenuModel(
      icon: ImageConfig.training,
      title: StringConfig.mqsDashboard.training,
    ),
    MenuModel(
      icon: ImageConfig.survey,
      title: StringConfig.mqsDashboard.survey,
    ),
    MenuModel(
      icon: ImageConfig.reporting,
      title: StringConfig.mqsDashboard.reporting,
    ),
  ].obs;
  RxList<MenuModel> profileOpts = [
    MenuModel(
      icon: ImageConfig.profile,
      title: StringConfig.mqsDashboard.profile,
    ),
    MenuModel(
      icon: ImageConfig.settings,
      title: StringConfig.mqsDashboard.settings,
    ),
    MenuModel(
      icon: ImageConfig.logout,
      title: StringConfig.mqsDashboard.logout,
    ),
  ].obs;
}
