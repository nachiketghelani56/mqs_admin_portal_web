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
import 'package:mqs_admin_portal_web/models/row_input_model.dart';
import 'package:mqs_admin_portal_web/models/user_iam_model.dart';
import 'package:mqs_admin_portal_web/models/user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/services/firebase_auth_service.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/circle/repository/circle_repository.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/enterprise_repository.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/user_repository.dart';
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
  RxString startDate = "".obs, expiryDate = "".obs;
  RxBool mqsCommonLogin = false.obs,
      isSignedUp = false.obs,
      isTeam = false.obs,
      isEnable = false.obs,
      isPocsSignedUp = false.obs;
  RxBool showMqsEmpEmailList = false.obs,
      showMqsTeamList = false.obs,
      showMqsEnterpriseLocationDetails = false.obs,
      showMqsEnterprisePOCs = false.obs,
      isAddEnterprise = false.obs,
      isEditEnterprise = false.obs;
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
      showSortResults = false.obs;
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
  RxList<MqsTeam> mqsTeamList = <MqsTeam>[].obs;
  RxList<MqsEnterprisePOCs> mqsEnterprisePOCs = <MqsEnterprisePOCs>[].obs;
  RxInt viewIndex = (-1).obs;
  EnterpriseModel get enterpriseDetail => searchedEnterprises[viewIndex.value];
  RxInt editMqsEmpEmailIndex = RxInt(-1),
      editMqsEntPOCIndex = RxInt(-1),
      editMqsTeamIndex = RxInt(-1);
  RxList<UserIAMModel> searchedUsers = <UserIAMModel>[].obs,
      users = <UserIAMModel>[].obs,
      searchUserType = <UserIAMModel>[].obs;
  UserIAMModel get userDetail => searchedUsers[viewIndex.value];
  RxInt pageLimit = 10.obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  int get totalEnterprisePage =>
      (searchedEnterprises.length / pageLimit.value).ceil();
  int get totalUserPage => (searchedUsers.length / pageLimit.value).ceil();
  RxList<UserSubscriptionReceiptModel> userSubscriptionReceipts =
      <UserSubscriptionReceiptModel>[].obs;
  UserSubscriptionReceiptModel? get userSubscriptionDetail =>
      userSubscriptionReceipts.firstWhereOrNull(
          (e) => e.isFirebaseUserID == userDetail.mqsFirebaseUserID);
  RxList<TextEditingController> inputControllers =
      <TextEditingController>[].obs;
  RxList<String> dataTypes = [
    StringConfig.dashboard.number,
    StringConfig.dashboard.boolean,
    StringConfig.dashboard.string
  ].obs;
  RxList<RowInputModel> rows = <RowInputModel>[].obs;
  StreamSubscription<List<EnterpriseModel>>? entStream;
  StreamSubscription<List<UserIAMModel>>? userStream;
  StreamSubscription<List<UserSubscriptionReceiptModel>>?
      userSubscriptionReceiptStream;
  RxBool enterpriseLoader = false.obs, userLoader = false.obs;

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
        searchedUsers.value = await UserRepository.i
            .fetchUserFilteredData(field, filters, condition, isAsc.value);
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
    employeeNameController.clear();
  }

  clearMqsTeamFields() {
    teamNameController.clear();
    isEnable.value = false;
    teamEmailController.clear();
    teamMemberLimitController.clear();
  }

  clearMqsEnterprisePocsSubscriptionDetailFields() {
    subscriptionStatusController.clear();
    mqsSubscriptionStartDateController.clear();
    mqsSubscriptionExpiryDateController.clear();
    expiryDate.value = "";
    startDate.value = "";
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
        List<UserIAMModel> userList = await UserRepository.i.getUsers();
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
      userSubscriptionReceipts.value =
          await UserRepository.i.getUserSubscriptionReceipt();
      userSubscriptionReceiptStream =
          UserRepository.i.getUserSubscriptionReceiptStream().listen((data) {
        userSubscriptionReceipts.value = data;
        viewIndex.value = -1;
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
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
        mqsEmployeeName: employeeEmailController.text.trim(),
        mqsEmployeeEmail: employeeEmailController.text.trim(),
        mqsIsSignUp: false,
      ),
    );
    clearMqsEmpEmailFields();
    showMqsEmpEmailList.value = false;
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

    showMqsEmpEmailList.value = true;
  }

  editMqsEmpEmail() {
    mqsEmployeeEmailList[editMqsEmpEmailIndex.value].mqsEmployeeName =
        employeeNameController.text.trim();
    mqsEmployeeEmailList[editMqsEmpEmailIndex.value].mqsEmployeeEmail =
        employeeEmailController.text.trim();

    clearMqsEmpEmailFields();
    editMqsEmpEmailIndex.value = -1;
    showMqsEmpEmailList.value = false;
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

      final docRef = FirebaseStorageService.i.enterprise.doc().id;
      final enterprise = EnterpriseModel(
        mqsEnterprisePOCs: MqsEnterprisePOCs(
          mqsEnterpriseID: isEditEnterprise.value ? enterpriseId.value : docRef,
          mqsEnterpriseName: pocNameController.text.trim(),
          mqsEnterpriseEmail: pocEmailController.text.trim(),
          mqsEnterprisePhoneNumber: pocPhoneNumberController.text,
          mqsEnterpriseType: pocTypeController.text,
          mqsEnterpriseWebsite: pocWebsiteController.text,
          mqsEnterpriseAddress: pocAddressController.text.trim(),
          mqsEnterprisePincode: pocPinCodeController.text.trim(),
          mqsIsSignUp: false,
        ),
        mqsEnterpriseCode: mqsEnterpriseCodeController.text,
        mqsIsTeam: mqsTeamList.isNotEmpty ? true : false,
        mqsTeamList: mqsTeamList,
        mqsEmployeeList: mqsEmployeeEmailList,
        mqsEnterprisePOCsSubscriptionDetails:
            MqsEnterprisePOCsSubscriptionDetails(
          mqsSubscriptionStatus: subscriptionStatusController.text.trim(),
          mqsSubscriptionActivePlan:
              subscriptionActivePlanController.text.trim(),
          mqsSubscriptionStartDate: startDate.value.trim(),
          mqsSubscriptionExpiryDate: expiryDate.value.trim(),
        ),
        mqsCreatedTimestamp: isEditEnterprise.value
            ? createdTimestamp.value
            : DateTime.now().toIso8601String(),
        mqsUpdateTimestamp: DateTime.now().toIso8601String(),
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

    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  setEnterpriseForm({required int index}) {
    enterpriseId.value = enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseID;
    mqsEnterpriseCodeController.text = enterpriseDetail.mqsEnterpriseCode;
    pocNameController.text =
        enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseName;

    pocEmailController.text =
        enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseEmail;
    pocAddressController.text =
        enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseAddress;
    pocWebsiteController.text =
        enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseWebsite;
    pocTypeController.text =
        enterpriseDetail.mqsEnterprisePOCs.mqsEnterpriseType;
    pocPhoneNumberController.text =
        enterpriseDetail.mqsEnterprisePOCs.mqsEnterprisePhoneNumber;
    pocPinCodeController.text =
        enterpriseDetail.mqsEnterprisePOCs.mqsEnterprisePincode;
    subscriptionActivePlanController.text = enterpriseDetail
        .mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionActivePlan;
    subscriptionStatusController.text = enterpriseDetail
        .mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionStatus;
    mqsSubscriptionStartDateController.text = dateConvert(enterpriseDetail
        .mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionStartDate);
    mqsSubscriptionExpiryDateController.text = dateConvert(enterpriseDetail
        .mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionExpiryDate);
    startDate.value = enterpriseDetail.mqsEnterprisePOCsSubscriptionDetails
            .mqsSubscriptionStartDate.isEmpty
        ? ""
        : DateTime.parse(enterpriseDetail
                .mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionStartDate)
            .toIso8601String();
    expiryDate.value = enterpriseDetail.mqsEnterprisePOCsSubscriptionDetails
            .mqsSubscriptionExpiryDate.isEmpty
        ? ""
        : DateTime.parse(enterpriseDetail
                .mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionExpiryDate)
            .toIso8601String();
    mqsEmployeeEmailList.value = enterpriseDetail.mqsEmployeeList;
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
            mqsEnterprisePOCs: MqsEnterprisePOCs(
              mqsEnterpriseID: docRef,
              mqsEnterpriseName: rowMap['Enterprise Name'] ?? "",
              mqsEnterpriseEmail: rowMap['Enterprise Email'] ?? "",
              mqsEnterprisePhoneNumber:
                  rowMap['Enterprise Phone Number'].toString(),
              mqsEnterpriseType: rowMap['Enterprise Type'] ?? "",
              mqsEnterpriseWebsite: rowMap['Enterprise Website'] ?? "",
              mqsEnterpriseAddress: rowMap['Enterprise Address'] ?? "",
              mqsEnterprisePincode: rowMap['Enterprise Pincode'].toString(),
              mqsIsSignUp:
                  rowMap['IsSignUp'].toString().toLowerCase() == 'true',
            ),
            mqsEnterpriseCode: rowMap['Enterprise Code'].toString(),
            mqsIsTeam: rowMap['Is Team']?.toString().toLowerCase() == 'true',
            mqsTeamList: mqsTeamList,
            mqsEmployeeList: mqsEmployeeList,
            mqsEnterprisePOCsSubscriptionDetails:
                MqsEnterprisePOCsSubscriptionDetails(
              mqsSubscriptionStatus: rowMap['Subscription Status'] ?? "",
              mqsSubscriptionActivePlan:
                  rowMap['Subscription Active Plan'] ?? "",
              mqsSubscriptionStartDate:
                  rowMap['Subscription Start Date'].toString().isEmpty
                      ? ""
                      : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                          .parse(rowMap['Subscription Start Date'])
                          .toIso8601String(),
              mqsSubscriptionExpiryDate:
                  rowMap['Subscription Expiry Date'].toString().isEmpty
                      ? ""
                      : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                          .parse(rowMap['Subscription Expiry Date'])
                          .toIso8601String(),
            ),
            mqsCreatedTimestamp: rowMap['Created Timestamp'].toString().isEmpty
                ? ""
                : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .parse(rowMap['Created Timestamp'])
                    .toIso8601String(),
            mqsUpdateTimestamp: rowMap['Updated Timestamp'].toString().isEmpty
                ? ""
                : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .parse(rowMap['Updated Timestamp'])
                    .toIso8601String(),
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
          StringConfig.dashboard.mqsEnterPriseName,
          StringConfig.dashboard.enterpriseEmail,
          StringConfig.csv.enterprisePhoneNumber,
          StringConfig.csv.enterpriseType,
          StringConfig.csv.enterpriseWebsite,
          StringConfig.csv.enterpriseAddress,
          StringConfig.csv.enterprisePinCode,
          StringConfig.csv.isSignUp,
          StringConfig.dashboard.isTeam,
          StringConfig.csv.teams,
          StringConfig.reporting.employees,
          StringConfig.dashboard.subscriptionStatus,
          StringConfig.dashboard.subscriptionActivePlan,
          StringConfig.dashboard.mqsSubscriptionStartDate,
          StringConfig.dashboard.mqsSubscriptionExpiryDate,
          StringConfig.csv.createdTimestamp,
          StringConfig.csv.updatedTimestamp,
        ],
        // Data Rows
        // enterprises
        ...searchedEnterprises.map((model) {
          return [
            model.mqsEnterpriseCode,
            model.mqsEnterprisePOCs.mqsEnterpriseName,
            model.mqsEnterprisePOCs.mqsEnterpriseEmail,
            model.mqsEnterprisePOCs.mqsEnterprisePhoneNumber,
            model.mqsEnterprisePOCs.mqsEnterpriseType,
            model.mqsEnterprisePOCs.mqsEnterpriseWebsite,
            model.mqsEnterprisePOCs.mqsEnterpriseAddress,
            model.mqsEnterprisePOCs.mqsEnterprisePincode,
            model.mqsEnterprisePOCs.mqsIsSignUp.toString(),
            model.mqsIsTeam.toString(),
            jsonEncode(model.mqsTeamList.map((p) => p.toJson()).toList()),
            jsonEncode(model.mqsEmployeeList.map((p) => p.toJson()).toList()),
            model.mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionStatus,
            model
                .mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionActivePlan,
            dateConvert(model
                .mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionStartDate),
            dateConvert(model.mqsEnterprisePOCsSubscriptionDetails
                .mqsSubscriptionExpiryDate),
            dateConvert(model.mqsCreatedTimestamp),
            dateConvert(model.mqsUpdateTimestamp),
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
              e.mqsEnterprisePOCs.mqsEnterpriseName
                  .toLowerCase()
                  .contains(query) ||
              e.mqsEnterprisePOCs.mqsEnterpriseEmail
                  .toLowerCase()
                  .contains(query) ||
              e.mqsEnterprisePOCs.mqsEnterprisePhoneNumber
                  .toLowerCase()
                  .contains(query) ||
              e.mqsEnterprisePOCs.mqsEnterpriseType
                  .toLowerCase()
                  .contains(query) ||
              e.mqsEnterprisePOCs.mqsEnterpriseWebsite
                  .toLowerCase()
                  .contains(query) ||
              e.mqsEnterprisePOCs.mqsEnterpriseAddress
                  .toLowerCase()
                  .contains(query) ||
              e.mqsEnterprisePOCs.mqsEnterprisePincode
                  .toLowerCase()
                  .contains(query) ||
              e.mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionActivePlan
                  .toLowerCase()
                  .contains(query) ||
              e.mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionStatus
                  .toLowerCase()
                  .contains(query);
        }).toList();
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  bool checkEnterprisePOCsSubscriptionDetail() {
    if (enterpriseDetail.mqsEnterprisePOCsSubscriptionDetails
            .mqsSubscriptionStartDate.isEmpty &&
        enterpriseDetail.mqsEnterprisePOCsSubscriptionDetails
            .mqsSubscriptionExpiryDate.isEmpty &&
        enterpriseDetail.mqsEnterprisePOCsSubscriptionDetails
            .mqsSubscriptionActivePlan.isEmpty &&
        enterpriseDetail.mqsEnterprisePOCsSubscriptionDetails
            .mqsSubscriptionStatus.isEmpty) {
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
      firstDate: startDate.value.isNotEmpty
          ? DateTime.parse(
              startDate.value,
            )
          : DateTime.now(),
      lastDate: DateTime(3000),
      initialDate: startDate.value.isNotEmpty
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

  exportUserIAM() async {
    try {
      List<UserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();

      String currentDate =
          DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(DateTime(0));
      List<List<String>> rows = [];

      rows = [
        ...searchedUsers.map((model) {
          return [
            model.mqsEmail,
            model.mqsFirstName,
            model.mqsLastName,
            model.mqsCreatedTimestamp.isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .format(DateTime.parse(model.mqsCreatedTimestamp))
                : "",
            "${model.mqsEnterpriseUserFlag}",
            model.mqsFirebaseUserID,
            model.isMongoDBUserId,
            model.loginWith,
            model.about,
            "${model.aboutValue}",
            model.country,
            "${model.countryValue}",
            model.pronouns,
            "${model.pronounsValue}",
            "${model.mqsSkipOnboarding}",
            model.mqsUserActiveTimestamp.isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .format(DateTime.parse(model.mqsUserActiveTimestamp))
                : "",
            model.mqsRegistrationStatus,
            jsonEncode(model.mqsEnterpriseDetails.toJson()),
            json.encode(receipt
                .where((e) => e.isFirebaseUserID == model.mqsFirebaseUserID)
                .toList()),
            model.mqsUserActiveTimestamp,
            jsonEncode(model.onboardingModel.checkInValue
                .map((e) => e.toJson())
                .toList()),
            jsonEncode(model.onboardingModel.demoGraphicValue
                .map((e) => e.toJson())
                .toList()),
            jsonEncode(model.onboardingModel.scenesValue
                .map((e) => e.toJson())
                .toList()),
            jsonEncode(model.onboardingModel.wOLValue.toJson()),
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
          StringConfig.reporting.firebaseUserId,
          StringConfig.reporting.mongoDbUserId,
          StringConfig.dashboard.loginWith,
          StringConfig.dashboard.about,
          StringConfig.dashboard.aboutValue,
          StringConfig.dashboard.country,
          StringConfig.dashboard.countryValue,
          StringConfig.dashboard.pronouns,
          StringConfig.dashboard.pronounsValue,
          StringConfig.dashboard.skipOnboarding,
          StringConfig.dashboard.userActiveTimestamp,
          StringConfig.dashboard.registrationStatus,
          StringConfig.dashboard.enterpriseDetail,
          StringConfig.dashboard.userSubscriptionReceipt,
          StringConfig.reporting.obCheckIn,
          StringConfig.reporting.obDemographic,
          StringConfig.reporting.obScenes,
          StringConfig.reporting.obWOL,
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
            return e.mqsEmail.toLowerCase().contains(query) ||
                e.mqsFirstName.toLowerCase().contains(query) ||
                e.mqsLastName.toLowerCase().contains(query) ||
                e.loginWith.toLowerCase().contains(query);
          }).toList();
        } else {
          searchedUsers.value = users.where((e) {
            return e.mqsEmail.toLowerCase().contains(query) ||
                e.mqsFirstName.toLowerCase().contains(query) ||
                e.mqsLastName.toLowerCase().contains(query) ||
                e.loginWith.toLowerCase().contains(query);
          }).toList();
        }
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  String enterpriseKeyName({int? index}) {
    String keyName = filterFields[index ?? selectedFilterFieldIndex.value];
    if (keyName == StringConfig.dashboard.mqsEnterprisePOCsKey) {
      return StringConfig.dashboard.mqsEnterprisePOCs;
    } else if (keyName == StringConfig.firebase.mqsEnterpriseCode) {
      return StringConfig.dashboard.mqsEnterPriseCode;
    } else if (keyName == StringConfig.dashboard.mqsIsTeam) {
      return StringConfig.dashboard.team;
    } else if (keyName == StringConfig.dashboard.mqsTeamListKey) {
      return StringConfig.dashboard.mqsTeamList;
    } else if (keyName == StringConfig.dashboard.mqsEmployeeList) {
      return StringConfig.dashboard.mqsEmployeeEmailList;
    } else if (keyName ==
        StringConfig.dashboard.mqsEnterprisePOCsSubscriptionDetails) {
      return StringConfig.dashboard.mqsEnterprisePOCsSubscriptionDetail;
    } else if (keyName == StringConfig.firebase.mqsCreatedTimestamp) {
      return StringConfig.csv.createdTimestamp;
    } else if (keyName == StringConfig.dashboard.mqsUpdateTimestamp) {
      return StringConfig.csv.updatedTimestamp;
    }
    return "";
  }

  String userKeyName({int? index}) {
    String keyName = filterFields[index ?? selectedFilterFieldIndex.value];
    if (keyName == StringConfig.dashboard.email || keyName == StringConfig.firebase.mqsEmail) {
      return StringConfig.dashboard.email;
    } else if (keyName == StringConfig.firebase.firstName || keyName == StringConfig.firebase.mqsFirstName) {
      return StringConfig.dashboard.firstName;
    } else if (keyName == StringConfig.firebase.lastName || keyName == StringConfig.firebase.mqsLastName) {
      return StringConfig.dashboard.lastName;
    } else if (keyName == StringConfig.firebase.isEnterPriseUser || keyName == StringConfig.firebase.mqsEnterpriseUserFlag) {
      return StringConfig.reporting.enterpriseUser;
    } else if (keyName == StringConfig.firebase.isFirebaseUserID || keyName == StringConfig.firebase.mqsFirebaseUserID) {
      return StringConfig.reporting.firebaseUserId;
    } else if (keyName == StringConfig.firebase.isRegister || keyName == StringConfig.firebase.mqsRegistrationStatus) {
      return StringConfig.dashboard.register;
    } else if (keyName == StringConfig.dashboard.mqsIsUserActive) {
      return StringConfig.dashboard.userActive;
    } else if (keyName == StringConfig.firebase.mqsCreatedTimestamp) {
      return StringConfig.csv.createdTimestamp;
    } else if (keyName == StringConfig.dashboard.about) {
      return StringConfig.dashboard.about;
    } else if (keyName == StringConfig.dashboard.aboutValue) {
      return StringConfig.dashboard.aboutValueText;
    } else if (keyName == StringConfig.dashboard.country) {
      return StringConfig.dashboard.country;
    } else if (keyName == StringConfig.dashboard.countryValue) {
      return StringConfig.dashboard.countryValueText;
    } else if (keyName == StringConfig.dashboard.pronouns) {
      return StringConfig.dashboard.pronouns;
    } else if (keyName == StringConfig.dashboard.pronounsValue) {
      return StringConfig.dashboard.pronounsValueText;
    } else if (keyName == StringConfig.dashboard.userImage) {
      return StringConfig.dashboard.userImageText;
    }else if (keyName == StringConfig.dashboard.isMongoDBUserIdText) {
      return StringConfig.dashboard.mongoDBUserId;
    } else if (keyName == StringConfig.dashboard.loginWithKey) {
      return StringConfig.dashboard.loginWithText;
    } else if (keyName == StringConfig.dashboard.mqsExpiryDate) {
      return StringConfig.reporting.expiryDate;
    } else if (keyName == StringConfig.dashboard.mqsSubscriptionActivePlan) {
      return StringConfig.dashboard.subscriptionActivePlan;
    } else if (keyName == StringConfig.dashboard.mqsSubscriptionPlatform) {
      return StringConfig.reporting.subscriptionPlatform;
    } else if (keyName == StringConfig.dashboard.mqsUpdateTimestamp) {
      return StringConfig.csv.updatedTimestamp;
    } else if (keyName == StringConfig.dashboard.mqsUserSubscriptionStatus) {
      return StringConfig.dashboard.userSubscriptionStatus;
    } else if (keyName == StringConfig.dashboard.onboardingDataKey) {
      return StringConfig.dashboard.onboardingData;
    } else if (keyName == StringConfig.dashboard.mqsSkipOnboarding) {
      return StringConfig.dashboard.skipOnboarding;
    } else if (keyName == StringConfig.dashboard.mqsUserActiveTimestamp) {
      return StringConfig.dashboard.userActiveTimestamp;
    } else if (keyName == StringConfig.dashboard.mqsEnterpriseDetails) {
      return StringConfig.dashboard.enterpriseDetail;
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
