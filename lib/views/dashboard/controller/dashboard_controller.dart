import 'dart:convert';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/enterprise_model.dart';
import 'package:mqs_admin_portal_web/models/menu_option_model.dart';
import 'package:mqs_admin_portal_web/models/row_input_model.dart';
import 'package:mqs_admin_portal_web/models/user_iam_model.dart';
import 'package:mqs_admin_portal_web/models/user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';
import 'package:uuid/uuid.dart';

class DashboardController extends GetxController {
  RxList<String> tabs = [
    StringConfig.dashboard.enterprise,
    StringConfig.dashboard.userIAM,
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
    StringConfig.dashboard.equalToAny,
    StringConfig.dashboard.notEqualToAny,
    StringConfig.dashboard.arrayContaining,
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
  RxInt selectedFilterFieldIndex = 0.obs;
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
  final GlobalKey<FormState> enterpriseFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> entEmpEmailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> entTeamFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> entPOCFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> entPOCSubscriptionFormKey = GlobalKey<FormState>();
  EnterpriseModel get enterpriseDetail => searchedEnterprises[viewIndex.value];
  RxInt editMqsEmpEmailIndex = RxInt(-1),
      editMqsEntPOCIndex = RxInt(-1),
      editMqsTeamIndex = RxInt(-1);
  RxList<UserIAMModel> searchedUsers = <UserIAMModel>[].obs,
      users = <UserIAMModel>[].obs;
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
          (e) => e.isFirebaseUserID == userDetail.isFirebaseUserId);

  RxList<TextEditingController> inputControllers =
      <TextEditingController>[].obs;

  RxList<String> dataTypes = [
    StringConfig.dashboard.number,
    StringConfig.dashboard.boolean,
    StringConfig.dashboard.string
  ].obs;
  RxList<RowInputModel> rows = <RowInputModel>[].obs;

