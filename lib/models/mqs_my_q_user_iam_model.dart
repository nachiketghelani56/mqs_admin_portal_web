import 'package:mqs_admin_portal_web/config/config.dart';

class MQSMyQUserIamModel {
  String? id;
  String? mqsUserID;
  String? mqsEmail;
  String? mqsFirstName;
  String? mqsLastName;
  String? mqsAppVersion;
  bool? mqsEnterpriseUserFlag;
  String? mqsRegistrationStatus;
  String? mqsCreatedTimestamp;
  String? mqsMONGODBUserID;
  String? mqsUserLoginWith;
  String? mqsUpdatedTimestamp;

  // MQSOnboardingDetails? mqsOnboardingDetails;
  MQSEnterpriseDetails? mqsEnterpriseDetails;
  String? mqsUserActiveTimestamp;
  String? mqsEnterpriseCreatedTimestamp;
  MQSUserJMStatus? mqsUserJMStatus;
  MQSUserChallengesStatus? mqsUserChallengesStatus;
  MQSPrivacySettingsDetails? mqsPrivacySettingsDetails;
  MQSUserGrowth? mqsUserGrowth;
  MQSUserProfile? mqsUserProfile;
  List<MQSUserMilestones>? mqsUserMilestones;
  List<MQSUserBadges>? mqsUserBadges;

  MQSMyQUserIamModel(
      {this.id,
      // this.mqsOnboardingDetails,
      this.mqsEnterpriseDetails,
      this.mqsEmail,
      this.mqsFirstName,
      this.mqsLastName,
      this.mqsAppVersion,
      this.mqsEnterpriseUserFlag,
      this.mqsUserID,
      this.mqsRegistrationStatus,
      this.mqsCreatedTimestamp,
      this.mqsMONGODBUserID,
      this.mqsUserLoginWith,
      this.mqsUpdatedTimestamp,
      this.mqsUserActiveTimestamp,
      this.mqsEnterpriseCreatedTimestamp,
      this.mqsUserJMStatus,
      this.mqsPrivacySettingsDetails,
      this.mqsUserGrowth,
      this.mqsUserProfile,
      this.mqsUserMilestones,
      this.mqsUserBadges,
      this.mqsUserChallengesStatus});

