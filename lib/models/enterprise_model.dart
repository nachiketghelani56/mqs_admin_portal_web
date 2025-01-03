class EnterpriseModel {
  final String docId;
  final List<MqsEnterprisePOCs> mqsEnterprisePOCsList;
  final String mqsEnterpriseCode;
  // final bool mqsIsTeam;
  final List<MqsTeam> mqsTeamList;
  final List<MqsEmployee> mqsEmployeeList;
  final MqsEnterpriseSubscriptionDetails mqsEnterpriseSubscriptionDetails;
  final String mqsCreatedTimestamp;
  final String mqsUpdatedTimestamp;

  EnterpriseModel({
    required this.docId,
    required this.mqsEnterprisePOCsList,
    required this.mqsEnterpriseCode,
    // required this.mqsIsTeam,
    required this.mqsTeamList,
    required this.mqsEmployeeList,
    required this.mqsEnterpriseSubscriptionDetails,
    required this.mqsCreatedTimestamp,
    required this.mqsUpdatedTimestamp,
  });

  factory EnterpriseModel.fromJson(Map<String, dynamic> json, String docId) {
    return EnterpriseModel(
      docId: docId,
      mqsEnterprisePOCsList: (json['mqsEnterprisePOCsList'] as List)
          .map((enterprise) => MqsEnterprisePOCs.fromJson(enterprise))
          .toList(),
      mqsEnterpriseCode: json['mqsEnterpriseCode'] ?? "",
      // mqsIsTeam: json['mqsIsTeam'] ?? false,
      mqsTeamList: (json['mqsTeamList'] as List)
          .map((team) => MqsTeam.fromJson(team))
          .toList(),
      mqsEmployeeList: (json['mqsEmployeeList'] as List)
          .map((employee) => MqsEmployee.fromJson(employee))
          .toList(),
      mqsEnterpriseSubscriptionDetails:
      MqsEnterpriseSubscriptionDetails.fromJson(
          json['mqsEnterpriseSubscriptionDetails']),
      mqsCreatedTimestamp: json['mqsCreatedTimestamp'] ?? "",
      mqsUpdatedTimestamp: json['mqsUpdatedTimestamp'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mqsEnterprisePOCsList': mqsEnterprisePOCsList
          .map((enterprise) => enterprise.toJson())
          .toList(),
      'mqsEnterpriseCode': mqsEnterpriseCode,
      // 'mqsIsTeam': mqsIsTeam,
      'mqsTeamList': mqsTeamList.map((team) => team.toJson()).toList(),
      'mqsEmployeeList':
      mqsEmployeeList.map((employee) => employee.toJson()).toList(),
      'mqsEnterpriseSubscriptionDetails':
      mqsEnterpriseSubscriptionDetails.toJson(),
      'mqsCreatedTimestamp': mqsCreatedTimestamp,
      'mqsUpdatedTimestamp': mqsUpdatedTimestamp,
    };
  }
}

class MqsEnterprisePOCs {
   String mqsEnterpriseID;
   String mqsEnterpriseName;
   String mqsEnterpriseEmail;
   String mqsEnterprisePhoneNumber;
   String mqsEnterpriseType;
   String mqsEnterpriseWebsite;
   String mqsEnterpriseAddress;
   String mqsEnterprisePincode;
   bool mqsIsSignUp;

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
   bool mqsCommonLogin;

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

class MqsEnterpriseSubscriptionDetails {
  final String mqsSubscriptionStatus;
  final String mqsSubscriptionActivePlan;
  final String mqsSubscriptionActivationTimestamp;
  final String mqsSubscriptionExpiryDate;
  final String mqsSubscriptionRenewalDate;

  MqsEnterpriseSubscriptionDetails({
    required this.mqsSubscriptionStatus,
    required this.mqsSubscriptionActivePlan,
    required this.mqsSubscriptionActivationTimestamp,
    required this.mqsSubscriptionExpiryDate,
    required this.mqsSubscriptionRenewalDate,
  });

  factory MqsEnterpriseSubscriptionDetails.fromJson(Map<String, dynamic> json) {
    return MqsEnterpriseSubscriptionDetails(
      mqsSubscriptionStatus: json['mqsSubscriptionStatus'] ?? "",
      mqsSubscriptionActivePlan: json['mqsSubscriptionActivePlan'] ?? "",
      mqsSubscriptionActivationTimestamp: json['mqsSubscriptionActivationTimestamp'] ?? json['mqsSubscriptionStartDate'] ?? "" ,
      mqsSubscriptionExpiryDate: json['mqsSubscriptionExpiryDate'] ?? "",
      mqsSubscriptionRenewalDate: json['mqsSubscriptionRenewalDate'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mqsSubscriptionStatus': mqsSubscriptionStatus,
      'mqsSubscriptionActivePlan': mqsSubscriptionActivePlan,
      'mqsSubscriptionActivationTimestamp': mqsSubscriptionActivationTimestamp,
      'mqsSubscriptionExpiryDate': mqsSubscriptionExpiryDate,
      'mqsSubscriptionRenewalDate': mqsSubscriptionRenewalDate,
    };
  }
}
