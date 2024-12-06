import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/common_chart_model.dart';
import 'package:mqs_admin_portal_web/models/reflections_model.dart';
import 'package:mqs_admin_portal_web/models/activity_model.dart';

class TeamChartController extends GetxController {
  Map<String, Color> teamDevOpts = {
    StringConfig.teamChart.learn: ColorConfig.bullet1Color,
    StringConfig.teamChart.practice: ColorConfig.bullet5Color,
    StringConfig.teamChart.reflect: ColorConfig.bullet6Color,
  };
  final Map<String, Color> typeColors = {
    StringConfig.teamChart.learn.toUpperCase(): ColorConfig.bullet1Color,
    StringConfig.teamChart.prac: ColorConfig.chartColor,
    StringConfig.teamChart.ref: ColorConfig.bullet6Color,
  };
  RxList<String> allTypes = [
    StringConfig.teamChart.learn.toUpperCase(),
    StringConfig.teamChart.prac,
    StringConfig.teamChart.ref
  ].obs;
  List<ChartData> get chartData => prepareChartData();
  RxList<CommonChartModel> devCharData = [
    CommonChartModel.fromActivityModel(
      ActivityModel(
        id: "1",
        mqsUserID: "user1",
        mqsEntityId: "entity1",
        mqsEntityTitle: "Entity Title 1",
        mqsActivityType: "PRAC",
        mqsTimestamp: "2024-08-10T16:41:22.950889",
      ),
    ),
    CommonChartModel.fromActivityModel(
      ActivityModel(
        id: "2",
        mqsUserID: "user2",
        mqsEntityId: "entity2",
        mqsEntityTitle: "Entity Title 2",
        mqsActivityType: "LEARN",
        mqsTimestamp: "2024-06-11T16:41:22.950889",
      ),
    ),
    CommonChartModel.fromActivityModel(
      ActivityModel(
        id: "3",
        mqsUserID: "user3",
        mqsEntityId: "entity3",
        mqsEntityTitle: "Entity Title 3",
        mqsActivityType: "PRAC",
        mqsTimestamp: "2024-08-10T16:41:22.950889",
      ),
    ),
    CommonChartModel.fromReflectionsModel(
      ReflectionsModel(
        id: "4",
        mqsRefPrompt: "Prompt 4",
        mqsRefTitle: "Reflection Title 4",
        mqsReflectType: "REF",
        mqsReflection: "This is a reflection.",
        mqsTimestamp: "2024-08-10T16:41:22.950889",
      ),
    ),
    CommonChartModel.fromReflectionsModel(
      ReflectionsModel(
        id: "5",
        mqsRefPrompt: "Prompt 5",
        mqsRefTitle: "Reflection Title 5",
        mqsReflectType: "REF",
        mqsReflection: "This is a reflection.",
        mqsTimestamp: "2024-06-11T16:41:22.950889",
      ),
    ),
    CommonChartModel.fromReflectionsModel(
      ReflectionsModel(
        id: "6",
        mqsRefPrompt: "Prompt 6",
        mqsRefTitle: "Reflection Title 6",
        mqsReflectType: "REF",
        mqsReflection: "This is a reflection.",
        mqsTimestamp: "2024-08-10T16:41:22.950889",
      ),
    ),
    CommonChartModel.fromActivityModel(
      ActivityModel(
        id: "7",
        mqsUserID: "user7",
        mqsEntityId: "entity7",
        mqsEntityTitle: "Entity Title 7",
        mqsActivityType: "LEARN",
        mqsTimestamp: "2024-08-11T16:41:22.950889",
      ),
    ),
    CommonChartModel.fromActivityModel(
      ActivityModel(
        id: "8",
        mqsUserID: "user8",
        mqsEntityId: "entity8",
        mqsEntityTitle: "Entity Title 8",
        mqsActivityType: "PRAC",
        mqsTimestamp: "2024-06-10T16:41:22.950889",
      ),
    ),
    CommonChartModel.fromActivityModel(
      ActivityModel(
        id: "9",
        mqsUserID: "user9",
        mqsEntityId: "entity9",
        mqsEntityTitle: "Entity Title 9",
        mqsActivityType: "PRAC",
        mqsTimestamp: "2024-06-10T16:41:22.950889",
      ),
    ),
    CommonChartModel.fromReflectionsModel(
      ReflectionsModel(
        id: "10",
        mqsRefPrompt: "Prompt 10",
        mqsRefTitle: "Reflection Title 10",
        mqsReflectType: "REF",
        mqsReflection: "This is a reflection.",
        mqsTimestamp: "2024-08-10T16:41:22.950889",
      ),
    ),
    CommonChartModel.fromReflectionsModel(
      ReflectionsModel(
        id: "11",
        mqsRefPrompt: "Prompt 11",
        mqsRefTitle: "Reflection Title 11",
        mqsReflectType: "REF",
        mqsReflection: "This is a reflection.",
        mqsTimestamp: "2024-07-11T16:41:22.950889",
      ),
    ),
    CommonChartModel.fromActivityModel(
      ActivityModel(
        id: "12",
        mqsUserID: "user12",
        mqsEntityId: "entity12",
        mqsEntityTitle: "Entity Title 12",
        mqsActivityType: "PRAC",
        mqsTimestamp: "2024-07-10T16:41:22.950889",
      ),
    ),
    CommonChartModel.fromActivityModel(
      ActivityModel(
        id: "13",
        mqsUserID: "user13",
        mqsEntityId: "entity13",
        mqsEntityTitle: "Entity Title 13",
        mqsActivityType: "LEARN",
        mqsTimestamp: "2024-07-10T16:41:22.950889",
      ),
    ),
  ].obs;

  List<ChartData> prepareChartData() {
    final Map<String, Map<String, int>> groupedData = {};
    devCharData.sort((a, b) =>
        DateTime.parse(a.timestamp).compareTo(DateTime.parse(b.timestamp)));
    for (var item in devCharData) {
      // Determine the type and month
      String type = item.type;
      String month = DateFormat(StringConfig.teamChart.dateMMMYYYY)
          .format(DateTime.parse(item.timestamp));
      // Initialize group if not exists
      if (groupedData[type] == null) {
        groupedData[type] = {};
      }
      // Initialize the month if not exists
      groupedData[type]?[month] = (groupedData[type]?[month] ?? 0) + 1;
    }
    // Convert to ChartData
    List<ChartData> chartData = [];
    groupedData.forEach((type, monthData) {
      monthData.forEach((month, count) {
        chartData.add(ChartData(type: type, month: month, count: count));
      });
    });
    return chartData;
  }
}