  MQSMyQUserIamModel.fromJson(Map<String, dynamic> json, String docId) {
    id = docId;
    mqsEmail = json['mqsEmail'] ?? json['Email'] ?? "";
    mqsFirstName = json['mqsFirstName'] ?? json['FirstName'] ?? "";
    mqsLastName = json['mqsLastName'] ?? json['LastName'] ?? "";
    mqsAppVersion = json['mqsAppVersion'] ?? json['mqsAppVersion'] ?? "";
    mqsEnterpriseUserFlag =
        json['mqsEnterpriseUserFlag'] ?? json['isEnterPriseUser'] ?? false;
    mqsUserID = json['mqsFirebaseUserID'] ?? json['isFirebaseUserID'] ?? "";
    mqsRegistrationStatus = json['mqsRegistrationStatus'] ??
        (json['isRegister'] == 'isRegisterUserDone'
            ? StringConfig.reporting.completed
            : StringConfig.firebase.pending) ??
        "";
    mqsCreatedTimestamp = json['mqsCreatedTimestamp'] ?? "";
    mqsMONGODBUserID =
        json['mqsMONGODBUserID'] ?? json['isMONGODBUserID'] ?? "";
    mqsUserLoginWith = json['mqsUserLoginWith'] ?? json['loginWith'] ?? "";
    mqsUpdatedTimestamp =
        json['mqsUpdatedTimestamp'] ?? json['mqsUpdateTimestamp'] ?? "";
    mqsUserActiveTimestamp = json['mqsUserActiveTimestamp'] ?? "";
    mqsEnterpriseCreatedTimestamp = json['mqsEnterpriseCreatedTimestamp'] ?? "";
    // mqsOnboardingDetails = json['mqsOnboardingDetails'] != null
    //     ? MQSOnboardingDetails.fromJson(json['mqsOnboardingDetails'])
    //     : json['onboardingData'] != null
    //     ? MQSOnboardingDetails.fromJson(json['onboardingData'])
    //     : MQSOnboardingDetails(
    //     mqsCheckInDetails: [],
    //     mqsDemoGraphicDetails: [],
    //     mqsScenesDetails: [],
    //     mqsWheelOfLifeDetails: WOLModel(),
    //     mqsOBScenes: false,
    //     mqsOBCheckIn: false,
    //     mqsOBCheckInScore: 0.0,
    //     mqsOBCompletedTimestamp: '',
    //     mqsOBDemoGraphic: false,
    //     mqsOBDiv1: false,
    //     mqsOBDiv2: false,
    //     mqsOBDiv3: false,
    //     mqsOBDiv4: false,
    //     mqsOBRegister: false,
    //     mqsOBStartTimestamp: '',
    //     mqsOBScenesScore: 0,
    //     mqsOBWheelOfLife: false,
    //     mqsOBSkip: false,
    //     mqsOBDone: false,
    //     mqsOBStart: false);
    mqsUserJMStatus = json['mqsUserJMStatus'] != null
        ? MQSUserJMStatus.fromJson(json['mqsUserJMStatus'])
        : MQSUserJMStatus();
    mqsUserChallengesStatus = json['mqsUserChallengesStatus'] != null
        ? MQSUserChallengesStatus.fromJson(json['mqsUserChallengesStatus'])
        : MQSUserChallengesStatus();
    mqsPrivacySettingsDetails = json['mqsPrivacySettingsDetails'] != null
        ? MQSPrivacySettingsDetails.fromJson(json['mqsPrivacySettingsDetails'])
        : MQSPrivacySettingsDetails(
            mqsUserPSOutreach: false,
            mqsUserPSSurveysAndStudies: true,
            mqsUserPSCircleName: true,
            mqsUserPSCircleProfilePicture: true,
            mqsUserPSCircleAbout:
                json['mqsAllowAbout'] ?? json['AboutValue'] ?? false,
            mqsUserPSCircleCountry:
                json['mqsAllowCountry'] ?? json['CountryValue'] ?? false,
            mqsUserPSCirclePronouns:
                json['mqsAllowPronouns'] ?? json['PronounsValue'] ?? false,
            mqsUserPSActivityLogs: true,
          );
    mqsUserGrowth = json['mqsUserGrowth'] != null
        ? MQSUserGrowth.fromJson(json['mqsUserGrowth'])
        : MQSUserGrowth();
    mqsUserProfile = json['mqsUserProfile'] != null
        ? MQSUserProfile.fromJson(json['mqsUserProfile'])
        : MQSUserProfile(
            mqsUserImage: json['mqsUserImage'] ?? json['UserImage'] ?? '',
            mqsAbout: json['mqsAbout'] ?? json['About'] ?? "",
            mqsAgeGroup: '',
            mqsCountry: json['mqsCountry'] ?? json['Country'] ?? "",
            mqsPostal: '',
            mqsProfession: '',
            mqsPronouns: json['mqsPronouns'] ?? json['Pronouns'] ?? "",
          );
    if (json['mqsUserMilestones'] != null) {
      mqsUserMilestones = <MQSUserMilestones>[];
      json['mqsUserMilestones'].forEach((v) {
        mqsUserMilestones?.add(MQSUserMilestones.fromJson(v));
      });
    }
    if (json['mqsUserBadges'] != null) {
      mqsUserBadges = <MQSUserBadges>[];
      json['mqsUserBadges'].forEach((v) {
        mqsUserBadges?.add(MQSUserBadges.fromJson(v));
      });
    }
    mqsEnterpriseDetails = json['mqsEnterpriseDetails'] != null
        ? MQSEnterpriseDetails.fromJson(json['mqsEnterpriseDetails'])
        : MQSEnterpriseDetails(
            mqsIndividualID: '',
            mqsIndividualValid: false,
            mqsOrganizationID: json['enterPriseID'] ?? "",
            mqsTeamID: '',
            mqsOrganizationValid: false,
            mqsTeamValid: false,
            mqsOrganizationEmail: '',
            mqsOrganizationName: '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mqsEmail'] = mqsEmail;
    data['mqsFirstName'] = mqsFirstName;
    data['mqsLastName'] = mqsLastName;
    data['mqsAppVersion'] = mqsAppVersion;
    data['mqsEnterpriseUserFlag'] = mqsEnterpriseUserFlag;
    data['mqsFirebaseUserID'] = mqsUserID;
    data['mqsRegistrationStatus'] = mqsRegistrationStatus;
    data['mqsCreatedTimestamp'] = mqsCreatedTimestamp;
    data['mqsMONGODBUserID'] = mqsMONGODBUserID;
    data['mqsUserLoginWith'] = mqsUserLoginWith;
    data['mqsUpdatedTimestamp'] = mqsUpdatedTimestamp;
    data['mqsUserActiveTimestamp'] = mqsUserActiveTimestamp;
    data['mqsEnterpriseCreatedTimestamp'] = mqsEnterpriseCreatedTimestamp;
    // data['mqsOnboardingDetails'] = mqsOnboardingDetails?.toJson();
    data['mqsUserJMStatus'] = mqsUserJMStatus?.toJson();
    data['mqsUserChallengesStatus'] = mqsUserChallengesStatus?.toJson();
    data['mqsEnterpriseDetails'] = mqsEnterpriseDetails?.toJson();
    data['mqsPrivacySettingsDetails'] = mqsPrivacySettingsDetails?.toJson();
    data['mqsUserGrowth'] = mqsUserGrowth?.toJson();
    data['mqsUserProfile'] = mqsUserProfile?.toJson();
    if (mqsUserMilestones != null) {
      data['mqsUserMilestones'] =
          mqsUserMilestones?.map((v) => v.toJson()).toList();
    }
    if (mqsUserBadges != null) {
      data['mqsUserBadges'] = mqsUserBadges?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class MQSOnboardingDetails {
//   List<CheckInModel>? mqsCheckInDetails;
//   List<DemographicModel>? mqsDemoGraphicDetails;
//   List<ScenesModel>? mqsScenesDetails;
//   WOLModel? mqsWheelOfLifeDetails;
//   bool? mqsOBStart;
//   bool? mqsOBDemoGraphic;
//   bool? mqsOBScenes;
//   int? mqsOBScenesScore;
//   bool? mqsOBCheckIn;
//   double? mqsOBCheckInScore;
//   bool? mqsOBWheelOfLife;
//   bool? mqsOBDiv1;
//   bool? mqsOBDiv2;
//   bool? mqsOBDiv3;
//   bool? mqsOBDiv4;
//   bool? mqsOBRegister;
//   String? mqsOBStartTimestamp;
//   String? mqsOBCompletedTimestamp;
//   bool? mqsOBSkip;
//   bool? mqsOBDone;
//
//   MQSOnboardingDetails({
//     this.mqsCheckInDetails,
//     this.mqsDemoGraphicDetails,
//     this.mqsScenesDetails,
//     this.mqsWheelOfLifeDetails,
//     this.mqsOBStart,
//     this.mqsOBDemoGraphic,
//     this.mqsOBScenes,
//     this.mqsOBScenesScore,
//     this.mqsOBCheckIn,
//     this.mqsOBCheckInScore,
//     this.mqsOBWheelOfLife,
//     this.mqsOBDiv1,
//     this.mqsOBDiv2,
//     this.mqsOBDiv3,
//     this.mqsOBDiv4,
//     this.mqsOBRegister,
//     this.mqsOBStartTimestamp,
//     this.mqsOBCompletedTimestamp,
//     this.mqsOBSkip,
//     this.mqsOBDone,
//   });
//
//   MQSOnboardingDetails.fromJson(Map<String, dynamic> json) {
//     mqsCheckInDetails = json['mqsCheckInDetails'] != null
//         ? List<CheckInModel>.from((json['mqsCheckInDetails'] as List)
//         .map((model) => CheckInModel.fromJson(model)))
//         : json['checkINValue'] != null
//         ? List<CheckInModel>.from((json['checkINValue'] as List)
//         .map((model) => CheckInModel.fromJson(model)))
//         : [];
//     mqsDemoGraphicDetails = json['mqsDemoGraphicDetails'] != null
//         ? List<DemographicModel>.from((json['mqsDemoGraphicDetails'] as List)
//         .map((model) => DemographicModel.fromJson(model)))
//         : json['demoGraphicValue'] != null
//         ? List<DemographicModel>.from((json['demoGraphicValue'] as List)
//         .map((model) => DemographicModel.fromJson(model)))
//         : [];
//     mqsScenesDetails = json['mqsScenesDetails'] != null
//         ? List<ScenesModel>.from((json['mqsScenesDetails'] as List)
//         .map((model) => ScenesModel.fromJson(model)))
//         : json['scenesValue'] != null
//         ? List<ScenesModel>.from((json['scenesValue'] as List)
//         .map((model) => ScenesModel.fromJson(model)))
//         : [];
//     mqsWheelOfLifeDetails = json['mqsWheelOfLifeDetails'] != null
//         ? WOLModel.fromJson(json['mqsWheelOfLifeDetails'])
//         : json['wOLValue'] != null
//         ? WOLModel.fromJson(json['wOLValue'])
//         : WOLModel();
//     mqsOBStart = json['mqsOBStart'] ?? false;
//     mqsOBDemoGraphic = json['mqsOBDemoGraphic'] ?? false;
//     mqsOBScenes = json['mqsOBScenes'] ?? false;
//     mqsOBScenesScore = json['mqsOBScenesScore'] ?? 0;
//     mqsOBCheckIn = json['mqsOBCheckIn'] ?? false;
//     mqsOBCheckInScore = json['mqsOBCheckInScore'] ?? 0.0;
//     mqsOBWheelOfLife = json['mqsOBWheelOfLife'] ?? false;
//     mqsOBDiv1 = json['mqsOBDiv1'] ?? false;
//     mqsOBDiv2 = json['mqsOBDiv2'] ?? false;
//     mqsOBDiv3 = json['mqsOBDiv3'] ?? false;
//     mqsOBDiv4 = json['mqsOBDiv4'] ?? false;
//     mqsOBRegister = json['mqsOBRegister'] ?? false;
//     mqsOBStartTimestamp = json['mqsOBStartTimestamp'] ?? "";
//     mqsOBCompletedTimestamp = json['mqsOBCompletedTimestamp'] ?? "";
//     mqsOBSkip = json['mqsOBSkip'] ?? false;
//     mqsOBDone = json['mqsOBDone'] ?? false;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (mqsCheckInDetails != null) {
//       data['mqsCheckInDetails'] =
//           mqsCheckInDetails?.map((v) => v.toJson()).toList();
//     }
//     if (mqsDemoGraphicDetails != null) {
//       data['mqsDemoGraphicDetails'] =
//           mqsDemoGraphicDetails?.map((v) => v.toJson()).toList();
//     }
//     if (mqsScenesDetails != null) {
//       data['mqsScenesDetails'] =
//           mqsScenesDetails?.map((v) => v.toJson()).toList();
//     }
//     data['mqsWheelOfLifeDetails'] = mqsWheelOfLifeDetails?.toJson();
//     data['mqsOBStart'] = mqsOBStart;
//     data['mqsOBDemoGraphic'] = mqsOBDemoGraphic;
//     data['mqsOBScenes'] = mqsOBScenes;
//     data['mqsOBScenesScore'] = mqsOBScenesScore;
//     data['mqsOBCheckIn'] = mqsOBCheckIn;
//     data['mqsOBCheckInScore'] = mqsOBCheckInScore;
//     data['mqsOBWheelOfLife'] = mqsOBWheelOfLife;
//     data['mqsOBDiv1'] = mqsOBDiv1;
//     data['mqsOBDiv2'] = mqsOBDiv2;
//     data['mqsOBDiv3'] = mqsOBDiv3;
//     data['mqsOBDiv4'] = mqsOBDiv4;
//     data['mqsOBRegister'] = mqsOBRegister;
//     data['mqsOBStartTimestamp'] = mqsOBStartTimestamp;
//     data['mqsOBCompletedTimestamp'] = mqsOBCompletedTimestamp;
//     data['mqsOBSkip'] = mqsOBSkip;
//     data['mqsOBDone'] = mqsOBDone;
//     return data;
//   }
// }
//
// class CheckInModel {
//   double? checkInScore;
//   String? id;
//   double? mqsCINValue;
//   String? mqsTimestamp;
//
//   CheckInModel(
//       {this.checkInScore, this.id, this.mqsCINValue, this.mqsTimestamp});
//
//   CheckInModel.fromJson(Map<String, dynamic> json) {
//     checkInScore = json['checkInScore'] ?? 0.0;
//     id = json['id'] ?? "";
//     mqsCINValue = json['mqsCINValue'] ?? 0.0;
//     mqsTimestamp = json['mqsTimestamp'] ?? "";
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['checkInScore'] = checkInScore;
//     data['id'] = id;
//     data['mqsCINValue'] = mqsCINValue;
//     data['mqsTimestamp'] = mqsTimestamp;
//     return data;
//   }
// }
//
// class DemographicModel {
//   String? currentSelectedAnswer;
//   int? selectedIndex;
//
//   DemographicModel(
//       {this.currentSelectedAnswer, this.selectedIndex});
//
//   DemographicModel.fromJson(Map<String, dynamic> json) {
//     currentSelectedAnswer = json['currentSelectedAnswer'] ?? "";
//     selectedIndex = json['selectedIndex'] ?? 0;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['currentSelectedAnswer'] = currentSelectedAnswer;
//     data['selectedIndex'] = selectedIndex;
//     return data;
//   }
// }
//
// class ScenesModel {
//   String? mqsSceneID;
//   int? mqsSceneOptionGrScore;
//   String? mqsSceneOptionText;
//   int? mqsSceneOptionWeight;
//   int? mqsSceneStScore;
//   String? mqsSceneStmt;
//   String? mqsTimeStamp;
//   int? mqsUserOBScenesScore;
//
//   ScenesModel(
//       {this.mqsSceneID,
//         this.mqsSceneOptionGrScore,
//         this.mqsSceneOptionText,
//         this.mqsSceneOptionWeight,
//         this.mqsSceneStScore,
//         this.mqsSceneStmt,
//         this.mqsTimeStamp,
//         this.mqsUserOBScenesScore});
//
//   ScenesModel.fromJson(Map<String, dynamic> json) {
//     mqsSceneID = json['mqsSceneID'] ?? "";
//     mqsSceneOptionGrScore = json['mqsSceneOptionGrScore'] ?? 0;
//     mqsSceneOptionText = json['mqsSceneOptionText'] ?? "";
//     mqsSceneOptionWeight = json['mqsSceneOptionWeight'] ?? 0;
//     mqsSceneStScore = json['mqsSceneStScore'] ?? 0;
//     mqsSceneStmt = json['mqsSceneStmt'] ?? "";
//     mqsTimeStamp = json['mqsTimeStamp'] ?? "";
//     mqsUserOBScenesScore = json['mqsUserOBScenesScore'] ?? 0;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['mqsSceneID'] = mqsSceneID;
//     data['mqsSceneOptionGrScore'] = mqsSceneOptionGrScore;
//     data['mqsSceneOptionText'] = mqsSceneOptionText;
//     data['mqsSceneOptionWeight'] = mqsSceneOptionWeight;
//     data['mqsSceneStScore'] = mqsSceneStScore;
//     data['mqsSceneStmt'] = mqsSceneStmt;
//     data['mqsTimeStamp'] = mqsTimeStamp;
//     data['mqsUserOBScenesScore'] = mqsUserOBScenesScore;
//     return data;
//   }
// }
//
// class WOLModel {
//   double? mqsFamily;
//   double? mqsFinances;
//   double? mqsFun;
//   double? mqsHealth;
//   double? mqsPurpose;
//   double? mqsRelationship;
//   double? mqsSocial;
//   double? mqsWork;
//   String? mqsTimestamp;
//
//   WOLModel({
//     this.mqsFamily,
//     this.mqsFinances,
//     this.mqsFun,
//     this.mqsHealth,
//     this.mqsPurpose,
//     this.mqsRelationship,
//     this.mqsSocial,
//     this.mqsWork,
//     this.mqsTimestamp,
//   });
//
//   WOLModel.fromJson(Map<String, dynamic> json) {
//     mqsFamily = json['mqsFamily'] ?? json['family'] ?? 0.0;
//     mqsFinances = json['mqsFinances'] ?? json['finances'] ?? 0.0;
//     mqsFun = json['mqsFun'] ?? json['fun'] ?? 0.0;
//     mqsHealth = json['mqsHealth'] ?? json['health'] ?? 0.0;
//     mqsPurpose = json['mqsPurpose'] ?? json['purpose'] ?? 0.0;
//     mqsRelationship =
//         json['mqsRelationship'] ?? json['relationship'] ?? 0.0;
//     mqsSocial = json['mqsSocial'] ?? json['social'] ?? 0.0;
//     mqsWork = json['mqsWork'] ?? json['work'] ?? 0.0;
//     mqsTimestamp = json['mqsTimestamp'] ?? '';
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['mqsFamily'] = mqsFamily;
//     data['mqsFinances'] = mqsFinances;
//     data['mqsFun'] = mqsFun;
//     data['mqsHealth'] = mqsHealth;
//     data['mqsPurpose'] = mqsPurpose;
//     data['mqsRelationship'] = mqsRelationship;
//     data['mqsSocial'] = mqsSocial;
//     data['mqsWork'] = mqsWork;
//     data['mqsTimestamp'] = mqsTimestamp;
//     return data;
//   }
// }

class MQSEnterpriseDetails {
  String? mqsIndividualID;
  String? mqsOrganizationEmail;
  String? mqsOrganizationName;
  bool? mqsIndividualValid;
  String? mqsOrganizationID;
  bool? mqsOrganizationValid;
  String? mqsTeamID;
  bool? mqsTeamValid;

  MQSEnterpriseDetails({
    this.mqsIndividualID,
    this.mqsOrganizationEmail,
    this.mqsOrganizationName,
    this.mqsIndividualValid,
    this.mqsOrganizationID,
    this.mqsOrganizationValid,
    this.mqsTeamID,
    this.mqsTeamValid,
  });

  MQSEnterpriseDetails.fromJson(Map<String, dynamic> json) {
    mqsIndividualID = json['mqsIndividualID'] ?? "";
    mqsOrganizationEmail = json['mqsOrganizationEmail'] ?? "";
    mqsOrganizationName = json['mqsOrganizationName'] ?? "";
    mqsIndividualValid = json['mqsIndividualValid'] ?? false;
    mqsOrganizationID = json['mqsOrganizationID'] ?? "";
    mqsOrganizationValid = json['mqsOrganizationValid'] ?? false;
    mqsTeamID = json['mqsTeamID'] ?? "";
    mqsTeamValid = json['mqsTeamValid'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mqsIndividualID'] = mqsIndividualID;
    data['mqsOrganizationEmail'] = mqsOrganizationEmail;
    data['mqsOrganizationName'] = mqsOrganizationName;
    data['mqsIndividualValid'] = mqsIndividualValid;
    data['mqsOrganizationID'] = mqsOrganizationID;
    data['mqsOrganizationValid'] = mqsOrganizationValid;
    data['mqsTeamID'] = mqsTeamID;
    data['mqsTeamValid'] = mqsTeamValid;
    return data;
  }
}

class MQSUserJMStatus {
  List<String>? mqsPathwayScreenList;
  List<String>? mqsCompletedPathwayList;
  bool? mqsUserInPathway;
  String? mqsUserPathwayID;
  int? mqsUserPathwayLevel;

  MQSUserJMStatus({
    this.mqsPathwayScreenList,
    this.mqsCompletedPathwayList,
    this.mqsUserInPathway,
    this.mqsUserPathwayID,
    this.mqsUserPathwayLevel,
  });

  MQSUserJMStatus.fromJson(Map<String, dynamic> json) {
    mqsPathwayScreenList = json['mqsPathwayScreenList'] != null
        ? json['mqsPathwayScreenList'].cast<String>()
        : <String>[];
    mqsCompletedPathwayList = json['mqsCompletedPathwayList'] != null
        ? json['mqsCompletedPathwayList'].cast<String>()
        : <String>[];
    mqsUserInPathway = json['mqsUserInPathway'] ?? false;
    mqsUserPathwayID = json['mqsUserPathwayID'] ?? '';
    mqsUserPathwayLevel = json['mqsUserPathwayLevel'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mqsPathwayScreenList'] = mqsPathwayScreenList;
    data['mqsCompletedPathwayList'] = mqsCompletedPathwayList;
    data['mqsUserInPathway'] = mqsUserInPathway;
    data['mqsUserPathwayID'] = mqsUserPathwayID;
    data['mqsUserPathwayLevel'] = mqsUserPathwayLevel;
    return data;
  }
}

class MQSUserChallengesStatus {
  List<String>? mqsCompletedChallengesList;
  bool? mqsUserInChallenges;
  String? mqsUserChallengesTimestamp;

  MQSUserChallengesStatus({
    this.mqsCompletedChallengesList,
    this.mqsUserInChallenges,
    this.mqsUserChallengesTimestamp,
  });

  MQSUserChallengesStatus.fromJson(Map<String, dynamic> json) {
    mqsCompletedChallengesList = json['mqsCompletedChallengesList'] != null
        ? json['mqsCompletedChallengesList'].cast<String>()
        : <String>[];
    mqsUserInChallenges = json['mqsUserInChallenges'] ?? false;
    mqsUserChallengesTimestamp = json['mqsUserChallengesTimestamp'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mqsCompletedChallengesList'] = mqsCompletedChallengesList;
    data['mqsUserInChallenges'] = mqsUserInChallenges;
    data['mqsUserChallengesTimestamp'] = mqsUserChallengesTimestamp;
    return data;
  }
}

class MQSPrivacySettingsDetails {
  bool? mqsUserPSActivityLogs;
  bool? mqsUserPSCircleAbout;
  bool? mqsUserPSCircleCountry;
  bool? mqsUserPSCircleName;
  bool? mqsUserPSCircleProfilePicture;
  bool? mqsUserPSCirclePronouns;
  bool? mqsUserPSOutreach;
  bool? mqsUserPSSurveysAndStudies;

  MQSPrivacySettingsDetails({
    this.mqsUserPSActivityLogs,
    this.mqsUserPSCircleAbout,
    this.mqsUserPSCircleCountry,
    this.mqsUserPSCirclePronouns,
    this.mqsUserPSCircleName,
    this.mqsUserPSCircleProfilePicture,
    this.mqsUserPSOutreach,
    this.mqsUserPSSurveysAndStudies,
  });

  MQSPrivacySettingsDetails.fromJson(Map<String, dynamic> json) {
    mqsUserPSActivityLogs = json['mqsUserPSActivityLogs'] ?? true;
    mqsUserPSCircleAbout = json['mqsUserPSCircleAbout'] ?? false;
    mqsUserPSCircleCountry = json['mqsUserPSCircleCountry'] ?? false;
    mqsUserPSCirclePronouns = json['mqsUserPSCirclePronouns'] ?? false;
    mqsUserPSCircleName = json['mqsUserPSCircleName'] ?? true;
    mqsUserPSCircleProfilePicture =
        json['mqsUserPSCircleProfilePicture'] ?? true;
    mqsUserPSOutreach = json['mqsUserPSOutreach'] ?? false;
    mqsUserPSSurveysAndStudies = json['mqsUserPSSurveysAndStudies'] ?? true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mqsUserPSActivityLogs'] = mqsUserPSActivityLogs;
    data['mqsUserPSCircleAbout'] = mqsUserPSCircleAbout;
    data['mqsUserPSCircleCountry'] = mqsUserPSCircleCountry;
    data['mqsUserPSCirclePronouns'] = mqsUserPSCirclePronouns;
    data['mqsUserPSCircleName'] = mqsUserPSCircleName;
    data['mqsUserPSCircleProfilePicture'] = mqsUserPSCircleProfilePicture;
    data['mqsUserPSOutreach'] = mqsUserPSOutreach;
    data['mqsUserPSSurveysAndStudies'] = mqsUserPSSurveysAndStudies;
    return data;
  }
}

class MQSUserGrowth {
  int? mqsDayStreak;
  String? mqsDayStreakTimestamp;
  int? mqsPracticeWeekStreak;
  int? mqsReflectWeekStreak;
  String? mqsWeeklyResetTimestamp;
  MQSCognitive? mqsCognitive;
  MQSMindSkills? mqsMindSkills;
  MQSTechniques? mqsTechniques;

  MQSUserGrowth({
    this.mqsDayStreak,
    this.mqsDayStreakTimestamp,
    this.mqsPracticeWeekStreak,
    this.mqsReflectWeekStreak,
    this.mqsWeeklyResetTimestamp,
    this.mqsCognitive,
    this.mqsMindSkills,
    this.mqsTechniques,
  });

  MQSUserGrowth.fromJson(Map<String, dynamic> json) {
    mqsDayStreak = json['mqsDayStreak'] ?? 0;
    mqsDayStreakTimestamp = json['mqsDayStreakTimestamp'] ?? '';
    mqsPracticeWeekStreak = json['mqsPracticeWeekStreak'] ?? 0;
    mqsReflectWeekStreak = json['mqsReflectWeekStreak'] ?? 0;
    mqsWeeklyResetTimestamp = json['mqsWeeklyResetTimestamp'] ?? '';
    mqsCognitive = json['mqsCognitive'] != null
        ? MQSCognitive.fromJson(json['mqsCognitive'])
        : MQSCognitive(cF: 0, cP: 0, cR: 0);
    mqsMindSkills = json['mqsMindSkills'] != null
        ? MQSMindSkills.fromJson(json['mqsMindSkills'])
        : MQSMindSkills(mS1: 0, mS2: 0, mS3: 0, mS4: 0, mS5: 0, mS6: 0, mS7: 0);
    mqsTechniques = json['mqsTechniques'] != null
        ? MQSTechniques.fromJson(json['mqsTechniques'])
        : MQSTechniques(t1: 0, t2: 0, t3: 0, t4: 0, t5: 0, t6: 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mqsDayStreak'] = mqsDayStreak;
    data['mqsDayStreakTimestamp'] = mqsDayStreakTimestamp;
    data['mqsPracticeWeekStreak'] = mqsPracticeWeekStreak;
    data['mqsReflectWeekStreak'] = mqsReflectWeekStreak;
    data['mqsWeeklyResetTimestamp'] = mqsWeeklyResetTimestamp;
    if (mqsCognitive != null) {
      data['mqsCognitive'] = mqsCognitive?.toJson();
    }
    if (mqsMindSkills != null) {
      data['mqsMindSkills'] = mqsMindSkills?.toJson();
    }
    if (mqsTechniques != null) {
      data['mqsTechniques'] = mqsTechniques?.toJson();
    }
    return data;
  }
}

class MQSUserProfile {
  String? mqsAbout;
  String? mqsCountry;
  String? mqsPronouns;
  String? mqsPostal;
  String? mqsProfession;
  String? mqsAgeGroup;
  String? mqsUserImage;

  MQSUserProfile({
    this.mqsAbout,
    this.mqsCountry,
    this.mqsPronouns,
    this.mqsPostal,
    this.mqsProfession,
    this.mqsAgeGroup,
    this.mqsUserImage,
  });

  MQSUserProfile.fromJson(Map<String, dynamic> json) {
    mqsAbout = json['mqsAbout'] ?? '';
    mqsCountry = json['mqsCountry'] ?? '';
    mqsPronouns = json['mqsPronouns'] ?? '';
    mqsProfession = json['mqsProfession'] ?? '';
    mqsAgeGroup = json['mqsAgeGroup'] ?? '';
    mqsUserImage = json['mqsUserImage'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mqsAbout'] = mqsAbout;
    data['mqsCountry'] = mqsCountry;
    data['mqsPronouns'] = mqsPronouns;
    data['mqsProfession'] = mqsProfession;
    data['mqsAgeGroup'] = mqsAgeGroup;
    data['mqsUserImage'] = mqsUserImage;
    return data;
  }
}

class MQSUserMilestones {
  String? mqsMilestoneID;
  String? mqsMilestoneName;
  String? mqsMilestoneImage;
  String? mqsMilestoneDescription;
  String? mqsAboutMilestone;

  MQSUserMilestones(
      {this.mqsMilestoneID,
      this.mqsMilestoneName,
      this.mqsMilestoneImage,
      this.mqsMilestoneDescription,
      this.mqsAboutMilestone});

  MQSUserMilestones.fromJson(Map<String, dynamic> json) {
    mqsMilestoneID = json['mqsMilestoneID'] ?? '';
    mqsMilestoneName = json['mqsMilestoneName'] ?? '';
    mqsMilestoneImage = json['mqsMilestoneImage'] ?? '';
    mqsMilestoneDescription = json['mqsMilestoneDescription'] ?? '';
    mqsAboutMilestone = json['mqsAboutMilestone'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mqsMilestoneID'] = mqsMilestoneID;
    data['mqsMilestoneName'] = mqsMilestoneName;
    data['mqsMilestoneImage'] = mqsMilestoneImage;
    data['mqsMilestoneDescription'] = mqsMilestoneDescription;
    data['mqsAboutMilestone'] = mqsAboutMilestone;
    return data;
  }
}

class MQSUserBadges {
  String? mqsBadgeID;
  String? mqsBadgeName;
  String? mqsBadgeImage;
  String? mqsAwardTimestamp;
  String? mqsBadgeNotes;

  MQSUserBadges(
      {this.mqsBadgeID,
      this.mqsBadgeName,
      this.mqsBadgeImage,
      this.mqsAwardTimestamp,
      this.mqsBadgeNotes});

  MQSUserBadges.fromJson(Map<String, dynamic> json) {
    mqsBadgeID = json['mqsBadgeID'] ?? '';
    mqsBadgeName = json['mqsBadgeName'] ?? '';
    mqsBadgeImage = json['mqsBadgeImage'] ?? '';
    mqsAwardTimestamp = json['mqsAwardTimestamp'] ?? '';
    mqsBadgeNotes = json['mqsBadgeNotes'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mqsBadgeID'] = mqsBadgeID;
    data['mqsBadgeName'] = mqsBadgeName;
    data['mqsBadgeImage'] = mqsBadgeImage;
    data['mqsAwardTimestamp'] = mqsAwardTimestamp;
    data['mqsBadgeNotes'] = mqsBadgeNotes;
    return data;
  }
}

class MQSCognitive {
  int? cF;
  int? cP;
  int? cR;

  MQSCognitive({this.cF, this.cP, this.cR});

  MQSCognitive.fromJson(Map<String, dynamic> json) {
    cF = json['CF'] ?? 0;
    cP = json['CP'] ?? 0;
    cR = json['CR'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CF'] = cF;
    data['CP'] = cP;
    data['CR'] = cR;
    return data;
  }
}

class MQSMindSkills {
  int? mS1;
  int? mS2;
  int? mS3;
  int? mS4;
  int? mS5;
  int? mS6;
  int? mS7;

  MQSMindSkills(
      {this.mS1, this.mS2, this.mS3, this.mS4, this.mS5, this.mS6, this.mS7});

  MQSMindSkills.fromJson(Map<String, dynamic> json) {
    mS1 = json['MS1'] ?? 0;
    mS2 = json['MS2'] ?? 0;
    mS3 = json['MS3'] ?? 0;
    mS4 = json['MS4'] ?? 0;
    mS5 = json['MS5'] ?? 0;
    mS6 = json['MS6'] ?? 0;
    mS7 = json['MS7'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MS1'] = mS1;
    data['MS2'] = mS2;
    data['MS3'] = mS3;
    data['MS4'] = mS4;
    data['MS5'] = mS5;
    data['MS6'] = mS6;
    data['MS7'] = mS7;
    return data;
  }
}

class MQSTechniques {
  int? t1;
  int? t2;
  int? t3;
  int? t4;
  int? t5;
  int? t6;

  MQSTechniques({this.t1, this.t2, this.t3, this.t4, this.t5, this.t6});

  MQSTechniques.fromJson(Map<String, dynamic> json) {
    t1 = json['T1'] ?? 0;
    t2 = json['T2'] ?? 0;
    t3 = json['T3'] ?? 0;
    t4 = json['T4'] ?? 0;
    t5 = json['T5'] ?? 0;
    t6 = json['T6'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['T1'] = t1;
    data['T2'] = t2;
    data['T3'] = t3;
    data['T4'] = t4;
    data['T5'] = t5;
    data['T6'] = t6;
    return data;
  }
}
