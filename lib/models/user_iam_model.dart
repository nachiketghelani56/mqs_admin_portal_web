class UserIAMModel {
  final String mqsEmail;
  final String mqsFirstName;
  final String mqsLastName;
  final bool mqsEnterpriseUserFlag;
  final String mqsFirebaseUserID;
  final String mqsRegistrationStatus;
  final String mqsCreatedTimestamp;
  final String mqsAbout;
  final bool mqsAllowAbout;
  final String mqsCountry;
  final bool mqsAllowCountry;
  final String mqsPronouns;
  final bool mqsAllowPronouns;
  final String mqsUserImage;
  final String mqsEnterpriseID;
  final String mqsMONGODBUserID;
  final String mqsUserLoginWith;
  // final String mqsSubscriptionExpiryDate;
  // final String mqsSubscriptionActivePlan;
  // final String mqsSubscriptionPlatform;
  final String mqsUpdatedTimestamp;
  // final String mqsSubscriptionPlatform;
  final bool mqsSkipOnboarding;
  final OnboardingModel onboardingModel;
  final EnterpriseDetails mqsEnterpriseDetails;
  final String mqsUserActiveTimestamp;
  final String mqsEnterpriseCreatedTimestamp;

  UserIAMModel(
    this.onboardingModel,
    this.mqsEnterpriseDetails, {
    required this.mqsEmail,
    required this.mqsFirstName,
    required this.mqsLastName,
    required this.mqsEnterpriseUserFlag,
    required this.mqsFirebaseUserID,
    required this.mqsRegistrationStatus,
    required this.mqsCreatedTimestamp,
    required this.mqsAbout,
    required this.mqsAllowAbout,
    required this.mqsCountry,
    required this.mqsAllowCountry,
    required this.mqsPronouns,
    required this.mqsAllowPronouns,
    required this.mqsUserImage,
    required this.mqsEnterpriseID,
    required this.mqsMONGODBUserID,
    required this.mqsUserLoginWith,
    // required this.mqsSubscriptionExpiryDate,
    // required this.mqsSubscriptionActivePlan,
    // required this.mqsSubscriptionPlatform,
    required this.mqsUpdatedTimestamp,
    // required this.mqsUserSubscriptionStatus,
    required this.mqsSkipOnboarding,
    required this.mqsUserActiveTimestamp,
    required this.mqsEnterpriseCreatedTimestamp,
  });

  UserIAMModel.fromJson(Map json)
      : mqsEmail = json['mqsEmail'] ?? json['Email'] ?? "",
        mqsFirstName = json['mqsFirstName'] ?? json['FirstName'] ?? "",
        mqsLastName = json['mqsLastName'] ?? json['LastName'] ?? "",
        mqsEnterpriseUserFlag =
            json['mqsEnterpriseUserFlag'] ?? json['isEnterPriseUser'] ?? false,
        mqsFirebaseUserID =
            json['mqsFirebaseUserID'] ?? json['isFirebaseUserID'] ?? "",
        mqsRegistrationStatus =
            json['mqsRegistrationStatus'] ?? json['isRegister'] ?? "",
        mqsCreatedTimestamp = json['mqsCreatedTimestamp'] ??json['mqsEnterpriseCreatedTimestamp'] ?? DateTime.now().toIso8601String(),
        mqsAbout = json['mqsAbout'] ?? json['About'] ?? "",
        mqsAllowAbout = json['mqsPrivacySettingsDetails'] != null
            ? json['mqsPrivacySettingsDetails']['mqsAllowAbout'] ?? false
            : json['AboutValue'] ?? false,
        mqsCountry = json['mqsCountry'] ?? json['Country'] ?? "",
        mqsAllowCountry = json['mqsPrivacySettingsDetails'] != null
            ? json['mqsPrivacySettingsDetails']['mqsAllowCountry'] ?? false
            : json['CountryValue'] ?? false,
        mqsPronouns = json['mqsPronouns'] ?? json['Pronouns'] ?? "",
        mqsAllowPronouns = json['mqsPrivacySettingsDetails'] != null
            ? json['mqsPrivacySettingsDetails']['mqsAllowPronouns'] ?? false
            : json['PronounsValue'] ?? false,
        mqsUserImage = json['mqsUserImage'] ?? json['UserImage'] ?? "",
        mqsEnterpriseID = json['mqsEnterpriseDetails'] != null
            ? json['mqsEnterpriseDetails']['mqsOrganizationID']
            : json['enterPriseID'] ?? "",
        mqsMONGODBUserID =
            json['mqsMONGODBUserID'] ?? json['isMONGODBUserID'] ?? "",
        mqsUserLoginWith = json['mqsUserLoginWith'] ?? json['loginWith'] ?? "",
        // mqsSubscriptionExpiryDate = json['mqsSubscriptionExpiryDate'] ?? json['mqsExpiryDate'] ?? "",
        // mqsSubscriptionActivePlan = json['mqsSubscriptionActivePlan'] ?? "",
        // mqsSubscriptionPlatform = json['mqsSubscriptionPlatform'] ?? "",
        mqsUpdatedTimestamp =
            json['mqsUpdatedTimestamp'] ?? json['mqsUpdateTimestamp'] ?? "",
        // mqsUserSubscriptionStatus = json['mqsUserSubscriptionStatus'] ?? "",
        mqsSkipOnboarding = json['mqsSkipOnboarding'] ?? false,
        mqsUserActiveTimestamp = json['mqsUserActiveTimestamp'] ?? "",
        mqsEnterpriseCreatedTimestamp = json['mqsEnterpriseCreatedTimestamp'] ?? "",
        onboardingModel = json['mqsOnboardingDetails'] != null
            ? OnboardingModel.fromJson(json['mqsOnboardingDetails'])
            : json['onboardingData'] != null
                ? OnboardingModel.fromJson(json['onboardingData'])
                : OnboardingModel(
                    mqsCheckInDetails: [],
                    mqsDemoGraphicDetails: [],
                    mqsScenesDetails: [],
                    mqsWheelOfLifeDetails: WOLModel(
                        family: null,
                        finances: null,
                        fun: null,
                        health: null,
                        purpose: null,
                        relationship: null,
                        social: null,
                        work: null),
                  ),
        mqsEnterpriseDetails = json['mqsEnterpriseDetails'] != null
            ? EnterpriseDetails.fromJson(json['mqsEnterpriseDetails'])
            : EnterpriseDetails(
                mqsIndividualID: '',
                mqsIndividualValid: false,
                mqsOrganizationID: '',
                mqsTeamID: '',
                mqsOrganizationValid: false,
                mqsTeamValid: false,
                mqsOrganizationEmail: '',
                mqsOrganizationName: '');

  Map<String, dynamic> toJson() {
    return {
      'mqsEmail': mqsEmail,
      'mqsFirstName': mqsFirstName,
      'mqsLastName': mqsLastName,
      'mqsEnterpriseUserFlag': mqsEnterpriseUserFlag,
      'mqsFirebaseUserID': mqsFirebaseUserID,
      'mqsRegistrationStatus': mqsRegistrationStatus,
      'mqsCreatedTimestamp': mqsCreatedTimestamp,
      'mqsAbout': mqsAbout,
      'mqsAllowAbout': mqsAllowAbout,
      'mqsCountry': mqsCountry,
      'mqsAllowCountry': mqsAllowCountry,
      'mqsPronouns': mqsPronouns,
      'mqsAllowPronouns': mqsAllowPronouns,
      'mqsUserImage': mqsUserImage,
      'mqsEnterpriseID': mqsEnterpriseID,
      'mqsMONGODBUserID': mqsMONGODBUserID,
      'mqsUserLoginWith': mqsUserLoginWith,
      // 'mqsSubscriptionExpiryDate': mqsSubscriptionExpiryDate,
      // 'mqsSubscriptionActivePlan': mqsSubscriptionActivePlan,
      // 'mqsSubscriptionPlatform': mqsSubscriptionPlatform,
      'mqsUpdatedTimestamp': mqsUpdatedTimestamp,
      // 'mqsUserSubscriptionStatus': mqsUserSubscriptionStatus,
      'mqsSkipOnboarding': mqsSkipOnboarding,
      'mqsUserActiveTimestamp': mqsUserActiveTimestamp,
      'mqsEnterpriseCreatedTimestamp': mqsEnterpriseCreatedTimestamp,
      'mqsOnboardingDetails': onboardingModel.toJson(),
      'mqsEnterpriseDetails': mqsEnterpriseDetails.toJson(),
    };
  }
}

