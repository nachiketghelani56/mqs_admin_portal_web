import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/menu_model.dart';
import 'package:mqs_admin_portal_web/models/row_input_model.dart';
import 'package:mqs_admin_portal_web/views/circle/repository/circle_repository.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/enterprise_repository.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/user_IAM_repository.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/user_data/controller/user_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/user_subscription_receipt_data/controller/user_subscription_receipt_controller.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class DatabaseController extends GetxController {
  RxList<String> filterFields = <String>[].obs;
  RxInt selectedTabIndex = 0.obs;
  RxBool isAsc = true.obs;
  RxList<String> dataTypes = [
    StringConfig.dashboard.number,
    StringConfig.dashboard.boolean,
    StringConfig.dashboard.string
  ].obs;
  RxList<String> booleanValues = [
    StringConfig.dashboard.trueText.toLowerCase(),
    StringConfig.dashboard.falseText.toLowerCase()
  ].obs;
  final EnterpriseDataController _enterpriseDataController =
      Get.put(EnterpriseDataController());
  final CircleDataController _circleDataController =
      Get.put(CircleDataController());
  final UserSubscriptionReceiptController _userSubscriptionReceiptController =
      Get.put(UserSubscriptionReceiptController());
  final UserDataController _userDataController = Get.put(UserDataController());

  RxList<MenuModel> options = [
    MenuModel(
      title: StringConfig.dashboard.enterprise,
      icon: ImageConfig.enterpriseDatabase,
    ),
    MenuModel(
      title: StringConfig.dashboard.users,
      icon: ImageConfig.userDatabase,
    ),
    MenuModel(
      title: StringConfig.dashboard.circle,
      icon: ImageConfig.circleDatabase,
    ),
    MenuModel(
      title: StringConfig.mqsDashboard.pathway,
      icon: ImageConfig.pathwayDatabase,
    ),
    MenuModel(
      title: StringConfig.dashboard.team,
      icon: ImageConfig.teamDatabase,
    ),
    MenuModel(
      title: StringConfig.database.circleFlaggedPost,
      icon: ImageConfig.postDatabase,
    ),
    MenuModel(
      title: StringConfig.database.subscriptionReceipt,
      icon: ImageConfig.subscribeDatabase,
    ),
  ].obs;
  RxList<String> filterConditions = [
    StringConfig.dashboard.equalTo,
    StringConfig.dashboard.notEqualTo,
    StringConfig.dashboard.greaterThan,
    StringConfig.dashboard.greaterThanEqualTo,
    StringConfig.dashboard.lessThan,
    StringConfig.dashboard.lessThanEqualTo,
    StringConfig.dashboard.arrayContainingAny,
  ].obs;
  RxList<RowInputModel> rows = <RowInputModel>[].obs;
  RxInt selectedConditionIndex = RxInt(-1);
  RxInt selectedFilterFieldIndex = (-1).obs;
  RxBool showFilterByField = false.obs;
  RxBool showAddCondition = false.obs, showSortResults = false.obs;

  setFilterFields() {
    if (selectedTabIndex.value == 0) {
      filterFields.value = _enterpriseDataController.enterprises
          .expand((e) => e.toJson().keys) // Convert model to Map
          .toSet() // Ensure uniqueness
          .toList();
    } else if (selectedTabIndex.value == 1) {
      filterFields.value = _userDataController.users
          .expand((e) => e.toJson().keys) // Convert model to Map
          .toSet() // Ensure uniqueness
          .toList();
    } else if (selectedTabIndex.value == 2) {
      filterFields.value = _circleDataController.circle
          .expand((e) => e.toJson().keys) // Convert model to Map
          .toSet() // Ensure uniqueness
          .toList();
    } else if (selectedTabIndex.value == 6) {
      filterFields.value =
          _userSubscriptionReceiptController.userSubscriptionReceipts
              .expand((e) => e.toJson().keys) // Convert model to Map
              .toSet() // Ensure uniqueness
              .toList();
    }
    // else if (selectedTabIndex.value == 3 &&
    //     Get.isRegistered<PathwayController>()) {
    //   RxList<MQSMyQPathwayModel> pathway =
    //       Get.find<PathwayController>().pathway;
    //   filterFields.value = pathway
    //       .expand((e) => e.toJson().keys) // Convert model to Map
    //       .toSet() // Ensure uniqueness
    //       .toList();
    // }
  }

  String enterpriseKeyName({int? index}) {
    String keyName = filterFields[index ?? selectedFilterFieldIndex.value];
    if (keyName == StringConfig.dashboard.mqsEnterprisePOCsListKey) {
      return StringConfig.dashboard.mqsEnterprisePOCsList;
    } else if (keyName == StringConfig.firebase.mqsEnterpriseCode) {
      return StringConfig.dashboard.mqsEnterPriseCode;
    } else if (keyName == StringConfig.dashboard.mqsIsTeam) {
      return StringConfig.dashboard.team;
    } else if (keyName == StringConfig.dashboard.mqsTeamListKey) {
      return StringConfig.dashboard.mqsTeamList;
    } else if (keyName == StringConfig.dashboard.mqsEmployeeList) {
      return StringConfig.dashboard.mqsEmployeeEmailList;
    } else if (keyName ==
        StringConfig.dashboard.mqsEnterpriseSubscriptionDetails) {
      return StringConfig.dashboard.mqsEnterprisePOCsSubscriptionDetail;
    } else if (keyName == StringConfig.firebase.mqsCreatedTimestamp) {
      return StringConfig.csv.createdTimestamp;
    } else if (keyName == StringConfig.dashboard.mqsUpdatedTimestamp) {
      return StringConfig.csv.updatedTimestamp;
    }
    return "";
  }

  void addRow() {
    if (rows.length < 10) {
      rows.add(RowInputModel(
        dataType: dataTypes[0],
        textController: TextEditingController(),
        selectedBoolean: null,
      ));
    }
  }
  void removeRow(int index) {
    rows[index].textController.dispose();
    rows.removeAt(index);
  }
  String? validateInput(String dataType, String value) {
    if (value.isEmpty) return null;
    switch (dataType) {
      case "Number":
        return double.tryParse(value) == null ? "Enter a valid number" : null;
      case "Boolean":
        return (value.toLowerCase() == "true" || value.toLowerCase() == "false")
            ? null
            : "Enter true or false";
      case "String":
        return null;
      default:
        return null;
    }
  }

  Future<void> applyFilter() async {
    try {
      String field = filterFields[selectedFilterFieldIndex.value];
      int matchKey = selectedConditionIndex.value;
      _enterpriseDataController.reset();
      String condition = '';
      if (matchKey == 0) {
        condition = "==";
      } else if (matchKey == 1) {
        condition = "!=";
      } else if (matchKey == 2) {
        condition = ">";
      } else if (matchKey == 3) {
        condition = ">=";
      } else if (matchKey == 4) {
        condition = "<";
      } else if (matchKey == 5) {
        condition = "<=";
      } else if (matchKey == 6) {
        condition = "array-contains-any";
      }
      List<Map<String, dynamic>> filters = [];
      for (int i = 0; i < rows.length; i++) {
        filters.add(
          {
            'field': field,
            'condition': {
              'operator': condition,
              'type': rows[i].dataType,
              'value': rows[i].dataType == StringConfig.dashboard.boolean
                  ? rows[i].selectedBoolean.toString()
                  : rows[i].textController.text.toString(),
            },
          },
        );
      }
      if (selectedTabIndex.value == 0) {
        _enterpriseDataController.searchedEnterprises.value =
            await EnterpriseRepository.i.fetchEnterpriseFilteredData(
                field, filters, condition, isAsc.value);
      } else if (selectedTabIndex.value == 1) {
        String field2Key = "";
        if (field == StringConfig.dashboard.mqsEnterpriseUserFlag) {
          field2Key = StringConfig.firebase.isEnterPriseUser;
        } else if (field == StringConfig.firebase.mqsEmail) {
          field2Key = StringConfig.firebase.email;
        } else if (field == StringConfig.firebase.mqsFirstName) {
          field2Key = StringConfig.firebase.firstName;
        } else if (field == StringConfig.firebase.mqsLastName) {
          field2Key = StringConfig.firebase.lastName;
        } else if (field == StringConfig.firebase.mqsFirebaseUserID) {
          field2Key = StringConfig.firebase.isFirebaseUserID;
        } else if (field == StringConfig.firebase.mqsRegistrationStatus) {
          field2Key = StringConfig.firebase.isRegister;
        } else if (field == StringConfig.dashboard.mqsAbout) {
          field2Key = StringConfig.dashboard.about;
        } else if (field == StringConfig.dashboard.mqsAllowAbout) {
          field2Key = StringConfig.dashboard.aboutValue;
        } else if (field == StringConfig.dashboard.mqsCountry) {
          field2Key = StringConfig.dashboard.country;
        } else if (field == StringConfig.dashboard.mqsAllowCountry) {
          field2Key = StringConfig.dashboard.countryValue;
        } else if (field == StringConfig.dashboard.mqsPronouns) {
          field2Key = StringConfig.dashboard.pronouns;
        } else if (field == StringConfig.dashboard.mqsAllowPronouns) {
          field2Key = StringConfig.dashboard.pronounsValue;
        } else if (field == StringConfig.dashboard.mqsCheckInDetailsKey) {
          field2Key = StringConfig.dashboard.checkINValue;
        } else if (field == StringConfig.dashboard.mqsDemoGraphicDetailsKey) {
          field2Key = StringConfig.dashboard.demoGraphicValue;
        } else if (field == StringConfig.dashboard.mqsScenesDetailsKey) {
          field2Key = StringConfig.dashboard.scenesValue;
        } else if (field == StringConfig.dashboard.mqsWheelOfLifeDetailsKey) {
          field2Key = StringConfig.dashboard.wOLValue;
        } else if (field == StringConfig.dashboard.mqsUserImage) {
          field2Key = StringConfig.dashboard.userImage;
        } else if (field == StringConfig.dashboard.mqsMONGODBUserID) {
          field2Key = StringConfig.dashboard.isMongoDBUserIdText;
        } else if (field == StringConfig.dashboard.mqsUserLoginWith) {
          field2Key = StringConfig.dashboard.loginWithKey;
        } else if (field == StringConfig.dashboard.mqsUpdatedTimestamp) {
          field2Key = StringConfig.dashboard.mqsUpdateTimestamp;
        } else {
          field2Key = "";
        }

        _userDataController.searchedUsers.value = await UserRepository.i
            .fetchUserFilteredData(
                field, field2Key, filters, condition, isAsc.value);
      } else if (selectedTabIndex.value == 2) {
        _circleDataController.searchedCircle.value = await CircleRepository.i
            .fetchCircleFilteredData(field, filters, condition, isAsc.value);
      } else if (selectedTabIndex.value == 6) {
        _userSubscriptionReceiptController.searchedUserSubRec.value =
            await UserRepository.i.fetchUserSubscriptionFilteredData(
                field, filters, condition, isAsc.value);
      }
      // else if (selectedTabIndex.value == 3) {
      //   Get.find<PathwayController>().searchedPathway.value =
      //   await PathwayRepository.i.fetchPathwayFilteredData(
      //       field, filters, condition, isAsc.value);
      // }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  resetFilter() {
    // if (selectedTabIndex.value == 2) {
    //   CircleController controller = Get.find<CircleController>();
    //   controller.searchedCircle.value = controller.circle;
    // } else if (selectedTabIndex.value == 3) {
    //   PathwayController controller = Get.find<PathwayController>();
    //   controller.searchedPathway.value = controller.pathway;
    // } else {
    if (selectedTabIndex.value == 0) {
      _enterpriseDataController.searchedEnterprises.value =
          _enterpriseDataController.enterprises;
    } else if (selectedTabIndex.value == 2) {
      _circleDataController.searchedCircle.value = _circleDataController.circle;
    } else if (selectedTabIndex.value == 6) {
      _userSubscriptionReceiptController.searchedUserSubRec.value =
          _userSubscriptionReceiptController.userSubscriptionReceipts;
    } else {
      _userDataController.searchedUsers.value = _userDataController.users;
    }
    selectedFilterFieldIndex.value = -1;
    selectedConditionIndex.value = -1;
    isAsc.value = true;
    showFilterByField.value = false;
    showAddCondition.value = false;
    showSortResults.value = false;
    rows.clear();
    addRow();
    _enterpriseDataController.reset();
    _circleDataController.reset();
    _userSubscriptionReceiptController.reset();
  }

  // reset() {
  //   // if (selectedTabIndex.value == 1 &&
  //   //     Get.isRegistered<DashboardController>()) {
  //   //   viewIndex.value = -1;
  //   //   currentPage.value = 1;
  //   //   offset.value = 0;
  //   // } else if (selectedTabIndex.value == 2 &&
  //   //     Get.isRegistered<CircleController>()) {
  //   //   CircleController controller = Get.find<CircleController>();
  //   //   controller.viewIndex.value = -1;
  //   //   controller.currentPage.value = 1;
  //   //   controller.offset.value = 0;
  //   //   controller.getCircle();
  //   // } else if (selectedTabIndex.value == 3 &&
  //   //     Get.isRegistered<PathwayController>()) {
  //   //   PathwayController controller = Get.find<PathwayController>();
  //   //   controller.viewIndex.value = -1;
  //   //   controller.currentPage.value = 1;
  //   //   controller.offset.value = 0;
  //   // } else {
  //   _enterpriseDataController.viewIndex.value = -1;
  //   _enterpriseDataController.currentPage.value = 1;
  //   _enterpriseDataController.offset.value = 0;
  //   // }
  // }

  String userKeyName({int? index}) {
    String keyName = filterFields[index ?? selectedFilterFieldIndex.value];
    if (keyName == StringConfig.dashboard.email ||
        keyName == StringConfig.firebase.mqsEmail) {
      return StringConfig.dashboard.email;
    } else if (keyName == StringConfig.firebase.firstName ||
        keyName == StringConfig.firebase.mqsFirstName) {
      return StringConfig.dashboard.firstName;
    } else if (keyName == StringConfig.firebase.lastName ||
        keyName == StringConfig.firebase.mqsLastName) {
      return StringConfig.dashboard.lastName;
    } else if (keyName == StringConfig.firebase.isEnterPriseUser ||
        keyName == StringConfig.firebase.mqsEnterpriseUserFlag) {
      return StringConfig.reporting.enterpriseUser;
    } else if (keyName == StringConfig.firebase.isFirebaseUserID ||
        keyName == StringConfig.firebase.mqsFirebaseUserID) {
      return StringConfig.reporting.firebaseUserId;
    } else if (keyName == StringConfig.firebase.isRegister ||
        keyName == StringConfig.firebase.mqsRegistrationStatus) {
      return StringConfig.dashboard.registrationStatus;
    } else if (keyName == StringConfig.dashboard.mqsIsUserActive) {
      return StringConfig.dashboard.userActive;
    } else if (keyName == StringConfig.firebase.mqsCreatedTimestamp) {
      return StringConfig.csv.createdTimestamp;
    } else if (keyName == StringConfig.dashboard.about ||
        keyName == StringConfig.dashboard.mqsAbout) {
      return StringConfig.dashboard.about;
    } else if (keyName == StringConfig.dashboard.aboutValue ||
        keyName == StringConfig.dashboard.mqsAllowAbout) {
      return StringConfig.dashboard.allowAboutVisibility;
    } else if (keyName == StringConfig.dashboard.country ||
        keyName == StringConfig.dashboard.mqsCountry) {
      return StringConfig.dashboard.country;
    } else if (keyName == StringConfig.dashboard.countryValue ||
        keyName == StringConfig.dashboard.mqsAllowCountry) {
      return StringConfig.dashboard.allowCountryVisibility;
    } else if (keyName == StringConfig.dashboard.pronouns ||
        keyName == StringConfig.dashboard.mqsPronouns) {
      return StringConfig.dashboard.pronouns;
    } else if (keyName == StringConfig.dashboard.pronounsValue ||
        keyName == StringConfig.dashboard.mqsAllowPronouns) {
      return StringConfig.dashboard.allowPronounsVisibility;
    } else if (keyName == StringConfig.dashboard.userImage ||
        keyName == StringConfig.dashboard.mqsUserImage) {
      return StringConfig.dashboard.userImageText;
    } else if (keyName == StringConfig.dashboard.isMongoDBUserIdText ||
        keyName == StringConfig.dashboard.mqsMONGODBUserID) {
      return StringConfig.dashboard.mongoDBUserId;
    } else if (keyName == StringConfig.dashboard.loginWithKey ||
        keyName == StringConfig.dashboard.mqsUserLoginWith) {
      return StringConfig.dashboard.loginWithText;
    } else if (keyName == StringConfig.dashboard.mqsExpiryDate) {
      return StringConfig.reporting.expiryDate;
    } else if (keyName == StringConfig.dashboard.mqsSubscriptionActivePlan) {
      return StringConfig.dashboard.subscriptionActivePlan;
    } else if (keyName == StringConfig.dashboard.mqsSubscriptionPlatform) {
      return StringConfig.reporting.subscriptionPlatform;
    } else if (keyName == StringConfig.dashboard.mqsUpdatedTimestamp) {
      return StringConfig.csv.updatedTimestamp;
    } else if (keyName == StringConfig.dashboard.mqsUserSubscriptionStatus) {
      return StringConfig.dashboard.userSubscriptionStatus;
    } else if (keyName == StringConfig.dashboard.onboardingDataKey ||
        keyName == StringConfig.dashboard.mqsOnboardingDetails) {
      return StringConfig.dashboard.onboardingDetails;
    } else if (keyName == StringConfig.dashboard.mqsSkipOnboarding) {
      return StringConfig.dashboard.skipOnboarding;
    } else if (keyName == StringConfig.dashboard.mqsUserActiveTimestamp) {
      return StringConfig.dashboard.userActiveTimestamp;
    } else if (keyName == StringConfig.dashboard.mqsEnterpriseDetails) {
      return StringConfig.dashboard.enterpriseDetail;
    } else if (keyName ==
        StringConfig.dashboard.mqsEnterpriseCreatedTimestamp) {
      return StringConfig.dashboard.enterpriseCreatedTimestamp;
    }

    return "";
  }

  String circleKeyName({int? index}) {
    String keyName = filterFields[index ?? selectedFilterFieldIndex.value];
    if (keyName == StringConfig.firebase.flagName) {
      return StringConfig.reporting.flagName;
    } else if (keyName == StringConfig.firebase.isFlag) {
      return StringConfig.database.flag;
    } else if (keyName == StringConfig.firebase.isMainPost) {
      return StringConfig.database.mainPost;
    } else if (keyName == StringConfig.firebase.postContent) {
      return StringConfig.reporting.postContent;
    } else if (keyName == StringConfig.firebase.postTime) {
      return StringConfig.reporting.postTime;
    } else if (keyName == StringConfig.firebase.postTitle) {
      return StringConfig.reporting.postTitle;
    } else if (keyName == StringConfig.firebase.postViews) {
      return StringConfig.reporting.postViews;
    } else if (keyName == StringConfig.firebase.userIsGuide) {
      return StringConfig.database.userGuide;
    } else if (keyName == StringConfig.firebase.userId) {
      return StringConfig.dashboard.userId;
    } else if (keyName == StringConfig.firebase.userName) {
      return StringConfig.database.userName;
    } else if (keyName == StringConfig.firebase.hashtag) {
      return StringConfig.circle.hashTag;
    } else if (keyName == StringConfig.firebase.postReply) {
      return StringConfig.database.postReply;
    }
    return "";
  }

  String pathwayKeyName({int? index}) {
    String keyName = filterFields[index ?? selectedFilterFieldIndex.value];
    if (keyName == StringConfig.firebase.id) {
      return StringConfig.pathway.pathwayID;
    } else if (keyName == StringConfig.firebase.mqsAboutPathway) {
      return StringConfig.pathway.aboutPathway;
    } else if (keyName == StringConfig.firebase.mqsLearningObj) {
      return StringConfig.pathway.learningObj;
    } else if (keyName == StringConfig.firebase.mqsModuleCount) {
      return StringConfig.pathway.moduleCount;
    } else if (keyName == StringConfig.firebase.mqsPathwayCoachInstructions) {
      return StringConfig.pathway.pathwayCoachInstructions;
    } else if (keyName == StringConfig.firebase.mqsPathwayDep) {
      return StringConfig.pathway.pathwayDep;
    } else if (keyName == StringConfig.firebase.mqsPathwayDuration) {
      return StringConfig.pathway.pathwayDuration;
    } else if (keyName == StringConfig.firebase.mqsPathwayImage) {
      return StringConfig.pathway.pathwayImage;
    } else if (keyName == StringConfig.firebase.mqsPathwayIntroImage) {
      return StringConfig.pathway.pathwayIntroImage;
    } else if (keyName == StringConfig.firebase.mqsPathwayLevel) {
      return StringConfig.pathway.pathwayLevel;
    } else if (keyName == StringConfig.firebase.mqsPathwayStatus) {
      return StringConfig.pathway.pathwayStatus;
    } else if (keyName == StringConfig.firebase.mqsPathwaySubtitle) {
      return StringConfig.pathway.pathwaySubtitle;
    } else if (keyName == StringConfig.firebase.mqsPathwayTileImage) {
      return StringConfig.pathway.pathwayTileImage;
    } else if (keyName == StringConfig.firebase.mqsPathwayTitle) {
      return StringConfig.pathway.pathwayTitle;
    } else if (keyName == StringConfig.firebase.mqsPathwayType) {
      return StringConfig.pathway.pathwayType;
    } else if (keyName == StringConfig.firebase.mqsPathwayDetail) {
      return StringConfig.pathway.pathwayDetail;
    } else if (keyName == StringConfig.firebase.mqsPathwayCompletionDate) {
      return StringConfig.pathway.pathwayCompletionDate;
    } else if (keyName == StringConfig.firebase.mqsUserID) {
      return StringConfig.pathway.userId;
    }
    return "";
  }

  String userSubscriptionReceiptKeyName({int? index}) {
    String keyName = filterFields[index ?? selectedFilterFieldIndex.value];
    if (keyName == StringConfig.firebase.mqsFirebaseUserID) {
      return StringConfig.reporting.firebaseUserId;
    } else if (keyName == StringConfig.dashboard.mqsMONGODBUserID) {
      return StringConfig.reporting.mongoDbUserId;
    } else if (keyName == StringConfig.database.mqsAppSpecificSharedSecret) {
      return StringConfig.reporting.appSpecificSharedSecret;
    } else if (keyName ==
        StringConfig.database.mqsSubscriptionExpiryTimestamp) {
      return StringConfig.reporting.subscriptionExpiryDate;
    } else if (keyName == StringConfig.database.mqsLocalVerificationData) {
      return StringConfig.reporting.localVerificationData;
    } else if (keyName == StringConfig.database.mqsPackageName) {
      return StringConfig.reporting.packageName;
    } else if (keyName == StringConfig.database.mqsPurchaseID) {
      return StringConfig.reporting.purchaseId;
    } else if (keyName == StringConfig.database.mqsServerVerificationData) {
      return StringConfig.reporting.serverVerificationData;
    } else if (keyName == StringConfig.database.mqsSource) {
      return StringConfig.reporting.source;
    } else if (keyName == StringConfig.dashboard.mqsSubscriptionActivePlan) {
      return StringConfig.reporting.subscriptionActivePlan;
    } else if (keyName == StringConfig.dashboard.mqsSubscriptionPlatform) {
      return StringConfig.reporting.subscriptionPlatform;
    } else if (keyName == StringConfig.database.mqsTransactionID) {
      return StringConfig.reporting.transactionId;
    } else if (keyName == StringConfig.dashboard.mqsSubscriptionStatus) {
      return StringConfig.reporting.subscriptionStatus;
    } else if (keyName == StringConfig.firebase.mqsCreatedTimestamp) {
      return StringConfig.csv.createdTimestamp;
    } else if (keyName == StringConfig.dashboard.mqsUpdatedTimestamp) {
      return StringConfig.csv.updatedTimestamp;
    } else if (keyName ==
        StringConfig.database.mqsSubscriptionActivationTimestamp) {
      return StringConfig.csv.subscriptionActivationTimestamp;
    } else if (keyName ==
        StringConfig.database.mqsSubscriptionRenewalTimestamp) {
      return StringConfig.csv.subscriptionRenewalTimestamp;
    }
    return "";
  }
}
