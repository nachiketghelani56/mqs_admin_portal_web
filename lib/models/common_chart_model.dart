import 'package:mqs_admin_portal_web/models/reflections_model.dart';
import 'package:mqs_admin_portal_web/models/activity_model.dart';

class ChartData {
  final String type;
  final String month;
  final int count;

  ChartData({required this.type, required this.month, required this.count});
}

class CommonChartModel {
  final String id;
  final String title;
  final String type;
  final String timestamp;

  CommonChartModel({
    required this.id,
    required this.title,
    required this.type,
    required this.timestamp,
  });

  factory CommonChartModel.fromActivityModel(ActivityModel chartModel) {
    return CommonChartModel(
      id: chartModel.id,
      title: chartModel.mqsEntityTitle,
      type: chartModel.mqsActivityType,
      timestamp: chartModel.mqsTimestamp,
    );
  }

  factory CommonChartModel.fromReflectionsModel(
      ReflectionsModel reflectionsModel) {
    return CommonChartModel(
      id: reflectionsModel.id,
      title: reflectionsModel.mqsRefTitle,
      type: reflectionsModel.mqsReflectType,
      timestamp: reflectionsModel.mqsTimestamp,
    );
  }
}
