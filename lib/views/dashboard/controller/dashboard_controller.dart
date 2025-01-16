import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/circle_model.dart';
import 'package:mqs_admin_portal_web/models/enterprise_model.dart';
import 'package:mqs_admin_portal_web/models/menu_option_model.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_pathway_model.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_user_iam_model.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/models/row_input_model.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/services/firebase_auth_service.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/circle/repository/circle_repository.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/enterprise_repository.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/user_IAM_repository.dart';
import 'package:mqs_admin_portal_web/views/database/circle_data/controller/circle_data_controller.dart';
import 'package:mqs_admin_portal_web/views/database/controller/circle_flagged_post_controller.dart';
import 'package:mqs_admin_portal_web/views/database/controller/database_controller.dart';
import 'package:mqs_admin_portal_web/views/database/controller/team_controller.dart';
import 'package:mqs_admin_portal_web/views/database/controller/user_subscription_receipt_controller.dart';
import 'package:mqs_admin_portal_web/views/database/enterprise_data/controller/enterprise_data_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';
import 'package:mqs_admin_portal_web/views/pathway/repository/pathway_repository.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';
import 'package:uuid/uuid.dart';

class DashboardController extends GetxController {
  RxList<String> tabs = [
    StringConfig.dashboard.enterprise,
    StringConfig.dashboard.users,
  ].obs;
  RxInt selectedTabIndex = 0.obs;
  RxString enterpriseId = "".obs;
  RxBool isHovering = false.obs;
  RxString createdTimestamp = "".obs, updateTimestamp = "".obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController subscriptionController = TextEditingController();
  final TextEditingController mqsEnterpriseCodeController =
      TextEditingController();
  final TextEditingController mqsEnterpriseNameController =
      TextEditingController();
  final TextEditingController mqsSubscriptionExpiryDateController =
      TextEditingController();
  final TextEditingController mqsSubscriptionStartDateController =
      TextEditingController();
  final TextEditingController mqsSubscriptionRenewalDateController =
      TextEditingController();
  final TextEditingController employeeEmailController = TextEditingController();
  final TextEditingController teamEmailController = TextEditingController();
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController teamMemberLimitController =
      TextEditingController();
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController pocAddressController = TextEditingController();
  final TextEditingController pocEmailController = TextEditingController();
  final TextEditingController pocNameController = TextEditingController();
  final TextEditingController pocTypeController = TextEditingController();
  final TextEditingController pocPinCodeController = TextEditingController();
  final TextEditingController pocWebsiteController = TextEditingController();
  final TextEditingController subscriptionStatusController =
      TextEditingController();
  final TextEditingController subscriptionActivePlanController =
      TextEditingController();
  final TextEditingController pocPhoneNumberController =
      TextEditingController();
  final TextEditingController filterStringFieldController =
      TextEditingController();
  final TextEditingController filterNumberFieldController =
      TextEditingController();
  RxString startDate = "".obs, expiryDate = "".obs, renewalDate = "".obs;

  RxBool mqsCommonLogin = false.obs,
      isSignedUp = false.obs,
      isCommonLogin = false.obs,
      isTeam = false.obs,
      isEnable = false.obs,
      isPocsSignedUp = false.obs;
  RxBool showMqsEmpEmailList = false.obs,
      showMqsEnterprisePocsList = false.obs,
      showMqsTeamList = false.obs,
      showMqsEnterpriseLocationDetails = false.obs,
      showMqsEnterprisePOCs = false.obs,
      isAddEnterprise = false.obs,
      isEditEnterprise = false.obs,
      showMqsUserMilestone = false.obs;
  RxList<MenuOptionModel> options = [
    MenuOptionModel(
      icon: ImageConfig.edit,
      title: StringConfig.dashboard.edit,
    ),
    MenuOptionModel(
      icon: ImageConfig.delete,
      title: StringConfig.dashboard.delete,
      color: ColorConfig.deleteColor,
    ),
  ].obs;
  RxList<String> filterFields = <String>[].obs;
  RxList<String> filterConditions = [
    StringConfig.dashboard.equalTo,
    StringConfig.dashboard.notEqualTo,
    StringConfig.dashboard.greaterThan,
    StringConfig.dashboard.greaterThanEqualTo,
    StringConfig.dashboard.lessThan,
    StringConfig.dashboard.lessThanEqualTo,
    StringConfig.dashboard.arrayContainingAny,
  ].obs;
  RxInt selectedConditionIndex = RxInt(-1);
  RxList<String> booleanValues = [
    StringConfig.dashboard.trueText.toLowerCase(),
    StringConfig.dashboard.falseText.toLowerCase()
  ].obs;
  RxBool showFilterByField = false.obs,
      showAddCondition = false.obs,
      showSortResults = false.obs,
      enterprisePOCsError = false.obs,
      teamError = false.obs;
  RxBool isAsc = true.obs;
  RxInt selectedFilterFieldIndex = (-1).obs;
  RxBool showCheckIn = false.obs,
      showDemographic = false.obs,
      showScenes = false.obs,
      showWOL = false.obs;
  RxList<int> sceneIndexes = <int>[].obs;
  RxList<EnterpriseModel> searchedEnterprises = <EnterpriseModel>[].obs,
      enterprises = <EnterpriseModel>[].obs;
  RxList<MqsEmployee> mqsEmployeeEmailList = <MqsEmployee>[].obs;
  RxList<MqsEnterprisePOCs> mqsEnterprisePOCsList = <MqsEnterprisePOCs>[].obs;
  RxList<MqsTeam> mqsTeamList = <MqsTeam>[].obs;
  RxList<MqsEnterprisePOCs> mqsEnterprisePOCs = <MqsEnterprisePOCs>[].obs;
  RxInt viewIndex = (-1).obs;
  EnterpriseModel get enterpriseDetail => searchedEnterprises[viewIndex.value];
  RxInt editMqsEmpEmailIndex = RxInt(-1),
      editMqsEntPOCIndex = RxInt(-1),
      editMqsTeamIndex = RxInt(-1);
  RxList<MQSMyQUserIamModel> searchedUsers = <MQSMyQUserIamModel>[].obs,
      users = <MQSMyQUserIamModel>[].obs,
      searchUserType = <MQSMyQUserIamModel>[].obs;
  MQSMyQUserIamModel get userDetail => searchedUsers[viewIndex.value];
  RxInt pageLimit = 10.obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  int get totalEnterprisePage =>
      (searchedEnterprises.length / pageLimit.value).ceil();
  int get totalUserPage => (searchedUsers.length / pageLimit.value).ceil();
  RxList<MQSMyQUserSubscriptionReceiptModel> userSubscriptionReceipts =
      <MQSMyQUserSubscriptionReceiptModel>[].obs;
  MQSMyQUserSubscriptionReceiptModel? get userSubscriptionDetail =>
      userSubscriptionReceipts
          .firstWhereOrNull((e) => e.mqsFirebaseUserID == userDetail.mqsUserID);
  RxList<TextEditingController> inputControllers =
      <TextEditingController>[].obs;
  RxList<String> dataTypes = [
    StringConfig.dashboard.number,
    StringConfig.dashboard.boolean,
    StringConfig.dashboard.string
  ].obs;
  RxList<RowInputModel> rows = <RowInputModel>[].obs;
  StreamSubscription<List<EnterpriseModel>>? entStream;
  StreamSubscription<List<MQSMyQUserIamModel>>? userStream;
  StreamSubscription<List<MQSMyQUserSubscriptionReceiptModel>>?
      userSubscriptionReceiptStream;
  RxBool enterpriseLoader = false.obs,
      userLoader = false.obs,
      userSubscriptionReceiptLoader = false.obs;
  List<DropdownMenuItem> get boolOptions => [
        DropdownMenuItem(
          value: true,
          child: Text(
            StringConfig.dashboard.trueText,
            style: FontTextStyleConfig.textFieldTextStyle
                .copyWith(fontSize: FontSizeConfig.fontSize16),
          ),
        ),
        DropdownMenuItem(
          value: false,
          child: Text(
            StringConfig.dashboard.falseText,
            style: FontTextStyleConfig.textFieldTextStyle
                .copyWith(fontSize: FontSizeConfig.fontSize16),
          ),
        )
      ];

