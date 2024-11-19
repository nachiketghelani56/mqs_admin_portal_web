import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/chart_model.dart';

class TeamChartController extends GetxController {
  Map<String, Color> teamDevOpts = {
    StringConfig.teamChart.learn: ColorConfig.bullet1Color,
    StringConfig.teamChart.practice: ColorConfig.bullet5Color,
    StringConfig.teamChart.reflect: ColorConfig.bullet6Color,
  };
  RxList<ChartModel> devCharData = [
    ChartModel(StringConfig.reporting.may, 4.5, y2: 7, y3: 3),
    ChartModel(StringConfig.reporting.june, 6, y2: 9, y3: 6.2),
    ChartModel(StringConfig.reporting.july, 6.7, y2: 6.8, y3: 3),
  ].obs;
}
