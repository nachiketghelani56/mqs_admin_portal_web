class UserIAMModel {
  final String email;
  final String firstName;
  final String lastName;
  final bool isEnterpriseUser;
  final String isFirebaseUserId;
  final String isRegister;
  final String mqsCreatedTimestamp;
  final String about;
  final bool aboutValue;
  final String country;
  final bool countryValue;
  final String pronouns;
  final bool pronounsValue;
  final String userImage;
  final String userName;
  final String enterpriseId;
  final String isMongoDBUserId;
  final String loginWith;
  final String mqsExpiryDate;
  final String mqsSubscriptionActivePlan;
  final String mqsSubscriptionPlatform;
  final String mqsUpdateTimestamp;
  final String mqsUserSubscriptionStatus;
  final bool mqsSkipOnboarding;
  final OnboardingModel onboardingModel;
  final String mqsUserActiveTimestamp;

  UserIAMModel(
    this.onboardingModel, {
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isEnterpriseUser,
    required this.isFirebaseUserId,
    required this.isRegister,
    required this.mqsCreatedTimestamp,
    required this.about,
    required this.aboutValue,
    required this.country,
    required this.countryValue,
    required this.pronouns,
    required this.pronounsValue,
    required this.userImage,
    required this.userName,
    required this.enterpriseId,
    required this.isMongoDBUserId,
    required this.loginWith,
    required this.mqsExpiryDate,
    required this.mqsSubscriptionActivePlan,
    required this.mqsSubscriptionPlatform,
    required this.mqsUpdateTimestamp,
    required this.mqsUserSubscriptionStatus,
    required this.mqsSkipOnboarding,
    required this.mqsUserActiveTimestamp,
  });

  UserIAMModel.fromJson(Map json)
      : email = json['Email'] ?? "",
        firstName = json['FirstName'] ?? "",
        lastName = json['LastName'] ?? "",
        isEnterpriseUser = json['isEnterPriseUser'] ?? false,
        isFirebaseUserId = json['isFirebaseUserID'] ?? "",
        isRegister = json['isRegister'] ?? "",
        mqsCreatedTimestamp = json['mqsCreatedTimestamp'] ?? "",
        about = json['About'] ?? "",
        aboutValue = json['AboutValue'] ?? false,
        country = json['Country'] ?? "",
        countryValue = json['CountryValue'] ?? false,
        pronouns = json['Pronouns'] ?? "",
        pronounsValue = json['PronounsValue'] ?? false,
        userImage = json['UserImage'] ?? "",
        userName = json['UserName'] ?? "",
        enterpriseId = json['enterPriseID'] ?? "",
        isMongoDBUserId = json['isMONGODBUserID'] ?? "",
        loginWith = json['loginWith'] ?? "",
        mqsExpiryDate = json['mqsExpiryDate'] ?? "",
        mqsSubscriptionActivePlan = json['mqsSubscriptionActivePlan'] ?? "",
        mqsSubscriptionPlatform = json['mqsSubscriptionPlatform'] ?? "",
        mqsUpdateTimestamp = json['mqsUpdateTimestamp'] ?? "",
        mqsUserSubscriptionStatus = json['mqsUserSubscriptionStatus'] ?? "",
        mqsSkipOnboarding = json['mqsSkipOnboarding'] ?? false,
        mqsUserActiveTimestamp = json['mqsUserActiveTimestamp'] ?? "",
        onboardingModel = json['onboardingData'] != null
            ? OnboardingModel.fromJson(json['onboardingData'])
            : OnboardingModel(
                checkInValue: [],
                demoGraphicValue: [],
                scenesValue: [],
                wOLValue: WOLModel(
                    family: 0,
                    finances: 0,
                    fun: 0,
                    health: 0,
                    purpose: 0,
                    relationship: 0,
                    social: 0,
                    work: 0));

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'FirstName': firstName,
      'LastName': lastName,
      'isEnterPriseUser': isEnterpriseUser,
      'isFirebaseUserID': isFirebaseUserId,
      'isRegister': isRegister,
      'mqsCreatedTimestamp': mqsCreatedTimestamp,
      'About': about,
      'AboutValue': aboutValue,
      'Country': country,
      'CountryValue': countryValue,
      'Pronouns': pronouns,
      'PronounsValue': pronounsValue,
      'UserImage': userImage,
      'enterPriseID': enterpriseId,
      'isMONGODBUserID': isMongoDBUserId,
      'loginWith': loginWith,
      'mqsExpiryDate': mqsExpiryDate,
      'mqsSubscriptionActivePlan': mqsSubscriptionActivePlan,
      'mqsSubscriptionPlatform': mqsSubscriptionPlatform,
      'mqsUpdateTimestamp': mqsUpdateTimestamp,
      'mqsUserSubscriptionStatus': mqsUserSubscriptionStatus,
      'mqsSkipOnboarding': mqsSkipOnboarding,
      'mqsUserActiveTimestamp': mqsUserActiveTimestamp,
      'onboardingData': onboardingModel.toJson(),
    };
  }
}

class OnboardingModel {
  final List<CheckInModel> checkInValue;
  final List<DemographicModel> demoGraphicValue;
  final List<ScenesModel> scenesValue;
  final WOLModel wOLValue;

  OnboardingModel(
      {required this.checkInValue,
      required this.demoGraphicValue,
      required this.scenesValue,
      required this.wOLValue});

  OnboardingModel.fromJson(Map json)
      : checkInValue = json['checkINValue'] != null
            ? List<CheckInModel>.from((json['checkINValue'] as List)
                .map((model) => CheckInModel.fromJson(model)))
            : [],
        demoGraphicValue = json['demoGraphicValue'] != null
            ? List<DemographicModel>.from((json['demoGraphicValue'] as List)
                .map((model) => DemographicModel.fromJson(model)))
            : [],
        scenesValue = json['scenesValue'] != null
            ? List<ScenesModel>.from((json['scenesValue'] as List)
                .map((model) => ScenesModel.fromJson(model)))
            : [],
        wOLValue = json['wOLValue'] != null
            ? WOLModel.fromJson(json['wOLValue'])
            : WOLModel(
                family: 0,
                finances: 0,
                fun: 0,
                health: 0,
                purpose: 0,
                relationship: 0,
                social: 0,
                work: 0);

  Map<String, dynamic> toJson() {
    return {
      'checkINValue': List.from((checkInValue).map((model) => model.toJson())),
      'demoGraphicValue':
          List.from((demoGraphicValue).map((model) => model.toJson())),
      'scenesValue': List.from((scenesValue).map((model) => model.toJson())),
      'wOLValue': wOLValue.toJson(),
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
  final num family;
  final num finances;
  final num fun;
  final num health;
  final num purpose;
  final num relationship;
  final num social;
  final num work;

  WOLModel(
      {required this.family,
      required this.finances,
      required this.fun,
      required this.health,
      required this.purpose,
      required this.relationship,
      required this.social,
      required this.work});

  WOLModel.fromJson(Map json)
      : family = json['family'] ?? 0,
        finances = json['finances'] ?? 0,
        fun = json['fun'] ?? 0,
        health = json['health'] ?? 0,
        purpose = json['purpose'] ?? 0,
        relationship = json['relationship'] ?? 0,
        social = json['social'] ?? 0,
        work = json['work'] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      'family': family,
      'finances': finances,
      'fun': fun,
      'health': health,
      'purpose': purpose,
      'relationship': relationship,
      'social': social,
      'work': work,
    };
  }
}
