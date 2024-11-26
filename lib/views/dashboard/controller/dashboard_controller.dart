import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/enterprise_model.dart';
import 'package:mqs_admin_portal_web/models/menu_option_model.dart';
import 'package:mqs_admin_portal_web/models/user_iam_model.dart';
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
  final TextEditingController filterFieldController = TextEditingController();
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
  RxList<MqsEmployee> mqsEmployeeEmailList = <MqsEmployee>[].obs;
  RxList<MqsTeam> mqsTeamList = <MqsTeam>[].obs;
  RxList<MqsEnterprisePOCs> mqsEnterprisePOCs = <MqsEnterprisePOCs>[].obs;
  RxInt viewIndex = 0.obs;
  RxInt selectedViewIndex = (-1).obs;
  final GlobalKey<FormState> enterpriseFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> entEmpEmailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> entTeamFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> entPOCFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> entPOCSubscriptionFormKey = GlobalKey<FormState>();
  EnterpriseModel get enterpriseDetail => searchedEnterprises[viewIndex.value];
  RxInt editMqsEmpEmailIndex = RxInt(-1),
      editMqsEntPOCIndex = RxInt(-1),
      editMqsTeamIndex = RxInt(-1);
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
      print("Fetched Enterprises: ${enterpriseList.length}");
      searchedEnterprises.value = enterpriseList;
      enterprises.value = enterpriseList;

      FirebaseStorageService.i.getEnterpriseStream().listen((enterpriseList) {
        searchedEnterprises.value = enterpriseList; // Update searched list
        enterprises.value = enterpriseList; // Update full list
      });
    } catch (e) {
      print("e-->${e.toString()}");
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
          mqsCreatedTimestamp: DateTime.now().toIso8601String(),
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
    startDate.value = DateTime.parse(enterpriseDetail
            .mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionStartDate)
        .toIso8601String();
    expiryDate.value = DateTime.parse(enterpriseDetail
            .mqsEnterprisePOCsSubscriptionDetails.mqsSubscriptionExpiryDate)
        .toIso8601String();
    mqsEmployeeEmailList.value = enterpriseDetail.mqsEmployeeList;
    mqsTeamList.value = enterpriseDetail.mqsTeamList;
  }

  deleteEnterprise({required String docId}) async {
    try {
      showLoader();
      viewIndex.value = 0;
      selectedViewIndex.value = (-1);
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
      // final result = await FilePicker.platform.pickFiles(
      //     allowMultiple: false,
      //     type: FileType.custom,
      //     allowedExtensions: ['csv']);
      // if (result != null) {
      //   String csvData = utf8.decode(result.files.single.bytes ?? []);
      //   List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);
      //   List<EnterpriseModel> importedModels = [];
      //   for (var i = 1; i < rows.length; i++) {
      //     var row = rows[i];
      //     EnterpriseModel model = EnterpriseModel(
      //       id: '',
      //       subscription: row[0],
      //       mqsEnterpriseName: row[1],
      //       mqsEnterpriseCode: row[2].toString(),
      //       mqsSubscriptionExpiryDate: row[3],
      //       mqsEmployeeEmailList: (jsonDecode(row[4]) as List)
      //           .map((e) => MqsEmployeeEmailModel.fromJson(e))
      //           .toList(),
      //       mqsEnterpriseLocationDetails: MqsEnterpriseLocationDetails.fromJson(
      //         jsonDecode(row[5]),
      //       ),
      //       mqsEnterprisePOCs: (jsonDecode(row[6]) as List)
      //           .map((e) => MqsEnterprisePOC.fromJson(e))
      //           .toList(),
      //     );
      //     importedModels.add(model);
      //   }
      //   for (final enterprise in importedModels) {
      //     await FirebaseStorageService.i.addEnterprises(model: enterprise);
      //   }
      // }
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  exportEnterprise() async {
    try {
      // List<List<String>> rows = [
      //   [
      //     // 'ID',
      //     StringConfig.csv.subscription,
      //     StringConfig.dashboard.mqsEnterPriseName,
      //     StringConfig.dashboard.mqsEnterPriseCode,
      //     StringConfig.dashboard.mqsSubscriptionExpiryDate,
      //     StringConfig.csv.employeeEmails,
      //     StringConfig.csv.enterpriseLocation,
      //     StringConfig.csv.pocs
      //   ],
      //   // Data Rows
      //   ...enterprises.map((model) {
      //     return [
      //       // model.id,
      //       model.subscription,
      //       model.mqsEnterpriseName,
      //       model.mqsEnterpriseCode,
      //       model.mqsSubscriptionExpiryDate,
      //       jsonEncode(
      //           model.mqsEmployeeEmailList.map((e) => e.toJson()).toList()),
      //       jsonEncode(model.mqsEnterpriseLocationDetails.toJson()),
      //       jsonEncode(model.mqsEnterprisePOCs.map((p) => p.toJson()).toList()),
      //     ];
      //   }),
      // ];
      // String csvData = const ListToCsvConverter().convert(rows);
      // Uint8List bytes = Uint8List.fromList(utf8.encode(csvData));
      // await FileSaver.instance.saveFile(
      //   bytes: bytes,
      //   ext: "csv",
      //   mimeType: MimeType.csv,
      //   name: StringConfig.dashboard.enterpriseCollection,
      // );
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
        // searchedEnterprises.value = enterprises
        //     .where((e) =>
        //         e.subscription.toLowerCase().contains(query) ||
        //         e.mqsEnterpriseCode.toLowerCase().contains(query) ||
        //         e.mqsEnterpriseName.toLowerCase().contains(query))
        //     .toList();
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
    // DateTime? date = await showDatePicker(
    //   context: context,
    //   firstDate: dashboardController.startDate.value.isNotEmpty
    //       ? DateTime.parse(
    //           dashboardController.startDate.value,
    //         )
    //       : DateTime.now(),
    //   lastDate: DateTime(3000),
    //   initialDate: dashboardController.startDate.value.isNotEmpty
    //       ? DateTime.parse(
    //           dashboardController.startDate.value,
    //         )
    //       : DateTime.now(),
    // );
    // if (date != null) {
    //   dashboardController.mqsSubscriptionExpiryDateController.text =
    //       '${date.day}-${date.month}-${date.year}';
    //   dashb

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
}