class OnboardingModel {
  final List<CheckInModel> mqsCheckInDetails;
  final List<DemographicModel> mqsDemoGraphicDetails;
  final List<ScenesModel> mqsScenesDetails;
  final WOLModel mqsWheelOfLifeDetails;

  OnboardingModel(
      {required this.mqsCheckInDetails,
      required this.mqsDemoGraphicDetails,
      required this.mqsScenesDetails,
      required this.mqsWheelOfLifeDetails});

  OnboardingModel.fromJson(Map json)
      : mqsCheckInDetails = json['mqsCheckInDetails'] != null
            ? List<CheckInModel>.from((json['mqsCheckInDetails'] as List)
                .map((model) => CheckInModel.fromJson(model)))
            : json['checkINValue'] != null
                ? List<CheckInModel>.from((json['checkINValue'] as List)
                    .map((model) => CheckInModel.fromJson(model)))
                : [],
        mqsDemoGraphicDetails = json['mqsDemoGraphicDetails'] != null
            ? List<DemographicModel>.from(
                (json['mqsDemoGraphicDetails'] as List)
                    .map((model) => DemographicModel.fromJson(model)))
            : json['demoGraphicValue'] != null
                ? List<DemographicModel>.from((json['demoGraphicValue'] as List)
                    .map((model) => DemographicModel.fromJson(model)))
                : [],
        mqsScenesDetails = json['mqsScenesDetails'] != null
            ? List<ScenesModel>.from((json['mqsScenesDetails'] as List)
                .map((model) => ScenesModel.fromJson(model)))
            : json['scenesValue'] != null
                ? List<ScenesModel>.from((json['scenesValue'] as List)
                    .map((model) => ScenesModel.fromJson(model)))
                : [],
        mqsWheelOfLifeDetails = json['mqsWheelOfLifeDetails'] != null
            ? WOLModel.fromJson(json['mqsWheelOfLifeDetails'])
            : json['wOLValue'] != null
                ? WOLModel.fromJson(json['wOLValue'])
                : WOLModel(
                    family: null,
                    finances: null,
                    fun: null,
                    health: null,
                    purpose: null,
                    relationship: null,
                    social: null,
                    work: null);

