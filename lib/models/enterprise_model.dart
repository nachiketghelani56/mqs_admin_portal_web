class EnterpriseModel {
  final String docId;
  final MqsEnterprisePOCs mqsEnterprisePOCs;
  final String mqsEnterpriseCode;
  // final bool mqsIsTeam;
  final List<MqsTeam> mqsTeamList;
  final List<MqsEmployee> mqsEmployeeList;
  final MqsEnterprisePOCsSubscriptionDetails
      mqsEnterprisePOCsSubscriptionDetails;
  final String mqsCreatedTimestamp;
  final String mqsUpdatedTimestamp;

  EnterpriseModel({
    required this.docId,
    required this.mqsEnterprisePOCs,
    required this.mqsEnterpriseCode,
    // required this.mqsIsTeam,
    required this.mqsTeamList,
    required this.mqsEmployeeList,
    required this.mqsEnterprisePOCsSubscriptionDetails,
    required this.mqsCreatedTimestamp,
    required this.mqsUpdatedTimestamp,
  });

  factory EnterpriseModel.fromJson(Map<String, dynamic> json,String docId) {
    return EnterpriseModel(
      docId: docId,
      mqsEnterprisePOCs: MqsEnterprisePOCs.fromJson(json['mqsEnterprisePOCs']),
      mqsEnterpriseCode: json['mqsEnterpriseCode'] ?? "",
      // mqsIsTeam: json['mqsIsTeam'] ?? false,
      mqsTeamList: (json['mqsTeamList'] as List)
          .map((team) => MqsTeam.fromJson(team))
          .toList(),
      mqsEmployeeList: (json['mqsEmployeeList'] as List)
          .map((employee) => MqsEmployee.fromJson(employee))
          .toList(),
      mqsEnterprisePOCsSubscriptionDetails:
          MqsEnterprisePOCsSubscriptionDetails.fromJson(
              json['mqsEnterprisePOCsSubscriptionDetails']),
      mqsCreatedTimestamp: json['mqsCreatedTimestamp'] ?? "",
      mqsUpdatedTimestamp: json['mqsUpdatedTimestamp'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mqsEnterprisePOCs': mqsEnterprisePOCs.toJson(),
      'mqsEnterpriseCode': mqsEnterpriseCode,
      // 'mqsIsTeam': mqsIsTeam,
      'mqsTeamList': mqsTeamList.map((team) => team.toJson()).toList(),
      'mqsEmployeeList':
          mqsEmployeeList.map((employee) => employee.toJson()).toList(),
      'mqsEnterprisePOCsSubscriptionDetails':
          mqsEnterprisePOCsSubscriptionDetails.toJson(),
      'mqsCreatedTimestamp': mqsCreatedTimestamp,
      'mqsUpdatedTimestamp': mqsUpdatedTimestamp,
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
      mqsEnterpriseID: json['mqsEnterpriseID'] ?? "",
      mqsEnterpriseName: json['mqsEnterpriseName'] ?? "",
      mqsEnterpriseEmail: json['mqsEnterpriseEmail'] ?? "",
      mqsEnterprisePhoneNumber: json['mqsEnterprisePhoneNumber'] ?? "",
      mqsEnterpriseType: json['mqsEnterpriseType'] ?? "",
      mqsEnterpriseWebsite: json['mqsEnterpriseWebsite'] ?? "",
      mqsEnterpriseAddress: json['mqsEnterpriseAddress'] ?? "",
      mqsEnterprisePincode: json['mqsEnterprisePincode'] ?? "",
      mqsIsSignUp: json['mqsIsSignUp'] ?? false,
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
  String mqsTeamName;
  String mqsTeamEmail;
  int mqsTeamMembersLimit;
  bool mqsIsEnable;

  MqsTeam({
    required this.mqsTeamID,
    required this.mqsTeamName,
    required this.mqsTeamEmail,
    required this.mqsTeamMembersLimit,
    required this.mqsIsEnable,
  });

  factory MqsTeam.fromJson(Map<String, dynamic> json) {
    return MqsTeam(
      mqsTeamID: json['mqsTeamID'] ?? "",
      mqsTeamName: json['mqsTeamName'] ?? "",
      mqsTeamEmail: json['mqsTeamEmail'] ?? "",
      mqsTeamMembersLimit: json['mqsTeamMembersLimit'] ?? 0,
      mqsIsEnable: json['mqsIsEnable'] ?? false,
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
}

class MqsEmployee {
  final String mqsEmployeeID;
  String mqsEmployeeName;
  String mqsEmployeeEmail;
  final bool mqsIsSignUp;
  final bool mqsCommonLogin;

  MqsEmployee({
    required this.mqsEmployeeID,
    required this.mqsEmployeeName,
    required this.mqsEmployeeEmail,
    required this.mqsIsSignUp,
    required this.mqsCommonLogin,
  });

  factory MqsEmployee.fromJson(Map<String, dynamic> json) {
    return MqsEmployee(
      mqsEmployeeID: json['mqsEmployeeID'] ?? "",
      mqsEmployeeName: json['mqsEmployeeName'] ?? "",
      mqsEmployeeEmail: json['mqsEmployeeEmail'] ?? "",
      mqsIsSignUp: json['mqsIsSignUp'] ?? false,
      mqsCommonLogin: json['mqsCommonLogin'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mqsEmployeeID': mqsEmployeeID,
      'mqsEmployeeName': mqsEmployeeName,
      'mqsEmployeeEmail': mqsEmployeeEmail,
      'mqsIsSignUp': mqsIsSignUp,
      'mqsCommonLogin': mqsCommonLogin,
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
      mqsSubscriptionStatus: json['mqsSubscriptionStatus'] ?? "",
      mqsSubscriptionActivePlan: json['mqsSubscriptionActivePlan'] ?? "",
      mqsSubscriptionStartDate: json['mqsSubscriptionStartDate'] ?? "",
      mqsSubscriptionExpiryDate: json['mqsSubscriptionExpiryDate'] ?? "",
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
