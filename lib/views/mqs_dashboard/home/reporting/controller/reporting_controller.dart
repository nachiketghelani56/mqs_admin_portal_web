import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/chart_model.dart';

class ReportingController extends GetxController {
  RxList<String> options = [
    StringConfig.reporting.entity,
    StringConfig.reporting.unit,
    StringConfig.reporting.function,
  ].obs;
  Map<String, Color> barChartOpts = {
    StringConfig.reporting.leadership: ColorConfig.bullet1Color,
    StringConfig.reporting.management: ColorConfig.bullet2Color,
    StringConfig.reporting.team: ColorConfig.bullet3Color,
    StringConfig.reporting.employees: ColorConfig.bullet4Color,
  };
  Map<String, Color> circleChartOpts = {
    StringConfig.reporting.trainingProgram: ColorConfig.card3TextColor,
    StringConfig.reporting.leadershipSupport: ColorConfig.card2TextColor,
    StringConfig.reporting.recognitionProgram: ColorConfig.card1TextColor,
  };
  RxInt optionIndex = 0.obs;
  RxList<ChartModel> indicatorCharData = [
    ChartModel(StringConfig.reporting.advocacy, 6),
    ChartModel(StringConfig.reporting.awareness, 9),
    ChartModel(StringConfig.reporting.acceptance, 3),
    ChartModel(StringConfig.reporting.aptitude, 4),
    ChartModel(StringConfig.reporting.adoption, 8)
  ].obs;
}
