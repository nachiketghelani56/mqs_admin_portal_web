import 'dart:convert';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/enterprise_model.dart';
import 'package:mqs_admin_portal_web/models/menu_option_model.dart';
import 'package:mqs_admin_portal_web/models/user_iam_model.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

class DashboardController extends GetxController {
  RxList<String> tabs = [
    StringConfig.dashboard.enterprise,
    StringConfig.dashboard.userIAM,
  ].obs;
  RxInt selectedTabIndex = 0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController subscriptionController = TextEditingController();
  final TextEditingController mqsEnterpriseCodeController =
      TextEditingController();
  final TextEditingController mqsEnterpriseNameController =
      TextEditingController();
  final TextEditingController mqsSubscriptionExpiryDateController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController pocAddressController = TextEditingController();
  final TextEditingController pocEmailController = TextEditingController();
  final TextEditingController pocNameController = TextEditingController();
  final TextEditingController pocPhoneNumberController =
      TextEditingController();
  final TextEditingController filterFieldController = TextEditingController();
  RxBool mqsCommonLogin = false.obs, isSignedUp = false.obs;
  RxBool showMqsEmpEmailList = false.obs,
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
  RxList<String> filterFields = [
    StringConfig.dashboard.about,
    StringConfig.dashboard.aboutValue,
    StringConfig.dashboard.country,
    StringConfig.dashboard.countryValue,
    StringConfig.dashboard.email,
    StringConfig.dashboard.firstName,
    StringConfig.dashboard.lastName,
    StringConfig.dashboard.pronouns,
    StringConfig.dashboard.pronounsValue,
    StringConfig.dashboard.userImage,
  ].obs;
  RxList<String> filterConditions = [
    StringConfig.dashboard.equalTo,
    StringConfig.dashboard.notEqualTo,
    StringConfig.dashboard.greaterThan,
    StringConfig.dashboard.greaterThanEqualTo,
    StringConfig.dashboard.lessThan,
    StringConfig.dashboard.lessThanEqualTo,
  ].obs;
  RxInt selectedConditionIndex = RxInt(-1);
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
  RxList<MqsEmployeeEmailModel> mqsEmployeeEmailList =
      <MqsEmployeeEmailModel>[].obs;
  RxList<MqsEnterprisePOC> mqsEnterprisePOCs = <MqsEnterprisePOC>[].obs;
  RxInt viewIndex = 0.obs;
  final GlobalKey<FormState> enterpriseFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> entEmpEmailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> entPOCFormKey = GlobalKey<FormState>();
  EnterpriseModel get enterpriseDetail => searchedEnterprises[viewIndex.value];
  RxInt editMqsEmpEmailIndex = RxInt(-1), editMqsEntPOCIndex = RxInt(-1);
  RxList<UserIAMModel> users = <UserIAMModel>[].obs;
  UserIAMModel get userDetail => users[viewIndex.value];
  RxInt pageLimit = 10.obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  int get totalEnterprisePage =>
      (searchedEnterprises.length / pageLimit.value).ceil();
  int get totalUserPage => (users.length / pageLimit.value).ceil();

  @override
  onInit() {
    getEnterprises();
    getUsers();
    super.onInit();
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
    subscriptionController.clear();
    mqsEnterpriseCodeController.clear();
    mqsEnterpriseNameController.clear();
    mqsSubscriptionExpiryDateController.clear();
    clearMqsEmpEmailFields();
    addressController.clear();
    pinCodeController.clear();
    clearMqsEntPOCFields();
    mqsEmployeeEmailList.clear();
    mqsEnterprisePOCs.clear();
  }

  clearMqsEmpEmailFields() {
    emailController.clear();
    mqsCommonLogin.value = false;
    isSignedUp.value = false;
    firstNameController.clear();
    lastNameController.clear();
  }

  clearMqsEntPOCFields() {
    pocAddressController.clear();
    pocEmailController.clear();
    pocNameController.clear();
    pocPhoneNumberController.clear();
  }