  @override
  onInit() {
    getEnterprises();
    getUsers();
    getUserSubscriptionRecipts();
    super.onInit();
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
    selectedFilterFieldIndex.value = 0;
    selectedConditionIndex.value = -1;
    isAsc.value = true;
    showFilterByField.value = false;
    showAddCondition.value = false;
    showSortResults.value = false;
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
      // try {
      //   List<EnterpriseModel> ent =
      //   await FirebaseStorageService.i.getEnterprises();
      //   searchedEnterprises.value = ent;
      //   enterprises.value = ent;
      //   FirebaseStorageService.i.listenToEnterpriseChange((data) {
      //     List<EnterpriseModel> ent = data.docs
      //         .map((e) => EnterpriseModel.fromJson(e.data() as Map))
      //         .toList();
      //     searchedEnterprises.value = ent;
      //     enterprises.value = ent;
      //   });
      // }

      // List<EnterpriseModel> ent =
      //     await FirebaseStorageService.i.getEnterprises();
      // searchedEnterprises.value = ent;
      // enterprises.value = ent;
      // FirebaseStorageService.i.listenToEnterpriseChange((data) {
      //   List<EnterpriseModel> ent = data.docs
      //       .map((e) => EnterpriseModel.fromJson(e.data() as  Map<String, dynamic>))
      //       .toList();
      //   print("ent-->${ent}");
      //   searchedEnterprises.value = ent;
      //
      //   enterprises.value = ent;
      //   print("enterprises.value-->${enterprises.value}");
      // });
      List<EnterpriseModel> enterpriseList =
          await FirebaseStorageService.i.getEnterprises();
      searchedEnterprises.value = enterpriseList;
      enterprises.value = enterpriseList;
      filterFields.value = enterprises
          .expand((e) => e.toJson().keys) // Convert model to Map
          .toSet() // Ensure uniqueness
          .toList();
      FirebaseStorageService.i.getEnterpriseStream().listen((enterpriseList) {
        searchedEnterprises.value = enterpriseList; // Update searched list
        enterprises.value = enterpriseList; // Update full list
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getUsers() async {
    try {
      List<UserIAMModel> userList = await FirebaseStorageService.i.getUsers();
      searchedUsers.value = userList;
      users.value = userList;
      FirebaseStorageService.i.getUserStream().listen((data) {
        searchedUsers.value = data;
        users.value = data;
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getUserSubscriptionRecipts() async {
    try {
      userSubscriptionReceipts.value =
          await FirebaseStorageService.i.getUserSubscriptionReceipt();
      FirebaseStorageService.i
          .getUserSubscriptionReceiptStream()
          .listen((data) {
        userSubscriptionReceipts.value = data;
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

  addMqsEntPOC() {
    // mqsEnterprisePOCs.add(
    //   MqsEnterprisePOC(
    //     address: pocAddressController.text.trim(),
    //     email: pocEmailController.text.trim(),
    //     name: pocNameController.text.trim(),
    //     phoneNumber: pocPhoneNumberController.text.trim(),
    //   ),
    // );
    // clearMqsEntPOCFields();
    // showMqsEnterprisePOCs.value = false;
  }

  setMqsEntPOCForm({required int index}) {
    // editMqsEntPOCIndex.value = index;
    // pocEmailController.text = mqsEnterprisePOCs[index].email;
    // pocAddressController.text = mqsEnterprisePOCs[index].address;
    // pocNameController.text = mqsEnterprisePOCs[index].name;
    // pocPhoneNumberController.text = mqsEnterprisePOCs[index].phoneNumber;
    // showMqsEnterprisePOCs.value = true;
  }

  editMqsEntPOC() {
    // mqsEnterprisePOCs[editMqsEntPOCIndex.value].email = pocEmailController.text;
    //
    // mqsEnterprisePOCs[editMqsEntPOCIndex.value].address =
    //     pocAddressController.text;
    // mqsEnterprisePOCs[editMqsEntPOCIndex.value].name = pocNameController.text;
    //
    // mqsEnterprisePOCs[editMqsEntPOCIndex.value].phoneNumber =
    //     pocPhoneNumberController.text;
    // clearMqsEntPOCFields();
    // editMqsEntPOCIndex.value = -1;
    // showMqsEnterprisePOCs.value = false;
  }

  deleteMqsEntPOC({required int index}) {
    mqsEnterprisePOCs.removeAt(index);
  }

  addEnterprise() async {
    try {
      if (enterpriseFormKey.currentState?.validate() ?? false) {
        final docRef = FirebaseStorageService.i.enterprise.doc().id;
        final enterprise = EnterpriseModel(
          mqsEnterprisePOCs: MqsEnterprisePOCs(
            mqsEnterpriseID:
                isEditEnterprise.value ? enterpriseId.value : docRef,
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
          await FirebaseStorageService.i.editEnterprises(
              enterprise: enterprise, docId: enterpriseId.value);
        } else {
          await FirebaseStorageService.i
              .addEnterprises(enterprise: enterprise, customId: docRef);
        }
        hideLoader();
        clearAllFields();
        isAddEnterprise.value = false;
        isEditEnterprise.value = false;
        if (Get.currentRoute == AppRoutes.addEnterprise) {
          Get.back();
        }
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
      await FirebaseStorageService.i.deleteEnterprises(docId: docId);
      hideLoader();
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  /// working
  // importEnterprise() async {
  //   try {
  //     final result = await FilePicker.platform.pickFiles(
  //         allowMultiple: false,
  //         type: FileType.custom,
  //         allowedExtensions: ['csv']);
  //     if (result != null) {
  //       String csvData = utf8.decode(result.files.single.bytes ?? []);
  //       List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);
  //
  //       for (int i = 1; i < rows.length; i++) {
  //         List<dynamic> row = rows[i];
  //         List<MqsEmployee> mqsEmployeeList = [];
  //         if (row[10] != null && row[10].toString().isNotEmpty) {
  //           try {
  //             List<dynamic> employees = jsonDecode(row[10]);
  //             mqsEmployeeList = employees.map((employee) {
  //               return MqsEmployee(
  //                 mqsEmployeeID: employee['mqsEmployeeID'] ?? "",
  //                 mqsEmployeeName: employee['mqsEmployeeName'] ?? "",
  //                 mqsEmployeeEmail: employee['mqsEmployeeEmail'] ?? "",
  //                 mqsIsSignUp:
  //                 employee['mqsIsSignUp']?.toString().toLowerCase() ==
  //                     'true',
  //               );
  //             }).toList();
  //           } catch (e) {
  //             errorDialogWidget(msg: e.toString());
  //           }
  //         }
  //         List<MqsTeam> mqsTeamList = [];
  //         if (row[9] != null && row[9].toString().isNotEmpty) {
  //           try {
  //             List<dynamic> teams = jsonDecode(row[9]);
  //             mqsTeamList = teams.map((team) {
  //               return MqsTeam(
  //                 mqsTeamID: team['mqsTeamID'] ?? "",
  //                 mqsTeamName: team['mqsTeamName'] ?? "",
  //                 mqsTeamEmail: team['mqsTeamEmail'] ?? "",
  //                 mqsTeamMembersLimit: team['mqsTeamMembersLimit'] ?? 0,
  //                 mqsIsEnable:
  //                 team['mqsIsEnable']?.toString().toLowerCase() == 'true',
  //               );
  //             }).toList();
  //           } catch (e) {
  //             errorDialogWidget(msg: e.toString());
  //           }
  //         }
  //         final docRef = FirebaseStorageService.i.enterprise.doc().id;
  //         EnterpriseModel enterprise = EnterpriseModel(
  //           mqsEnterprisePOCs: MqsEnterprisePOCs(
  //             mqsEnterpriseID: docRef,
  //             mqsEnterpriseName: row[1],
  //             mqsEnterpriseEmail: row[2],
  //             mqsEnterprisePhoneNumber: row[3].toString(),
  //             mqsEnterpriseType: row[4],
  //             mqsEnterpriseWebsite: row[5],
  //             mqsEnterpriseAddress: row[6],
  //             mqsEnterprisePincode: row[7].toString(),
  //             mqsIsSignUp: row[8].toString().toLowerCase() == 'true',
  //           ),
  //           mqsEnterpriseCode: row[0].toString(),
  //           mqsIsTeam: row[10].toString().toLowerCase() == 'true',
  //           mqsTeamList: mqsTeamList,
  //           mqsEmployeeList: mqsEmployeeList,
  //           mqsEnterprisePOCsSubscriptionDetails:
  //           MqsEnterprisePOCsSubscriptionDetails(
  //             mqsSubscriptionStatus: row[11],
  //             mqsSubscriptionActivePlan: row[12],
  //             mqsSubscriptionStartDate: row[13].toString().isEmpty
  //                 ? ""
  //                 : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
  //                 .parse(row[13])
  //                 .toIso8601String(),
  //             mqsSubscriptionExpiryDate: row[14].toString().isEmpty
  //                 ? ""
  //                 : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
  //                 .parse(row[14])
  //                 .toIso8601String(),
  //           ),
  //           mqsCreatedTimestamp: row[15].toString().isEmpty
  //               ? ""
  //               : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
  //               .parse(row[15])
  //               .toIso8601String(),
  //           mqsUpdateTimestamp: row[16].toString().isEmpty
  //               ? ""
  //               : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
  //               .parse(row[16])
  //               .toIso8601String(),
  //         );
  //
  //         await FirebaseStorageService.i
  //             .addEnterprises(enterprise: enterprise, customId: docRef);
  //       }
  //     }
  //   } catch (e) {
  //     hideLoader();
  //     errorDialogWidget(msg: e.toString());
  //   } finally {}
  // }
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

          await FirebaseStorageService.i
              .addEnterprises(enterprise: enterprise, customId: docRef);
        }
      }
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    }
  }

  ///Working
//   exportEnterprise(List<EnterpriseModel> enterpriseModels) async {
//     try {
//       List<List<String>> rows = [
//         [
//           StringConfig.dashboard.mqsEnterPriseCode,
//           StringConfig.dashboard.mqsEnterPriseName,
//           StringConfig.dashboard.enterpriseEmail,
//           StringConfig.csv.enterprisePhoneNumber,
//           StringConfig.csv.enterpriseType,
//           StringConfig.csv.enterpriseWebsite,
//           StringConfig.csv.enterpriseAddress,
//           StringConfig.csv.enterprisePinCode,
//           StringConfig.csv.isSignUp,
//           StringConfig.dashboard.isTeam,
//           StringConfig.csv.teams,
//           StringConfig.reporting.employees,
//           StringConfig.dashboard.subscriptionStatus,
//           StringConfig.dashboard.subscriptionActivePlan,
//           StringConfig.dashboard.mqsSubscriptionStartDate,
//           StringConfig.dashboard.mqsSubscriptionExpiryDate,
//           StringConfig.csv.createdTimestamp,
//           StringConfig.csv.updatedTimestamp,
//         ],
//         // Data Rows
//         ...enterprises.map((model) {
//           return [
//             model.mqsEnterpriseCode,
//             model.mqsEnterprisePOCs.mqsEnterpriseName,
//             model.mqsEnterprisePOCs.mqsEnterpriseEmail,
//             model.mqsEnterprisePOCs.mqsEnterprisePhoneNumber,
//             model.mqsEnterprisePOCs.mqsEnterpriseType,
//             model.mqsEnterprisePOCs.mqsEnterpriseWebsite,
//             model.mqsEnterprisePOCs.mqsEnterpriseAddress,
//             model.mqsEnterprisePOCs.mqsEnterprisePincode,
//             model.mqsEnterprisePOCs.mqsIsSignUp.toString(),
//             model.mqsIsTeam.toString(),
//             jsonEncode(model.mqsTeamList.map((p) => p.toJson()).toList()),
//             jsonEncode(model.mqsEmployeeList.map((p) => p.toJson()).toList()),
//             model.mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionStatus,
//             model
//                 .mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionActivePlan,
//             dateConvert(model
//                 .mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionStartDate),
//             dateConvert(model.mqsEnterprisePOCsSubscriptionDetails
//                 .mqsSubscriptionExpiryDate),
//             dateConvert(model.mqsCreatedTimestamp),
//             dateConvert(model.mqsUpdateTimestamp),
//           ];
//         }),
//       ];
//       String csvData = const ListToCsvConverter().convert(rows);
//       Uint8List bytes = Uint8List.fromList(utf8.encode(csvData));
//       await FileSaver.instance.saveFile(
//         bytes: bytes,
//         ext: "csv",
//         mimeType: MimeType.csv,
//         name: StringConfig.dashboard.enterpriseCollection,
//       );
//     } catch (e) {
//       errorDialogWidget(msg: e.toString());
//     } finally {}
//   }

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
        ...enterprises.map((model) {
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
    viewIndex.value = -1;
    selectedTabIndex.value = index;
    offset.value = 0;
    currentPage.value = 1;
    searchedEnterprises.value = enterprises;
    searchedUsers.value = users;
    searchController.clear();
  }

  getMaxOffset() {
    int rem = (selectedTabIndex.value == 0
            ? searchedEnterprises.length
            : searchedUsers.length) %
        pageLimit.value;
    if (rem != 0 &&
        currentPage.value ==
            (selectedTabIndex.value == 0
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
      String currentDate = DateFormat('dd/MM/yyyy').format(DateTime(0));
      List<List<String>> rows = [
        ...users.map((model) {
          return [
            model.email,
            model.firstName,
            model.lastName,
            model.mqsCreatedTimestamp.isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .format(DateTime.parse(model.mqsCreatedTimestamp))
                : "",
            "${model.isEnterpriseUser}",
            model.isFirebaseUserId,
            model.isMongoDBUserId,
            model.mqsSubscriptionActivePlan,
            model.mqsUserSubscriptionStatus,
            model.mqsSubscriptionPlatform,
            model.mqsExpiryDate.isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .format(DateTime.parse(model.mqsExpiryDate))
                : "",
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
      rows.sort((a, b) => DateFormat('dd/MM/yyyy')
          .parse(b[3].isNotEmpty ? b[3] : currentDate)
          .compareTo(DateFormat('dd/MM/yyyy')
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
          StringConfig.reporting.subscriptionActivePlan,
          StringConfig.reporting.subscriptionStatus,
          StringConfig.reporting.subscriptionPlatform,
          StringConfig.reporting.subscriptionExpiryDate,
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

  searchUser() {
    try {
      String query = searchController.text.trim().toLowerCase();
      if (query.isEmpty) {
        searchedUsers.value = users;
      } else {
        searchedUsers.value = users.where((e) {
          return e.email.toLowerCase().contains(query) ||
              e.firstName.toLowerCase().contains(query) ||
              e.lastName.toLowerCase().contains(query) ||
              e.loginWith.toLowerCase().contains(query);
        }).toList();
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }
}
