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
import 'package:mqs_admin_portal_web/models/enterprise_model.dart';
import 'package:mqs_admin_portal_web/models/menu_option_model.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/enterprise_repository.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';
import 'package:uuid/uuid.dart';

class EnterpriseDataController extends GetxController {
  RxBool showMqsEnterpriseDetail = false.obs;
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

  RxBool enterpriseLoader = false.obs;
  RxInt editMqsEmpEmailIndex = RxInt(-1),
      editMqsEntPOCIndex = RxInt(-1),
      editMqsTeamIndex = RxInt(-1);
  StreamSubscription<List>? enterpriseStream;
  RxInt viewIndex = (-1).obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  EnterpriseModel get enterpriseDetail => searchedEnterprises[viewIndex.value];
  RxList<EnterpriseModel> searchedEnterprises = <EnterpriseModel>[].obs,
      enterprises = <EnterpriseModel>[].obs;
  RxInt pageLimit = 10.obs;
  int get totalEnterprisePage =>
      (searchedEnterprises.length / pageLimit.value).ceil();
  StreamSubscription<List<EnterpriseModel>>? entStream;
  final TextEditingController searchController = TextEditingController();
  RxList<MqsEmployee> mqsEmployeeEmailList = <MqsEmployee>[].obs;
  RxList<MqsEnterprisePOCs> mqsEnterprisePOCsList = <MqsEnterprisePOCs>[].obs;
  RxString createdTimestamp = "".obs, updateTimestamp = "".obs;
  RxList<MqsTeam> mqsTeamList = <MqsTeam>[].obs;
  RxBool showMqsEmpEmailList = false.obs,
      showMqsEnterprisePocsList = false.obs,
      showMqsTeamList = false.obs,
      showMqsEnterpriseLocationDetails = false.obs,
      showMqsEnterprisePOCs = false.obs,
      isAddEnterprise = false.obs,
      isEditEnterprise = false.obs;
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
  RxBool mqsCommonLogin = false.obs,
      isSignedUp = false.obs,
      isCommonLogin = false.obs,
      isTeam = false.obs,
      isEnable = false.obs,
      isPocsSignedUp = false.obs;
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
  RxBool enterprisePOCsError = false.obs, teamError = false.obs;
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
  RxString enterpriseId = "".obs;
  RxString startDate = "".obs, expiryDate = "".obs, renewalDate = "".obs;
  RxBool isHovering = false.obs, isSubscriptionHovering = false.obs;

  @override
  onInit() {
    getEnterprises();
    super.onInit();
  }

  @override
  void onClose() async {
    await entStream?.cancel();
    super.onClose();
  }

  addEnterprise() async {
    try {
      final MqsDashboardController mqsDashboardController =
          Get.put(MqsDashboardController());
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


        mqsDashboardController.enterpriseStatus.value = "";

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

  getMaxOffset() {
    int rem = searchedEnterprises.length % pageLimit.value;
    if (rem != 0 && currentPage.value == totalEnterprisePage) {
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
      if (currentPage.value < totalEnterprisePage) {
        offset.value = offset.value + pageLimit.value;
        currentPage.value++;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  reset() {
    viewIndex.value = -1;
    currentPage.value = 1;
    offset.value = 0;
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

  deleteMqsEnterprisePOCs({required int index}) {
    mqsEnterprisePOCsList.removeAt(index);
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

  String dateConvert(String date) {
    if (date.isNotEmpty) {
      final formattedDateTime = DateFormat(StringConfig.dashboard.dateYYYYMMDD)
          .format(DateTime.parse(date));

      return formattedDateTime;
    } else {
      return "";
    }
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

  deleteMqsTeam({required int index}) {
    mqsTeamList.removeAt(index);
  }

  setMqsTeamForm({required int index}) {
    editMqsTeamIndex.value = index;
    teamNameController.text = mqsTeamList[index].mqsTeamName;
    teamEmailController.text = mqsTeamList[index].mqsTeamEmail;
    teamMemberLimitController.text =
        "${mqsTeamList[index].mqsTeamMembersLimit}";
    showMqsTeamList.value = true;
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

  deleteMqsEmpEmial({required int index}) {
    mqsEmployeeEmailList.removeAt(index);
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

  setMqsEmpEmailForm({required int index}) {
    editMqsEmpEmailIndex.value = index;
    employeeEmailController.text = mqsEmployeeEmailList[index].mqsEmployeeEmail;

    employeeNameController.text = mqsEmployeeEmailList[index].mqsEmployeeName;
    mqsCommonLogin.value = mqsEmployeeEmailList[index].mqsCommonLogin;
    showMqsEmpEmailList.value = true;
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
}