  getEnterprises() async {
    try {
      List<EnterpriseModel> ent =
          await FirebaseStorageService.i.getEnterprises();
      searchedEnterprises.value = ent;
      enterprises.value = ent;
      FirebaseStorageService.i.listenToEnterpriseChange((data) {
        List<EnterpriseModel> ent = data.docs
            .map((e) => EnterpriseModel.fromJson(e.data() as Map))
            .toList();
        searchedEnterprises.value = ent;
        enterprises.value = ent;
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getUsers() async {
    try {
      users.value = await FirebaseStorageService.i.getUsers();
      FirebaseStorageService.i.listenToUserChange((data) {
        users.value = data.docs
            .map((e) => UserIAMModel.fromJson(e.data() as Map))
            .toList();
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  addMqsEmpEmail() {
    mqsEmployeeEmailList.add(
      MqsEmployeeEmailModel(
        email: emailController.text.trim(),
        firstname: firstNameController.text.trim(),
        isSignedUp: isSignedUp.value,
        lastname: lastNameController.text.trim(),
        mqsCommonLogin: mqsCommonLogin.value,
      ),
    );
    clearMqsEmpEmailFields();
    showMqsEmpEmailList.value = false;
  }

  setMqsEmpEmailForm({required int index}) {
    editMqsEmpEmailIndex.value = index;
    emailController.text = mqsEmployeeEmailList[index].email;
    mqsCommonLogin.value = mqsEmployeeEmailList[index].mqsCommonLogin;
    isSignedUp.value = mqsEmployeeEmailList[index].isSignedUp;
    firstNameController.text = mqsEmployeeEmailList[index].firstname;
    lastNameController.text = mqsEmployeeEmailList[index].lastname;
    showMqsEmpEmailList.value = true;
  }

  editMqsEmpEmail() {
    mqsEmployeeEmailList[editMqsEmpEmailIndex.value].email =
        emailController.text.trim();
    mqsEmployeeEmailList[editMqsEmpEmailIndex.value].mqsCommonLogin =
        mqsCommonLogin.value;
    mqsEmployeeEmailList[editMqsEmpEmailIndex.value].isSignedUp =
        isSignedUp.value;
    mqsEmployeeEmailList[editMqsEmpEmailIndex.value].firstname =
        firstNameController.text;
    mqsEmployeeEmailList[editMqsEmpEmailIndex.value].lastname =
        lastNameController.text.trim();
    clearMqsEmpEmailFields();
    editMqsEmpEmailIndex.value = -1;
    showMqsEmpEmailList.value = false;
  }

  deleteMqsEmpEmial({required int index}) {
    mqsEmployeeEmailList.removeAt(index);
  }

  addMqsEntPOC() {
    mqsEnterprisePOCs.add(
      MqsEnterprisePOC(
        address: pocAddressController.text.trim(),
        email: pocEmailController.text.trim(),
        name: pocNameController.text.trim(),
        phoneNumber: pocPhoneNumberController.text.trim(),
      ),
    );
    clearMqsEntPOCFields();
    showMqsEnterprisePOCs.value = false;
  }

  setMqsEntPOCForm({required int index}) {
    editMqsEntPOCIndex.value = index;
    pocEmailController.text = mqsEnterprisePOCs[index].email;
    pocAddressController.text = mqsEnterprisePOCs[index].address;
    pocNameController.text = mqsEnterprisePOCs[index].name;
    pocPhoneNumberController.text = mqsEnterprisePOCs[index].phoneNumber;
    showMqsEnterprisePOCs.value = true;
  }

  editMqsEntPOC() {
    mqsEnterprisePOCs[editMqsEntPOCIndex.value].email = pocEmailController.text;

    mqsEnterprisePOCs[editMqsEntPOCIndex.value].address =
        pocAddressController.text;
    mqsEnterprisePOCs[editMqsEntPOCIndex.value].name = pocNameController.text;

    mqsEnterprisePOCs[editMqsEntPOCIndex.value].phoneNumber =
        pocPhoneNumberController.text;
    clearMqsEntPOCFields();
    editMqsEntPOCIndex.value = -1;
    showMqsEnterprisePOCs.value = false;
  }

  deleteMqsEntPOC({required int index}) {
    mqsEnterprisePOCs.removeAt(index);
  }

  addEnterprise() async {
    try {
      if (enterpriseFormKey.currentState?.validate() ?? false) {
        EnterpriseModel model = EnterpriseModel(
          subscription: subscriptionController.text.trim(),
          id: isEditEnterprise.value ? enterpriseDetail.id : '',
          mqsEmployeeEmailList: mqsEmployeeEmailList,
          mqsEnterpriseCode: mqsEnterpriseCodeController.text,
          mqsEnterpriseLocationDetails: MqsEnterpriseLocationDetails(
            address: addressController.text.trim(),
            pinCode: pinCodeController.text.trim(),
          ),
          mqsEnterpriseName: mqsEnterpriseNameController.text.trim(),
          mqsEnterprisePOCs: mqsEnterprisePOCs,
          mqsSubscriptionExpiryDate:
              mqsSubscriptionExpiryDateController.text.trim(),
        );
        showLoader();
        if (isEditEnterprise.value) {
          await FirebaseStorageService.i.editEnterprises(model: model);
        } else {
          await FirebaseStorageService.i.addEnterprises(model: model);
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
    subscriptionController.text = enterpriseDetail.subscription;
    mqsEnterpriseCodeController.text = enterpriseDetail.mqsEnterpriseCode;
    mqsEnterpriseNameController.text = enterpriseDetail.mqsEnterpriseName;
    mqsSubscriptionExpiryDateController.text =
        enterpriseDetail.mqsSubscriptionExpiryDate;
    mqsEmployeeEmailList.value = enterpriseDetail.mqsEmployeeEmailList;
    addressController.text =
        enterpriseDetail.mqsEnterpriseLocationDetails.address;
    pinCodeController.text =
        enterpriseDetail.mqsEnterpriseLocationDetails.pinCode;
    mqsEnterprisePOCs.value = enterpriseDetail.mqsEnterprisePOCs;
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

  importEnterprise() async {
    try {
      final result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['csv']);
      if (result != null) {
        String csvData = utf8.decode(result.files.single.bytes ?? []);
        List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);
        List<EnterpriseModel> importedModels = [];
        for (var i = 1; i < rows.length; i++) {
          var row = rows[i];
          EnterpriseModel model = EnterpriseModel(
            id: '',
            subscription: row[0],
            mqsEnterpriseName: row[1],
            mqsEnterpriseCode: row[2].toString(),
            mqsSubscriptionExpiryDate: row[3],
            mqsEmployeeEmailList: (jsonDecode(row[4]) as List)
                .map((e) => MqsEmployeeEmailModel.fromJson(e))
                .toList(),
            mqsEnterpriseLocationDetails: MqsEnterpriseLocationDetails.fromJson(
              jsonDecode(row[5]),
            ),
            mqsEnterprisePOCs: (jsonDecode(row[6]) as List)
                .map((e) => MqsEnterprisePOC.fromJson(e))
                .toList(),
          );
          importedModels.add(model);
        }
        for (final enterprise in importedModels) {
          await FirebaseStorageService.i.addEnterprises(model: enterprise);
        }
      }
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  exportEnterprise() async {
    try {
      List<List<String>> rows = [
        [
          // 'ID',
          StringConfig.csv.subscription,
          StringConfig.dashboard.mqsEnterPriseName,
          StringConfig.dashboard.mqsEnterPriseCode,
          StringConfig.dashboard.mqsSubscriptionExpiryDate,
          StringConfig.csv.employeeEmails,
          StringConfig.csv.enterpriseLocation,
          StringConfig.csv.pocs
        ],
        // Data Rows
        ...enterprises.map((model) {
          return [
            // model.id,
            model.subscription,
            model.mqsEnterpriseName,
            model.mqsEnterpriseCode,
            model.mqsSubscriptionExpiryDate,
            jsonEncode(
                model.mqsEmployeeEmailList.map((e) => e.toJson()).toList()),
            jsonEncode(model.mqsEnterpriseLocationDetails.toJson()),
            jsonEncode(model.mqsEnterprisePOCs.map((p) => p.toJson()).toList()),
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
    viewIndex.value = 0;
    selectedTabIndex.value = index;
    offset.value = 0;
    currentPage.value = 1;
  }

  getMaxOffset() {
    int rem = (selectedTabIndex.value == 0
            ? searchedEnterprises.length
            : users.length) %
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
        searchedEnterprises.value = enterprises
            .where((e) =>
                e.subscription.toLowerCase().contains(query) ||
                e.mqsEnterpriseCode.toLowerCase().contains(query) ||
                e.mqsEnterpriseName.toLowerCase().contains(query))
            .toList();
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }
}
