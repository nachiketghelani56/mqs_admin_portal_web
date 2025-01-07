class MqsTeamModel {
  String? mqsCreatedTimestamp;
  String? mqsOrganizationID;
  String? mqsTeamEmail;
  String? mqsTeamID;
  String? mqsTeamName;
  String? mqsUpdatedTimestamp;

  List<MqsTeamMemberDetails>? mqsTeamMemberDetails;

  MqsTeamModel({
    this.mqsCreatedTimestamp,
    this.mqsOrganizationID,
    this.mqsTeamEmail,
    this.mqsTeamID,
    this.mqsTeamName,
    this.mqsUpdatedTimestamp,
    this.mqsTeamMemberDetails,
  });

  MqsTeamModel.fromJson(Map<String, dynamic> json) {
    mqsCreatedTimestamp = json['mqsCreatedTimestamp'] ?? "";
    mqsOrganizationID = json['mqsOrganizationID'] ?? "";
    mqsTeamEmail = json['mqsTeamEmail'] ?? "";
    mqsTeamID = json['mqsTeamID'] ?? "";
    mqsTeamName = json['mqsTeamName'] ?? "";
    mqsUpdatedTimestamp = json['mqsUpdatedTimestamp'] ?? "";

    if (json['mqsTeamMemberDetails'] != null) {
      mqsTeamMemberDetails = <MqsTeamMemberDetails>[];
      json['mqsTeamMemberDetails'].forEach((v) {
        mqsTeamMemberDetails!.add(MqsTeamMemberDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mqsCreatedTimestamp'] = mqsCreatedTimestamp;
    data['mqsOrganizationID'] = mqsOrganizationID;
    data['mqsTeamEmail'] = mqsTeamEmail;
    data['mqsTeamID'] = mqsTeamID;
    data['mqsTeamName'] = mqsTeamName;
    data['mqsUpdatedTimestamp'] = mqsUpdatedTimestamp;

    if (mqsTeamMemberDetails != null) {
      data['mqsTeamMemberDetails'] =
          mqsTeamMemberDetails?.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class MqsTeamMemberDetails {
  String? mqsTeamMemberEmail;
  String? mqsTeamMemberID;
  String? mqsTeamMemberName;

  MqsTeamMemberDetails(
      {this.mqsTeamMemberEmail, this.mqsTeamMemberID, this.mqsTeamMemberName});

  MqsTeamMemberDetails.fromJson(Map<String, dynamic> json) {
    mqsTeamMemberEmail = json['mqsTeamMemberEmail'] ?? "";
    mqsTeamMemberID = json['mqsTeamMemberID'] ?? "";
    mqsTeamMemberName = json['mqsTeamMemberName'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mqsTeamMemberEmail'] = mqsTeamMemberEmail;
    data['mqsTeamMemberID'] = mqsTeamMemberID;
    data['mqsTeamMemberName'] = mqsTeamMemberName;
    return data;
  }
}
