class EnterpriseModel {
  final MqsEnterprisePOCs mqsEnterprisePOCs;
  final String mqsEnterpriseCode;
  final bool mqsIsTeam;
  final List<MqsTeam> mqsTeamList;
  final List<MqsEmployee> mqsEmployeeList;
  final MqsEnterprisePOCsSubscriptionDetails
      mqsEnterprisePOCsSubscriptionDetails;
  final String mqsCreatedTimestamp;
  final String mqsUpdateTimestamp;

  EnterpriseModel({
    required this.mqsEnterprisePOCs,
    required this.mqsEnterpriseCode,
    required this.mqsIsTeam,
    required this.mqsTeamList,
    required this.mqsEmployeeList,
    required this.mqsEnterprisePOCsSubscriptionDetails,
    required this.mqsCreatedTimestamp,
    required this.mqsUpdateTimestamp,
  });

  factory EnterpriseModel.fromJson(Map<String, dynamic> json) {
    return EnterpriseModel(
      mqsEnterprisePOCs: MqsEnterprisePOCs.fromJson(json['mqsEnterprisePOCs']),
      mqsEnterpriseCode: json['mqsEnterpriseCode'],
      mqsIsTeam: json['mqsIsTeam'],
      mqsTeamList: (json['mqsTeamList'] as List)
          .map((team) => MqsTeam.fromJson(team))
          .toList(),
      mqsEmployeeList: (json['mqsEmployeeList'] as List)
          .map((employee) => MqsEmployee.fromJson(employee))
          .toList(),
      mqsEnterprisePOCsSubscriptionDetails:
          MqsEnterprisePOCsSubscriptionDetails.fromJson(
              json['mqsEnterprisePOCsSubscriptionDetails']),
      mqsCreatedTimestamp: json['mqsCreatedTimestamp'],
      mqsUpdateTimestamp: json['mqsUpdateTimestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mqsEnterprisePOCs': mqsEnterprisePOCs.toJson(),
      'mqsEnterpriseCode': mqsEnterpriseCode,
      'mqsIsTeam': mqsIsTeam,
      'mqsTeamList': mqsTeamList.map((team) => team.toJson()).toList(),
      'mqsEmployeeList':
          mqsEmployeeList.map((employee) => employee.toJson()).toList(),
      'mqsEnterprisePOCsSubscriptionDetails':
          mqsEnterprisePOCsSubscriptionDetails.toJson(),
      'mqsCreatedTimestamp': mqsCreatedTimestamp,
      'mqsUpdateTimestamp': mqsUpdateTimestamp,
    };
  }
}

class MqsEnterprisePOCs {
  final String mqsEnterpriseID;
  final String mqsEnterpriseName;
  final String mqsEnterpriseEmail;
  final String mqsEnterprisePhoneNumber;
  final String mqsEnterpriseType;
  final String mqsEnterpriseWebsite;
  final String mqsEnterpriseAddress;
  final String mqsEnterprisePincode;
  final bool mqsIsSignUp;

  MqsEnterprisePOCs({
    required this.mqsEnterpriseID,
    required this.mqsEnterpriseName,
    required this.mqsEnterpriseEmail,
    required this.mqsEnterprisePhoneNumber,
    required this.mqsEnterpriseType,
    required this.mqsEnterpriseWebsite,
    required this.mqsEnterpriseAddress,
    required this.mqsEnterprisePincode,
    required this.mqsIsSignUp,
  });