  @override
  onInit() {
    getEnterprises();
    getUsers();
    getUserSubscriptionRecipts();
    super.onInit();
  }

  @override
  void onClose() async {
    await entStream?.cancel();
    await userStream?.cancel();
    await userSubscriptionReceiptStream?.cancel();
    super.onClose();
  }

  Future<void> applyFilter() async {
    try {
      String field = filterFields[selectedFilterFieldIndex.value];
      int matchKey = selectedConditionIndex.value;
      reset();
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
        searchedEnterprises.value = await EnterpriseRepository.i
            .fetchEnterpriseFilteredData(
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

        searchedUsers.value = await UserRepository.i.fetchUserFilteredData(
            field, field2Key, filters, condition, isAsc.value);
      } else if (selectedTabIndex.value == 2) {
        Get.find<CircleController>().searchedCircle.value =
            await CircleRepository.i.fetchCircleFilteredData(
                field, filters, condition, isAsc.value);
      } else if (selectedTabIndex.value == 3) {
        Get.find<PathwayController>().searchedPathway.value =
            await PathwayRepository.i.fetchPathwayFilteredData(
                field, filters, condition, isAsc.value);
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
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

  void removeRow(int index) {
    rows[index].textController.dispose();
    rows.removeAt(index);
  }

  resetFilter() {
    if (selectedTabIndex.value == 2) {
      CircleController controller = Get.find<CircleController>();
      controller.searchedCircle.value = controller.circle;
    } else if (selectedTabIndex.value == 3) {
      PathwayController controller = Get.find<PathwayController>();
      controller.searchedPathway.value = controller.pathway;
    } else {
      searchedEnterprises.value = enterprises;
      searchedUsers.value = users;
    }
    selectedFilterFieldIndex.value = -1;
    selectedConditionIndex.value = -1;
    isAsc.value = true;
    showFilterByField.value = false;
    showAddCondition.value = false;
    showSortResults.value = false;
    rows.clear();
    addRow();
    reset();
  }

  clearAllFields() {
    mqsEnterpriseCodeController.clear();
    isTeam.value = false;
    clearMqsEntPOCFields();
    clearMqsEmpEmailFields();
    clearMqsTeamFields();
    clearMqsEnterprisePocsSubscriptionDetailFields();
  }

  clearMqsEmpEmailFields() {
    employeeEmailController.clear();
    isSignedUp.value = false;
    isCommonLogin.value = false;
    employeeNameController.clear();
    mqsCommonLogin.value = false;
  }

  clearMqsTeamFields() {
    teamNameController.clear();
    isEnable.value = false;
    teamError.value = false;
    teamEmailController.clear();
    teamMemberLimitController.clear();
  }

  clearMqsEnterprisePocsSubscriptionDetailFields() {
    subscriptionStatusController.clear();
    mqsSubscriptionStartDateController.clear();
    mqsSubscriptionExpiryDateController.clear();
    mqsSubscriptionRenewalDateController.clear();
    expiryDate.value = "";
    startDate.value = "";
    renewalDate.value = "";
    subscriptionActivePlanController.clear();
  }

  clearMqsEntPOCFields() {
    pocAddressController.clear();
    pocEmailController.clear();
    pocNameController.clear();
    pocWebsiteController.clear();
    pocPhoneNumberController.clear();
    pocTypeController.clear();
    pocPinCodeController.clear();
    isSignedUp.value = false;
    enterprisePOCsError.value = false;
  }

  getEnterprises() async {
    try {
      enterpriseLoader.value = true;
      List<EnterpriseModel> enterpriseList =
          await EnterpriseRepository.i.getEnterprises();
      searchedEnterprises.value = enterpriseList;
      enterprises.value = enterpriseList;
      entStream =
          EnterpriseRepository.i.getEnterpriseStream().listen((enterpriseList) {
        searchedEnterprises.value = enterpriseList; // Update searched list
        enterprises.value = enterpriseList; // Update full list
        viewIndex.value = -1;
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {
      enterpriseLoader.value = false;
    }
  }

  getUsers() async {
    try {
      if (!FirebaseAuthService.i.isMarketingUser) {
        userLoader.value = true;

        List<MQSMyQUserIamModel> userList = await UserRepository.i.getUsers();
        searchedUsers.value = userList;
        users.value = userList;
        searchUserType.value = userList;
        userStream = UserRepository.i.getUserStream().listen((data) {
          searchedUsers.value = data;
          searchUserType.value = data;
          users.value = data;
          viewIndex.value = -1;
        });
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {
      userLoader.value = false;
    }
  }

  getUserSubscriptionRecipts() async {
    try {
      userSubscriptionReceiptLoader.value = true;
      userSubscriptionReceipts.value =
          await UserRepository.i.getUserSubscriptionReceipt();
      userSubscriptionReceiptStream =
          UserRepository.i.getUserSubscriptionReceiptStream().listen((data) {
        userSubscriptionReceipts.value = data;
        viewIndex.value = -1;
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {
      userSubscriptionReceiptLoader.value = false;
    }
  }

  addMqsTeam() {
    mqsTeamList.add(
      MqsTeam(
        mqsTeamID: const Uuid().v4().replaceAll('-', '').substring(0, 24),
        mqsTeamName: teamNameController.text.trim(),
        mqsTeamEmail: teamEmailController.text.trim(),
        mqsTeamMembersLimit: int.parse(teamMemberLimitController.text),
        mqsIsEnable:
            int.parse(teamMemberLimitController.text) == 0 ? false : true,
      ),
    );
    clearMqsTeamFields();
    showMqsTeamList.value = false;
  }

  editMqsTeam() {
    mqsTeamList[editMqsTeamIndex.value].mqsTeamName =
        teamNameController.text.trim();
    mqsTeamList[editMqsTeamIndex.value].mqsTeamEmail = teamEmailController.text;
    mqsTeamList[editMqsTeamIndex.value].mqsTeamMembersLimit =
        int.parse(teamMemberLimitController.text);

    clearMqsEmpEmailFields();
    editMqsTeamIndex.value = -1;
    showMqsTeamList.value = false;
  }

  addMqsEmpEmail() {
    mqsEmployeeEmailList.add(
      MqsEmployee(
        mqsEmployeeID: const Uuid().v4().replaceAll('-', '').substring(0, 24),
        mqsEmployeeName: employeeNameController.text.trim(),
        mqsEmployeeEmail: employeeEmailController.text.trim(),
        mqsIsSignUp: false,
        mqsCommonLogin: mqsCommonLogin.value,
      ),
    );
    clearMqsEmpEmailFields();
    showMqsEmpEmailList.value = false;
  }

  editMqsEnterprisePOCs() {
    mqsEnterprisePOCsList[editMqsEntPOCIndex.value].mqsEnterpriseName =
        pocNameController.text.trim();
    mqsEnterprisePOCsList[editMqsEntPOCIndex.value].mqsEnterpriseEmail =
        pocEmailController.text.trim();
    mqsEnterprisePOCsList[editMqsEntPOCIndex.value].mqsEnterprisePhoneNumber =
        pocPhoneNumberController.text.trim();
    mqsEnterprisePOCsList[editMqsEntPOCIndex.value].mqsEnterpriseType =
        pocTypeController.text.trim();
    mqsEnterprisePOCsList[editMqsEntPOCIndex.value].mqsEnterpriseWebsite =
        pocWebsiteController.text.trim();
    mqsEnterprisePOCsList[editMqsEntPOCIndex.value].mqsEnterpriseAddress =
        pocAddressController.text.trim();
    mqsEnterprisePOCsList[editMqsEntPOCIndex.value].mqsEnterprisePincode =
        pocPinCodeController.text.trim();

    clearMqsEntPOCFields();
    editMqsEntPOCIndex.value = -1;
    showMqsEnterprisePocsList.value = false;
  }

  addMqsEnterprisePOCsEmail() {
    mqsEnterprisePOCsList.add(
      MqsEnterprisePOCs(
        mqsEnterpriseID: '',
        mqsEnterpriseName: pocNameController.text.trim(),
        mqsEnterpriseEmail: pocEmailController.text.trim(),
        mqsEnterpriseType: pocTypeController.text.trim(),
        mqsEnterprisePhoneNumber: pocPhoneNumberController.text.trim(),
        mqsEnterpriseWebsite: pocWebsiteController.text.trim(),
        mqsEnterpriseAddress: pocAddressController.text.trim(),
        mqsEnterprisePincode: pocPinCodeController.text.trim(),
        mqsIsSignUp: false,
      ),
    );
    clearMqsEntPOCFields();
    showMqsEnterprisePocsList.value = false;
  }

  setMqsTeamForm({required int index}) {
    editMqsTeamIndex.value = index;
    teamNameController.text = mqsTeamList[index].mqsTeamName;
    teamEmailController.text = mqsTeamList[index].mqsTeamEmail;
    teamMemberLimitController.text =
        "${mqsTeamList[index].mqsTeamMembersLimit}";
    showMqsTeamList.value = true;
  }

  setMqsEmpEmailForm({required int index}) {
    editMqsEmpEmailIndex.value = index;
    employeeEmailController.text = mqsEmployeeEmailList[index].mqsEmployeeEmail;

    employeeNameController.text = mqsEmployeeEmailList[index].mqsEmployeeName;
    mqsCommonLogin.value = mqsEmployeeEmailList[index].mqsCommonLogin;
    showMqsEmpEmailList.value = true;
  }

  setMqsEnterprisePOCsForm({required int index}) {
    editMqsEntPOCIndex.value = index;
    pocNameController.text = mqsEnterprisePOCsList[index].mqsEnterpriseName;
    pocEmailController.text = mqsEnterprisePOCsList[index].mqsEnterpriseEmail;
    pocPhoneNumberController.text =
        mqsEnterprisePOCsList[index].mqsEnterprisePhoneNumber;
    pocTypeController.text = mqsEnterprisePOCsList[index].mqsEnterpriseType;
    pocWebsiteController.text =
        mqsEnterprisePOCsList[index].mqsEnterpriseWebsite;
    pocAddressController.text =
        mqsEnterprisePOCsList[index].mqsEnterpriseAddress;
    pocPinCodeController.text =
        mqsEnterprisePOCsList[index].mqsEnterprisePincode;

    showMqsEnterprisePocsList.value = true;
  }

  editMqsEmpEmail() {
    mqsEmployeeEmailList[editMqsEmpEmailIndex.value].mqsEmployeeName =
        employeeNameController.text.trim();
    mqsEmployeeEmailList[editMqsEmpEmailIndex.value].mqsEmployeeEmail =
        employeeEmailController.text.trim();
    mqsEmployeeEmailList[editMqsEmpEmailIndex.value].mqsCommonLogin =
        mqsCommonLogin.value;
    clearMqsEmpEmailFields();
    editMqsEmpEmailIndex.value = -1;
    showMqsEmpEmailList.value = false;
  }

  deleteMqsEnterprisePOCs({required int index}) {
    mqsEnterprisePOCsList.removeAt(index);
  }

  deleteMqsEmpEmial({required int index}) {
    mqsEmployeeEmailList.removeAt(index);
  }

  deleteMqsTeam({required int index}) {
    mqsTeamList.removeAt(index);
  }

  deleteMqsEntPOC({required int index}) {
    mqsEnterprisePOCs.removeAt(index);
  }

  addEnterprise() async {
    try {
      if (mqsEnterprisePOCsList.isNotEmpty && mqsTeamList.isNotEmpty) {
        enterprisePOCsError.value = false;
        teamError.value = false;
        final docRef = FirebaseStorageService.i.enterprise.doc().id;
        final enterprise = EnterpriseModel(
          docId: isEditEnterprise.value ? enterpriseId.value : docRef,

          mqsEnterprisePOCsList: mqsEnterprisePOCsList.map((item) {
            return MqsEnterprisePOCs(
              mqsEnterpriseID:
                  isEditEnterprise.value ? enterpriseId.value : docRef,
              mqsEnterpriseName: item.mqsEnterpriseName,
              mqsEnterpriseEmail: item.mqsEnterpriseEmail,
              mqsEnterprisePhoneNumber: item.mqsEnterprisePhoneNumber,
              mqsEnterpriseType: item.mqsEnterpriseType,
              mqsEnterpriseWebsite: item.mqsEnterpriseWebsite,
              mqsEnterpriseAddress: item.mqsEnterpriseAddress,
              mqsEnterprisePincode: item.mqsEnterprisePincode,
              mqsIsSignUp: false,
            );
          }).toList(),
          mqsEnterpriseCode: mqsEnterpriseCodeController.text,
          // mqsIsTeam: mqsTeamList.isNotEmpty ? true : false,
          mqsTeamList: mqsTeamList,
          mqsEmployeeList: mqsEmployeeEmailList,
          mqsEnterpriseSubscriptionDetails: MqsEnterpriseSubscriptionDetails(
            mqsSubscriptionStatus: subscriptionStatusController.text.trim(),
            mqsSubscriptionActivePlan:
                subscriptionActivePlanController.text.trim(),
            mqsSubscriptionActivationTimestamp: startDate.value.trim(),
            mqsSubscriptionExpiryTimestamp: expiryDate.value.trim(),
            mqsSubscriptionRenewalDate:
                isEditEnterprise.value ? renewalDate.value.trim() : "",
          ),
          mqsCreatedTimestamp: isEditEnterprise.value
              ? createdTimestamp.value
              : DateTime.now().toIso8601String(),
          mqsUpdatedTimestamp: DateTime.now().toIso8601String(),
        );

        showLoader();

        if (isEditEnterprise.value) {
          await EnterpriseRepository.i.editEnterprises(
              enterpriseModel: enterprise, docId: enterpriseId.value);
        } else {
          await EnterpriseRepository.i
              .addEnterprises(enterpriseModel: enterprise, customId: docRef);
        }
        hideLoader();
        clearAllFields();
        isAddEnterprise.value = false;
        isEditEnterprise.value = false;
        if (Get.currentRoute == AppRoutes.addEnterprise) {
          Get.back();
        }
      } else {
        if (mqsEnterprisePOCsList.isEmpty) {
          enterprisePOCsError.value = true;
        }
        if (mqsTeamList.isEmpty) {
          teamError.value = true;
        }
      }
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  setEnterpriseForm({required int index}) {
    enterpriseId.value = enterpriseDetail.docId;
    mqsEnterpriseCodeController.text = enterpriseDetail.mqsEnterpriseCode;

    subscriptionActivePlanController.text = enterpriseDetail
        .mqsEnterpriseSubscriptionDetails.mqsSubscriptionActivePlan;
    subscriptionStatusController.text =
        enterpriseDetail.mqsEnterpriseSubscriptionDetails.mqsSubscriptionStatus;
    mqsSubscriptionStartDateController.text = dateConvert(enterpriseDetail
        .mqsEnterpriseSubscriptionDetails.mqsSubscriptionActivationTimestamp);
    mqsSubscriptionExpiryDateController.text = dateConvert(enterpriseDetail
        .mqsEnterpriseSubscriptionDetails.mqsSubscriptionExpiryTimestamp);
    mqsSubscriptionRenewalDateController.text = dateConvert(enterpriseDetail
        .mqsEnterpriseSubscriptionDetails.mqsSubscriptionRenewalDate);
    startDate.value = enterpriseDetail.mqsEnterpriseSubscriptionDetails
            .mqsSubscriptionActivationTimestamp.isEmpty
        ? ""
        : DateTime.parse(enterpriseDetail.mqsEnterpriseSubscriptionDetails
                .mqsSubscriptionActivationTimestamp)
            .toIso8601String();
    expiryDate.value = enterpriseDetail.mqsEnterpriseSubscriptionDetails
            .mqsSubscriptionExpiryTimestamp.isEmpty
        ? ""
        : DateTime.parse(enterpriseDetail.mqsEnterpriseSubscriptionDetails
                .mqsSubscriptionExpiryTimestamp)
            .toIso8601String();
    renewalDate.value = enterpriseDetail
            .mqsEnterpriseSubscriptionDetails.mqsSubscriptionRenewalDate.isEmpty
        ? ""
        : DateTime.parse(enterpriseDetail
                .mqsEnterpriseSubscriptionDetails.mqsSubscriptionRenewalDate)
            .toIso8601String();
    mqsEmployeeEmailList.value = enterpriseDetail.mqsEmployeeList;
    mqsEnterprisePOCsList.value = enterpriseDetail.mqsEnterprisePOCsList;
    mqsTeamList.value = enterpriseDetail.mqsTeamList;
    createdTimestamp.value = enterpriseDetail.mqsCreatedTimestamp;
  }

  deleteEnterprise({required String docId}) async {
    try {
      showLoader();
      viewIndex.value = 0;
      isAddEnterprise.value = false;
      isEditEnterprise.value = false;
      await EnterpriseRepository.i.deleteEnterprises(docId: docId);
      hideLoader();
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  importEnterprise() async {
    try {
      final result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['csv']);
      if (result != null) {
        String csvData = utf8.decode(result.files.single.bytes ?? []);
        List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

        if (rows.isEmpty) {
          return;
        }

        List<String> headers = rows[0].map((e) => e.toString()).toList();
        for (int i = 1; i < rows.length; i++) {
          Map<String, dynamic> rowMap = {
            for (int j = 0; j < headers.length; j++) headers[j]: rows[i][j]
          };

          List<MqsEnterprisePOCs> mqsEnterprisePOCsList = [];

          if (rowMap['Enterprise POCs'] != null &&
              rowMap['Enterprise POCs'].toString().isNotEmpty) {
            try {
              List<dynamic> enterprisePOCs =
                  jsonDecode(rowMap['Enterprise POCs']);
              mqsEnterprisePOCsList = enterprisePOCs.map((enterprise) {
                return MqsEnterprisePOCs(
                  mqsEnterpriseID: enterprise['mqsEnterpriseID'] ?? "",
                  mqsEnterpriseName: enterprise['mqsEnterpriseName'] ?? "",
                  mqsEnterpriseEmail: enterprise['mqsEnterpriseEmail'] ?? "",
                  mqsEnterpriseType: enterprise['mqsEnterpriseType'] ?? "",
                  mqsEnterprisePhoneNumber:
                      enterprise['mqsEnterprisePhoneNumber'] ?? "",
                  mqsEnterpriseWebsite:
                      enterprise['mqsEnterpriseWebsite'] ?? "",
                  mqsEnterpriseAddress:
                      enterprise['mqsEnterpriseAddress'] ?? "",
                  mqsEnterprisePincode:
                      enterprise['mqsEnterprisePincode'] ?? "",
                  mqsIsSignUp:
                      enterprise['mqsIsSignUp']?.toString().toLowerCase() ==
                          'true',
                );
              }).toList();
            } catch (e) {
              errorDialogWidget(msg: e.toString());
            }
          }
          List<MqsEmployee> mqsEmployeeList = [];

          if (rowMap['Employees'] != null &&
              rowMap['Employees'].toString().isNotEmpty) {
            try {
              List<dynamic> employees = jsonDecode(rowMap['Employees']);
              mqsEmployeeList = employees.map((employee) {
                return MqsEmployee(
                  mqsEmployeeID: employee['mqsEmployeeID'] ?? "",
                  mqsEmployeeName: employee['mqsEmployeeName'] ?? "",
                  mqsEmployeeEmail: employee['mqsEmployeeEmail'] ?? "",
                  mqsIsSignUp:
                      employee['mqsIsSignUp']?.toString().toLowerCase() ==
                          'true',
                  mqsCommonLogin:
                      employee['mqsCommonLogin']?.toString().toLowerCase() ==
                          'true',
                );
              }).toList();
            } catch (e) {
              errorDialogWidget(msg: e.toString());
            }
          }
          List<MqsTeam> mqsTeamList = [];
          if (rowMap['Teams'] != null &&
              rowMap['Teams'].toString().isNotEmpty) {
            try {
              List<dynamic> teams = jsonDecode(rowMap['Teams']);
              mqsTeamList = teams.map((team) {
                return MqsTeam(
                  mqsTeamID: team['mqsTeamID'] ?? "",
                  mqsTeamName: team['mqsTeamName'] ?? "",
                  mqsTeamEmail: team['mqsTeamEmail'] ?? "",
                  mqsTeamMembersLimit: team['mqsTeamMembersLimit'] ?? 0,
                  mqsIsEnable:
                      team['mqsIsEnable'].toString().toLowerCase() == 'true',
                );
              }).toList();
            } catch (e) {
              errorDialogWidget(msg: e.toString());
            }
          }

          final docRef = FirebaseStorageService.i.enterprise.doc().id;
          EnterpriseModel enterprise = EnterpriseModel(
            docId: docRef,
            mqsEnterpriseCode: rowMap['Enterprise Code'].toString(),
            // mqsIsTeam: rowMap['Is Team']?.toString().toLowerCase() == 'true',
            mqsTeamList: mqsTeamList,
            mqsEmployeeList: mqsEmployeeList,
            mqsEnterpriseSubscriptionDetails: MqsEnterpriseSubscriptionDetails(
              mqsSubscriptionStatus: rowMap['Subscription Status'] ?? "",
              mqsSubscriptionActivePlan:
                  rowMap['Subscription Active Plan'] ?? "",
              mqsSubscriptionActivationTimestamp:
                  rowMap['Subscription Activation Date'].toString().isEmpty
                      ? ""
                      : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                          .parse(rowMap['Subscription Activation Date'])
                          .toIso8601String(),
              mqsSubscriptionExpiryTimestamp:
                  rowMap['Subscription Expiry Date'].toString().isEmpty
                      ? ""
                      : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                          .parse(rowMap['Subscription Expiry Date'])
                          .toIso8601String(),
              mqsSubscriptionRenewalDate:
                  rowMap['Subscription Renewal Date'].toString().isEmpty
                      ? ""
                      : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                          .parse(rowMap['Subscription Renewal Date'])
                          .toIso8601String(),
            ),
            mqsCreatedTimestamp: rowMap['Created Timestamp'].toString().isEmpty
                ? ""
                : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .parse(rowMap['Created Timestamp'])
                    .toIso8601String(),
            mqsUpdatedTimestamp: rowMap['Updated Timestamp'].toString().isEmpty
                ? ""
                : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .parse(rowMap['Updated Timestamp'])
                    .toIso8601String(),
            mqsEnterprisePOCsList: mqsEnterprisePOCsList,
          );
          await EnterpriseRepository.i
              .addEnterprises(enterpriseModel: enterprise, customId: docRef);
        }
      }
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    }
  }

  exportEnterprise(List<EnterpriseModel> enterpriseModels) async {
    try {
      List<List<String>> rows = [
        [
          StringConfig.dashboard.mqsEnterPriseCode,
          StringConfig.dashboard.mqsEnterprisePOCs,
          StringConfig.csv.teams,
          StringConfig.reporting.employees,
          StringConfig.dashboard.subscriptionStatus,
          StringConfig.dashboard.subscriptionActivePlan,
          StringConfig.dashboard.mqsSubscriptionActivationDate,
          StringConfig.dashboard.mqsSubscriptionRenewalDate,
          StringConfig.dashboard.mqsSubscriptionExpiryDate,
          StringConfig.csv.createdTimestamp,
          StringConfig.csv.updatedTimestamp,
        ],
        // Data Rows
        // enterprises
        ...searchedEnterprises.map((model) {
          return [
            model.mqsEnterpriseCode,
            jsonEncode(
                model.mqsEnterprisePOCsList.map((p) => p.toJson()).toList()),

            jsonEncode(model.mqsTeamList.map((p) => p.toJson()).toList()),
            jsonEncode(model.mqsEmployeeList.map((p) => p.toJson()).toList()),
            model.mqsEnterpriseSubscriptionDetails.mqsSubscriptionStatus,
            model.mqsEnterpriseSubscriptionDetails.mqsSubscriptionActivePlan,
            dateConvert(model.mqsEnterpriseSubscriptionDetails
                .mqsSubscriptionActivationTimestamp),
            dateConvert(model
                .mqsEnterpriseSubscriptionDetails.mqsSubscriptionRenewalDate),
            dateConvert(model.mqsEnterpriseSubscriptionDetails
                .mqsSubscriptionExpiryTimestamp),
            dateConvert(model.mqsCreatedTimestamp),
            dateConvert(model.mqsUpdatedTimestamp),
          ];
        }),
      ];
      String csvData = const ListToCsvConverter().convert(rows);
      Uint8List bytes = Uint8List.fromList(utf8.encode(csvData));
      await FileSaver.instance.saveFile(
        bytes: bytes,
        ext: "csv",
        mimeType: MimeType.csv,
        name: StringConfig.dashboard.enterpriseCollection,
      );
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  setTabIndex({required int index}) {

    final MqsDashboardController mqsDashboardController =
        Get.put(MqsDashboardController());
    mqsDashboardController.enterpriseStatus.value="";
    mqsDashboardController.circleStatus.value="";
    // if (mqsDashboardController.menuIndex.value == 0) {
      final CircleController circleController = Get.put(CircleController());

      if (FirebaseAuthService.i.isMarketingUser) {
        selectedTabIndex.value = 1;
      } else {
        selectedTabIndex.value = index;
      }
      searchController.clear();
      searchedUsers.value = users;
      searchedEnterprises.value = enterprises;
      isAddEnterprise.value = false;
      isEditEnterprise.value = false;
      circleController.isAdd.value = false;
      circleController.isEdit.value = false;
      reset();

      setFilterFields();
      if (Get.isRegistered<ReportingController>()) {
        Get.find<ReportingController>().reportType.value = '';
      }
      if (!FirebaseAuthService.i.isMarketingUser && index == 1) {
        getUsers();
      }
    // }
    if (mqsDashboardController.menuIndex.value == 1)  {
      final DatabaseController databaseController =
          Get.put(DatabaseController());
      final EnterpriseDataController enterpriseDataController =
          Get.put(EnterpriseDataController());
      final TeamController teamController = Get.put(TeamController());

      final CircleFlaggedPostController circleFlaggedPostController =
          Get.put(CircleFlaggedPostController());
      final CircleDataController circleDataController =
          Get.put(CircleDataController());
      final UserSubscriptionReceiptController
          userSubscriptionReceiptController =
          Get.put(UserSubscriptionReceiptController());
      databaseController.selectedTabIndex.value = index;
      if(index == 2){
        circleDataController.searchController.clear();

        circleDataController.isAdd.value = false;
        circleDataController.isEdit.value = false;
        circleDataController.reset();
        circleDataController.getCircle();
      } else {
        enterpriseDataController.searchController.clear();
        // searchedUsers.value = users;
        enterpriseDataController.searchedEnterprises.value = enterprises;
        enterpriseDataController.isAddEnterprise.value = false;
        enterpriseDataController.isEditEnterprise.value = false;
        userSubscriptionReceiptController.reset();
        teamController.reset();
        circleFlaggedPostController.reset();
        enterpriseDataController.reset();

        databaseController.setFilterFields();
      }
    }
  }

  reset() {
    if (selectedTabIndex.value == 1 &&
        Get.isRegistered<DashboardController>()) {
      viewIndex.value = -1;
      currentPage.value = 1;
      offset.value = 0;
    } else if (selectedTabIndex.value == 2 &&
        Get.isRegistered<CircleController>()) {
      CircleController controller = Get.find<CircleController>();
      controller.viewIndex.value = -1;
      controller.currentPage.value = 1;
      controller.offset.value = 0;
      controller.getCircle();
    } else if (selectedTabIndex.value == 3 &&
        Get.isRegistered<PathwayController>()) {
      PathwayController controller = Get.find<PathwayController>();
      controller.viewIndex.value = -1;
      controller.currentPage.value = 1;
      controller.offset.value = 0;
    } else {
      viewIndex.value = -1;
      currentPage.value = 1;
      offset.value = 0;
    }
  }

  setFilterFields() {
    if (selectedTabIndex.value == 0) {
      filterFields.value = enterprises
          .expand((e) => e.toJson().keys) // Convert model to Map
          .toSet() // Ensure uniqueness
          .toList();
    } else if (selectedTabIndex.value == 1) {
      filterFields.value = users
          .expand((e) => e.toJson().keys) // Convert model to Map
          .toSet() // Ensure uniqueness
          .toList();
    } else if (selectedTabIndex.value == 2 &&
        Get.isRegistered<CircleController>()) {
      RxList<CircleModel> circle = Get.find<CircleController>().circle;
      filterFields.value = circle
          .expand((e) => e.toJson().keys) // Convert model to Map
          .toSet() // Ensure uniqueness
          .toList();
    } else if (selectedTabIndex.value == 3 &&
        Get.isRegistered<PathwayController>()) {
      RxList<MQSMyQPathwayModel> pathway =
          Get.find<PathwayController>().pathway;
      filterFields.value = pathway
          .expand((e) => e.toJson().keys) // Convert model to Map
          .toSet() // Ensure uniqueness
          .toList();
    }
  }

  getMaxOffset({bool? isReport}) {
    int rem = (selectedTabIndex.value == 0 || isReport == true
            ? searchedEnterprises.length
            : (searchedUsers.length)) %
        pageLimit.value;
    if (rem != 0 &&
        currentPage.value ==
            (selectedTabIndex.value == 0 || isReport == true
                ? totalEnterprisePage
                : totalUserPage)) {
      return offset.value + rem;
    }
    return offset.value + pageLimit.value;
  }

  prevPage() {
    try {
      if (currentPage > 1) {
        offset.value = offset.value - pageLimit.value;
        currentPage.value--;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  nextPage() {
    try {
      if (currentPage.value <
          (selectedTabIndex.value == 0 ? totalEnterprisePage : totalUserPage)) {
        offset.value = offset.value + pageLimit.value;
        currentPage.value++;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  searchEnterprise() {
    try {
      reset();
      String query = searchController.text.trim().toLowerCase();
      if (query.isEmpty) {
        searchedEnterprises.value = enterprises;
      } else {
        searchedEnterprises.value = enterprises.where((e) {
          return e.mqsEnterpriseCode.toLowerCase().contains(query) ||
              e.mqsEnterprisePOCsList.any((poc) {
                return poc.mqsEnterpriseName.toLowerCase().contains(query) ||
                    poc.mqsEnterpriseEmail.toLowerCase().contains(query) ||
                    poc.mqsEnterprisePhoneNumber
                        .toLowerCase()
                        .contains(query) ||
                    poc.mqsEnterpriseType.toLowerCase().contains(query) ||
                    poc.mqsEnterpriseWebsite.toLowerCase().contains(query) ||
                    poc.mqsEnterpriseAddress.toLowerCase().contains(query) ||
                    poc.mqsEnterprisePincode.toLowerCase().contains(query);
              }) ||
              e.mqsEnterpriseSubscriptionDetails.mqsSubscriptionActivePlan
                  .toLowerCase()
                  .contains(query) ||
              e.mqsEnterpriseSubscriptionDetails.mqsSubscriptionStatus
                  .toLowerCase()
                  .contains(query);
        }).toList();
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  bool checkEnterprisePOCsSubscriptionDetail() {
    if (enterpriseDetail.mqsEnterpriseSubscriptionDetails
            .mqsSubscriptionActivationTimestamp.isEmpty &&
        enterpriseDetail.mqsEnterpriseSubscriptionDetails
            .mqsSubscriptionExpiryTimestamp.isEmpty &&
        enterpriseDetail.mqsEnterpriseSubscriptionDetails
            .mqsSubscriptionActivePlan.isEmpty &&
        enterpriseDetail
            .mqsEnterpriseSubscriptionDetails.mqsSubscriptionStatus.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  String dateConvert(String date) {
    if (date.isNotEmpty) {
      final formattedDateTime = DateFormat(StringConfig.dashboard.dateYYYYMMDD)
          .format(DateTime.parse(date));

      return formattedDateTime;
    } else {
      return "";
    }
  }

  Future<void> pickStartDateTime(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      firstDate: DateTime(0),
      lastDate: DateTime(3000),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        final formattedDateTime =
            DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                .format(pickedDateTime);

        mqsSubscriptionStartDateController.text = formattedDateTime;

        startDate.value = pickedDateTime.toIso8601String();
      }
    }
  }

  Future<void> pickExpiryDateTime(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      firstDate: isEditEnterprise.value
          ? renewalDate.isEmpty
              ? DateTime.parse(
                  startDate.value,
                )
              : DateTime.parse(
                  renewalDate.value,
                )
          : startDate.value.isNotEmpty
              ? DateTime.parse(
                  startDate.value,
                )
              : DateTime.now(),
      lastDate: DateTime(3000),
      initialDate: isEditEnterprise.value
          ? renewalDate.isEmpty
              ? DateTime.parse(
                  startDate.value,
                )
              : DateTime.parse(
                  renewalDate.value,
                )
          : startDate.value.isNotEmpty
              ? DateTime.parse(
                  startDate.value,
                )
              : DateTime.now(),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        final formattedDateTime =
            DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                .format(pickedDateTime);

        mqsSubscriptionExpiryDateController.text = formattedDateTime;

        expiryDate.value = pickedDateTime.toIso8601String();
      }
    }
  }

  Future<void> pickRenewalDateTime(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      firstDate: DateTime(0),
      lastDate: DateTime(3000),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        final formattedDateTime =
            DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                .format(pickedDateTime);

        mqsSubscriptionRenewalDateController.text = formattedDateTime;

        renewalDate.value = pickedDateTime.toIso8601String();
        mqsSubscriptionExpiryDateController.clear();

        expiryDate.value = "";
      }
    }
  }

  exportUserIAM() async {
    try {
      List<MQSMyQUserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();

      String currentDate =
          DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(DateTime(0));
      List<List<String>> rows = [];

      rows = [
        ...searchedUsers.map((model) {
          return [
            model.mqsEmail ?? "",
            model.mqsFirstName ?? "",
            model.mqsLastName ?? "",
            model.mqsCreatedTimestamp?.isNotEmpty ?? false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .format(DateTime.parse(model.mqsCreatedTimestamp ?? ""))
                : model.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                        DateTime.parse(
                            model.mqsEnterpriseCreatedTimestamp ?? ""))
                    : DateTime.now().toIso8601String(),
            "${model.mqsEnterpriseUserFlag}",
            model.mqsUserID ?? "",
            model.mqsMONGODBUserID ?? "",
            model.mqsUserLoginWith ?? "",
            model.mqsUserActiveTimestamp?.isNotEmpty ?? false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .format(DateTime.parse(model.mqsUserActiveTimestamp ?? ""))
                : "",
            model.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(model.mqsEnterpriseCreatedTimestamp ?? ""))
                : "",
            model.mqsRegistrationStatus ?? "",
            json.encode(receipt
                .where((e) => e.mqsFirebaseUserID == model.mqsUserID)
                .toList()),
            jsonEncode(model.mqsEnterpriseDetails?.toJson()),
            jsonEncode(model.mqsOnboardingDetails?.toJson()),
            jsonEncode(model.mqsEnterpriseDetails?.toJson()),
            jsonEncode(model.mqsUserJMStatus?.toJson()),
            jsonEncode(model.mqsUserChallengesStatus?.toJson()),
            jsonEncode(model.mqsPrivacySettingsDetails?.toJson()),
            jsonEncode(model.mqsUserGrowth?.toJson()),
            jsonEncode(model.mqsUserProfile?.toJson()),
            jsonEncode(model.mqsUserMilestones?.isNotEmpty ?? false
                ? model.mqsUserMilestones?.toList()
                : []),
          ];
        }),
      ];

      rows.sort((a, b) => DateFormat(StringConfig.dashboard.dateYYYYMMDD)
          .parse(b[3].isNotEmpty ? b[3] : currentDate)
          .compareTo(DateFormat(StringConfig.dashboard.dateYYYYMMDD)
              .parse(a[3].isNotEmpty ? a[3] : currentDate)));
      rows.insert(
        0,
        [
          StringConfig.dashboard.email,
          StringConfig.dashboard.firstName,
          StringConfig.dashboard.lastName,
          StringConfig.reporting.creationDate,
          StringConfig.reporting.enterpriseUser,
          StringConfig.dashboard.userId,
          StringConfig.reporting.mongoDbUserId,
          StringConfig.dashboard.loginWith,
          StringConfig.dashboard.userActiveTimestamp,
          StringConfig.dashboard.enterpriseCreatedTimestamp,
          StringConfig.dashboard.registrationStatus,
          StringConfig.dashboard.userSubscriptionReceipt,
          StringConfig.dashboard.enterpriseDetail,
          StringConfig.dashboard.onboardingDetails,
          StringConfig.dashboard.enterpriseDetail,
          StringConfig.dashboard.userJMSStatus,
          StringConfig.dashboard.userChallengesStatus,
          StringConfig.dashboard.privacySettingsDetails,
          StringConfig.dashboard.userGrowth,
          StringConfig.dashboard.userProfile,
          StringConfig.dashboard.userMilestoneList,
        ],
      );
      String csvData = const ListToCsvConverter().convert(rows);
      Uint8List bytes = Uint8List.fromList(utf8.encode(csvData));
      await FileSaver.instance.saveFile(
        bytes: bytes,
        ext: "csv",
        mimeType: MimeType.csv,
        name: StringConfig.dashboard.userCollection,
      );
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  searchUser({String? status}) {
    try {
      reset();
      String query = searchController.text.trim().toLowerCase();
      if (query.isEmpty) {
        searchedUsers.value = status == "type" ? searchUserType : users;
      } else {
        if (status == "type") {
          searchedUsers.value = searchUserType.where((e) {
            return (e.mqsEmail?.toLowerCase().contains(query) ?? false) ||
                (e.mqsFirstName?.toLowerCase().contains(query) ?? false) ||
                (e.mqsLastName?.toLowerCase().contains(query) ?? false) ||
                (e.mqsUserLoginWith?.toLowerCase().contains(query) ?? false);
          }).toList();
        } else {
          searchedUsers.value = users.where((e) {
            return (e.mqsEmail?.toLowerCase().contains(query) ?? false) ||
                (e.mqsFirstName?.toLowerCase().contains(query) ?? false) ||
                (e.mqsLastName?.toLowerCase().contains(query) ?? false) ||
                (e.mqsUserLoginWith?.toLowerCase().contains(query) ?? false);
          }).toList();
        }
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
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
      return StringConfig.dashboard.userId;
    } else if (keyName == StringConfig.firebase.isRegister ||
        keyName == StringConfig.firebase.mqsRegistrationStatus) {
      return StringConfig.dashboard.registrationStatus;
    } else if (keyName == StringConfig.dashboard.mqsIsUserActive) {
      return StringConfig.dashboard.userActive;
    } else if (keyName == StringConfig.firebase.mqsCreatedTimestamp) {
      return StringConfig.csv.createdTimestamp;
    }
    else if (keyName == StringConfig.dashboard.userImage ||
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
    } else if (keyName == StringConfig.dashboard.mqsUpdatedTimestamp ||
        keyName == StringConfig.dashboard.mqsUpdateTimestamp) {
      return StringConfig.csv.updatedTimestamp;
    }
    else if (keyName == StringConfig.dashboard.onboardingDataKey ||
        keyName == StringConfig.dashboard.mqsOnboardingDetails) {
      return StringConfig.dashboard.onboardingDetails;
    }
    else if (keyName == StringConfig.dashboard.mqsUserChallengesStatus) {
      return StringConfig.dashboard.userChallengesStatusDetails;
    } else if (keyName == StringConfig.dashboard.mqsUserJMStatus) {
      return StringConfig.dashboard.userJMSStatusDetails;
    } else if (keyName == StringConfig.dashboard.mqsPrivacySettingsDetails) {
      return StringConfig.dashboard.privacySettingsDetails;
    } else if (keyName == StringConfig.dashboard.mqsUserGrowth) {
      return StringConfig.dashboard.userGrowthDetails;
    } else if (keyName == StringConfig.dashboard.mqsUserProfile) {
      return StringConfig.dashboard.userProfileDetails;
    } else if (keyName == StringConfig.dashboard.mqsUserMilestones) {
      return StringConfig.dashboard.userMilestoneDetails;
    }
    else if (keyName == StringConfig.dashboard.mqsUserActiveTimestamp) {
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
      return StringConfig.reporting.isFlag;
    } else if (keyName == StringConfig.firebase.isMainPost) {
      return StringConfig.reporting.isMainPost;
    } else if (keyName == StringConfig.firebase.postContent) {
      return StringConfig.reporting.postContent;
    } else if (keyName == StringConfig.firebase.postTime) {
      return StringConfig.reporting.postTime;
    } else if (keyName == StringConfig.firebase.postTitle) {
      return StringConfig.reporting.postTitle;
    } else if (keyName == StringConfig.firebase.postViews) {
      return StringConfig.reporting.postViews;
    } else if (keyName == StringConfig.firebase.userIsGuide) {
      return StringConfig.reporting.userIsGuide;
    } else if (keyName == StringConfig.firebase.userId) {
      return StringConfig.dashboard.userId;
    } else if (keyName == StringConfig.firebase.userName) {
      return StringConfig.dashboard.name;
    } else if (keyName == StringConfig.firebase.hashtag) {
      return StringConfig.circle.hashTag;
    } else if (keyName == StringConfig.firebase.postReply) {
      return StringConfig.reporting.postReplies;
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
}