  Map<String, dynamic> toJson() {
    return {
      'mqsCheckInDetails':
          List.from((mqsCheckInDetails).map((model) => model.toJson())),
      'mqsDemoGraphicDetails':
          List.from((mqsDemoGraphicDetails).map((model) => model.toJson())),
      'mqsScenesDetails':
          List.from((mqsScenesDetails).map((model) => model.toJson())),
      'mqsWheelOfLifeDetails': mqsWheelOfLifeDetails.toJson(),
    };
  }
}

class CheckInModel {
  final num checkInScore;
  final String id;
  final num mqsCINValue;
  final String mqsTimestamp;

  CheckInModel(
      {required this.checkInScore,
      required this.id,
      required this.mqsCINValue,
      required this.mqsTimestamp});

  CheckInModel.fromJson(Map json)
      : checkInScore = json['checkInScore'] ?? 0,
        id = json['id'] ?? "",
        mqsCINValue = json['mqsCINValue'] ?? 0,
        mqsTimestamp = json['mqsTimestamp'] ?? "";

  Map<String, dynamic> toJson() {
    return {
      'checkInScore': checkInScore,
      'id': id,
      'mqsCINValue': mqsCINValue,
      'mqsTimestamp': mqsTimestamp,
    };
  }
}

class DemographicModel {
  final String currentSelectedAnswer;
  final num selectedIndex;

  DemographicModel(
      {required this.currentSelectedAnswer, required this.selectedIndex});

  DemographicModel.fromJson(Map json)
      : currentSelectedAnswer = json['currentSelectedAnswer'] ?? "",
        selectedIndex = json['selectedIndex'] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      'currentSelectedAnswer': currentSelectedAnswer,
      'selectedIndex': selectedIndex,
    };
  }
}

class ScenesModel {
  final String mqsSceneID;
  final num mqsSceneOptionGrScore;
  final String mqsSceneOptionText;
  final num mqsSceneOptionWeight;
  final num mqsSceneStScore;
  final String mqsSceneStmt;
  final String mqsTimeStamp;
  final String mqsUserOBRegDate;
  final num mqsUserOBScenesScore;

  ScenesModel(
      {required this.mqsSceneID,
      required this.mqsSceneOptionGrScore,
      required this.mqsSceneOptionText,
      required this.mqsSceneOptionWeight,
      required this.mqsSceneStScore,
      required this.mqsSceneStmt,
      required this.mqsTimeStamp,
      required this.mqsUserOBRegDate,
      required this.mqsUserOBScenesScore});