  factory MqsEnterprisePOCs.fromJson(Map<String, dynamic> json) {
    return MqsEnterprisePOCs(
      mqsEnterpriseID: json['mqsEnterpriseID'],
      mqsEnterpriseName: json['mqsEnterpriseName'],
      mqsEnterpriseEmail: json['mqsEnterpriseEmail'],
      mqsEnterprisePhoneNumber: json['mqsEnterprisePhoneNumber'],
      mqsEnterpriseType: json['mqsEnterpriseType'],
      mqsEnterpriseWebsite: json['mqsEnterpriseWebsite'],
      mqsEnterpriseAddress: json['mqsEnterpriseAddress'],
      mqsEnterprisePincode: json['mqsEnterprisePincode'],
      mqsIsSignUp: json['mqsIsSignUp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mqsEnterpriseID': mqsEnterpriseID,
      'mqsEnterpriseName': mqsEnterpriseName,
      'mqsEnterpriseEmail': mqsEnterpriseEmail,
      'mqsEnterprisePhoneNumber': mqsEnterprisePhoneNumber,
      'mqsEnterpriseType': mqsEnterpriseType,
      'mqsEnterpriseWebsite': mqsEnterpriseWebsite,
      'mqsEnterpriseAddress': mqsEnterpriseAddress,
      'mqsEnterprisePincode': mqsEnterprisePincode,
      'mqsIsSignUp': mqsIsSignUp,
    };
  }
}

class MqsTeam {
  final String mqsTeamID;
  final String mqsTeamName;
  final String mqsTeamEmail;
  final int mqsTeamMembersLimit;
  final bool mqsIsEnable;

  MqsTeam({
    required this.mqsTeamID,
    required this.mqsTeamName,
    required this.mqsTeamEmail,
    required this.mqsTeamMembersLimit,
    required this.mqsIsEnable,
  });

  factory MqsTeam.fromJson(Map<String, dynamic> json) {
    return MqsTeam(
      mqsTeamID: json['mqsTeamID'],
      mqsTeamName: json['mqsTeamName'],
      mqsTeamEmail: json['mqsTeamEmail'],
      mqsTeamMembersLimit: json['mqsTeamMembersLimit'],
      mqsIsEnable: json['mqsIsEnable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mqsTeamID': mqsTeamID,
      'mqsTeamName': mqsTeamName,
      'mqsTeamEmail': mqsTeamEmail,
      'mqsTeamMembersLimit': mqsTeamMembersLimit,
      'mqsIsEnable': mqsIsEnable,
    };
  }

  int get uniqueKey => hashCode;
}

class MqsEmployee {
  final String mqsEmployeeName;
  final String mqsEmployeeEmail;
  final bool mqsIsSignUp;

  MqsEmployee({
    required this.mqsEmployeeName,
    required this.mqsEmployeeEmail,
    required this.mqsIsSignUp,
  });

  factory MqsEmployee.fromJson(Map<String, dynamic> json) {
    return MqsEmployee(
      mqsEmployeeName: json['mqsEmployeeName'],
      mqsEmployeeEmail: json['mqsEmployeeEmail'],
      mqsIsSignUp: json['mqsIsSignUp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mqsEmployeeName': mqsEmployeeName,
      'mqsEmployeeEmail': mqsEmployeeEmail,
      'mqsIsSignUp': mqsIsSignUp,
    };
  }
}

class MqsEnterprisePOCsSubscriptionDetails {
  final String mqsSubscriptionStatus;
  final String mqsSubscriptionActivePlan;
  final String mqsSubscriptionStartDate;
  final String mqsSubscriptionExpiryDate;

  MqsEnterprisePOCsSubscriptionDetails({
    required this.mqsSubscriptionStatus,
    required this.mqsSubscriptionActivePlan,
    required this.mqsSubscriptionStartDate,
    required this.mqsSubscriptionExpiryDate,
  });

  factory MqsEnterprisePOCsSubscriptionDetails.fromJson(
      Map<String, dynamic> json) {
    return MqsEnterprisePOCsSubscriptionDetails(
      mqsSubscriptionStatus: json['mqsSubscriptionStatus'],
      mqsSubscriptionActivePlan: json['mqsSubscriptionActivePlan'],
      mqsSubscriptionStartDate: json['mqsSubscriptionStartDate'],
      mqsSubscriptionExpiryDate: json['mqsSubscriptionExpiryDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mqsSubscriptionStatus': mqsSubscriptionStatus,
      'mqsSubscriptionActivePlan': mqsSubscriptionActivePlan,
      'mqsSubscriptionStartDate': mqsSubscriptionStartDate,
      'mqsSubscriptionExpiryDate': mqsSubscriptionExpiryDate,
    };
  }
}
