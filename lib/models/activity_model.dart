// ChartModel definition
class ActivityModel {
  final String id;
  final String mqsUserID;
  final String mqsEntityId;
  final String mqsEntityTitle;
  final String mqsActivityType;
  final String mqsTimestamp;

  ActivityModel({
    required this.id,
    required this.mqsUserID,
    required this.mqsEntityId,
    required this.mqsEntityTitle,
    required this.mqsActivityType,
    required this.mqsTimestamp,
  });
}