  ScenesModel.fromJson(Map json)
      : mqsSceneID = json['mqsSceneID'] ?? "",
        mqsSceneOptionGrScore = json['mqsSceneOptionGrScore'] ?? 0,
        mqsSceneOptionText = json['mqsSceneOptionText'] ?? "",
        mqsSceneOptionWeight = json['mqsSceneOptionWeight'] ?? 0,
        mqsSceneStScore = json['mqsSceneStScore'] ?? 0,
        mqsSceneStmt = json['mqsSceneStmt'] ?? "",
        mqsTimeStamp = json['mqsTimeStamp'] ?? "",
        mqsUserOBRegDate = json['mqsUserOBRegDate'] ?? "",
        mqsUserOBScenesScore = json['mqsUserOBScenesScore'] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      'mqsSceneID': mqsSceneID,
      'mqsSceneOptionGrScore': mqsSceneOptionGrScore,
      'mqsSceneOptionText': mqsSceneOptionText,
      'mqsSceneOptionWeight': mqsSceneOptionWeight,
      'mqsSceneStScore': mqsSceneStScore,
      'mqsSceneStmt': mqsSceneStmt,
      'mqsTimeStamp': mqsTimeStamp,
      'mqsUserOBRegDate': mqsUserOBRegDate,
      'mqsUserOBScenesScore': mqsUserOBScenesScore,
    };
  }
}

class WOLModel {
  final num? family;
  final num? finances;
  final num? fun;
  final num? health;
  final num? purpose;
  final num? relationship;
  final num? social;
  final num? work;

  WOLModel({
    this.family,
    this.finances,
    this.fun,
    this.health,
    this.purpose,
    this.relationship,
    this.social,
    this.work,
  });

  WOLModel.fromJson(Map<String, dynamic> json)
      : family = json['family'],
        finances = json['finances'],
        fun = json['fun'],
        health = json['health'],
        purpose = json['purpose'],
        relationship = json['relationship'],
        social = json['social'],
        work = json['work'];

  Map<String, dynamic> toJson() {
    return {
      if (family != null) 'family': family,
      if (finances != null) 'finances': finances,
      if (fun != null) 'fun': fun,
      if (health != null) 'health': health,
      if (purpose != null) 'purpose': purpose,
      if (relationship != null) 'relationship': relationship,
      if (social != null) 'social': social,
      if (work != null) 'work': work,
    };
  }
}

class EnterpriseDetails {
  final String mqsIndividualID;
  final String mqsOrganizationEmail;
  final String mqsOrganizationName;
  final bool mqsIndividualValid;
  final String mqsOrganizationID;
  final bool mqsOrganizationValid;
  final String mqsTeamID;
  final bool mqsTeamValid;

  EnterpriseDetails({
    required this.mqsIndividualID,
    required this.mqsOrganizationEmail,
    required this.mqsOrganizationName,
    required this.mqsIndividualValid,
    required this.mqsOrganizationID,
    required this.mqsOrganizationValid,
    required this.mqsTeamID,
    required this.mqsTeamValid,
  });

  EnterpriseDetails.fromJson(Map json)
      : mqsIndividualID = json['mqsIndividualID'] ?? "",
        mqsOrganizationEmail = json['mqsOrganizationEmail'] ?? "",
        mqsOrganizationName = json['mqsOrganizationName'] ?? "",
        mqsIndividualValid = json['mqsIndividualValid'] ?? false,
        mqsOrganizationID = json['mqsOrganizationID'] ?? "",
        mqsOrganizationValid = json['mqsOrganizationValid'] ?? false,
        mqsTeamID = json['mqsTeamID'] ?? "",
        mqsTeamValid = json['mqsTeamValid'] ?? false;

  Map<String, dynamic> toJson() {
    return {
      'mqsIndividualID': mqsIndividualID,
      'mqsOrganizationEmail': mqsOrganizationEmail,
      'mqsOrganizationName': mqsOrganizationName,
      'mqsIndividualValid': mqsIndividualValid,
      'mqsOrganizationID': mqsOrganizationID,
      'mqsOrganizationValid': mqsOrganizationValid,
      'mqsTeamID': mqsTeamID,
      'mqsTeamValid': mqsTeamValid,
    };
  }
}
