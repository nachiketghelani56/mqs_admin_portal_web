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
import 'package:mqs_admin_portal_web/models/mqs_my_q_user_iam_model.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/services/firebase_auth_service.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/user_IAM_repository.dart';
import 'package:mqs_admin_portal_web/views/database/controller/database_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

class UserDataController extends GetxController {
  RxBool isAdd = false.obs, isEdit = false.obs;
  RxString userActivateDate = "".obs, enterpriseCreatedDate = "".obs;
  RxBool userLoader = false.obs;
  RxString createdTimestamp = "".obs;
  RxList<MQSMyQUserIamModel> searchedUsers = <MQSMyQUserIamModel>[].obs,
      users = <MQSMyQUserIamModel>[].obs;
  RxInt pageLimit = 10.obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  RxInt viewIndex = (-1).obs;
  final TextEditingController searchController = TextEditingController();
  RxInt selectedTabIndex = 0.obs;
  RxBool showCognitive = false.obs,
      showMindSkill = false.obs,
      showTechnique = false.obs;
  int get totalUserPage => (searchedUsers.length / pageLimit.value).ceil();

  MQSMyQUserIamModel get userDetail => searchedUsers[viewIndex.value];
  RxList<MQSMyQUserSubscriptionReceiptModel> userSubscriptionReceipts =
      <MQSMyQUserSubscriptionReceiptModel>[].obs;
  StreamSubscription<List<MQSMyQUserIamModel>>? userStream;

  MQSMyQUserSubscriptionReceiptModel? get userSubscriptionDetail =>
      userSubscriptionReceipts
          .firstWhereOrNull((e) => e.mqsFirebaseUserID == userDetail.mqsUserID);
  RxBool showCheckIn = false.obs,
      showDemographic = false.obs,
      showScenes = false.obs,
      showWOL = false.obs;
  RxList<int> sceneIndexes = <int>[].obs;
  RxBool showMqsUserMilestone = false.obs,showMqsUserBadges = false.obs;
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController appVersionController = TextEditingController();
  final TextEditingController enterpriseUserFlagController =
      TextEditingController();
  final TextEditingController registrationStatusController =
      TextEditingController();
  final TextEditingController mONGODBUserIDController = TextEditingController();
  final TextEditingController userLoginWithController = TextEditingController();
  final TextEditingController userActiveTimestampController =
      TextEditingController();
  final TextEditingController enterpriseCreatedTimestampController =
      TextEditingController();
  RxBool enterpriseUserFlag = false.obs;
  RxString userId = "".obs;

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
    getUsers();
    super.onInit();
  }

  @override
  void onClose() async {
    await userStream?.cancel();
    super.onClose();
  }

  clearAllFields() {
    userIdController.clear();
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
    appVersionController.clear();
    enterpriseUserFlagController.clear();
    registrationStatusController.clear();
    mONGODBUserIDController.clear();
    userLoginWithController.clear();
    userActiveTimestampController.clear();
    enterpriseCreatedTimestampController.clear();
    enterpriseUserFlag.value = false;
    userActivateDate.value = "";
    enterpriseCreatedDate.value = "";
  }

  deleteUser({required String docId}) async {
    try {
      showLoader();
      viewIndex.value = 0;
      isAdd.value = false;
      isEdit.value = false;
      await UserRepository.i.deleteUser(docId: docId);
      hideLoader();
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  addUser() async {
    try {
      final MqsDashboardController mqsDashboardController =
          Get.put(MqsDashboardController());

      final docRef = FirebaseStorageService.i.user.doc().id;
      final user = MQSMyQUserIamModel(
        mqsUserID: userIdController.text.trim(),
        mqsEmail: emailController.text.trim(),
        mqsFirstName: firstNameController.text.trim(),
        mqsLastName: lastNameController.text.trim(),
        mqsAppVersion: appVersionController.text.trim(),
        mqsRegistrationStatus: registrationStatusController.text.trim(),
        mqsEnterpriseUserFlag: enterpriseUserFlag.value,
        mqsMONGODBUserID: mONGODBUserIDController.text.trim(),
        mqsUserLoginWith: userLoginWithController.text.trim(),
        mqsUserActiveTimestamp: userActivateDate.value.trim(),
        mqsEnterpriseCreatedTimestamp: enterpriseCreatedDate.value.trim(),
        mqsCreatedTimestamp: isEdit.value
            ? createdTimestamp.value
            : DateTime.now().toIso8601String(),
        mqsUpdatedTimestamp: DateTime.now().toIso8601String(),
      );

      showLoader();

      if (isEdit.value) {
        await UserRepository.i.editUser(userModel: user, docId: userId.value);
      } else {
        await UserRepository.i.addUser(userModel: user, customId: docRef);
      }
      hideLoader();
      clearAllFields();
      isAdd.value = false;
      isEdit.value = false;

      mqsDashboardController.userStatus.value = "";
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  setUserForm() {
    userId.value = userDetail.id ?? "";
    userIdController.text = userDetail.mqsUserID ?? "";
    emailController.text = userDetail.mqsEmail ?? "";
    firstNameController.text = userDetail.mqsFirstName ?? "";
    lastNameController.text = userDetail.mqsLastName ?? "";
    appVersionController.text = userDetail.mqsAppVersion ?? "";
    enterpriseUserFlag.value = userDetail.mqsEnterpriseUserFlag ?? false;
    registrationStatusController.text = userDetail.mqsRegistrationStatus ?? "";
    mONGODBUserIDController.text = userDetail.mqsMONGODBUserID ?? "";
    userLoginWithController.text = userDetail.mqsUserLoginWith ?? "";
    userActiveTimestampController.text =
        dateConvert(userDetail.mqsUserActiveTimestamp ?? "");
    enterpriseCreatedTimestampController.text =
        dateConvert(userDetail.mqsEnterpriseCreatedTimestamp ?? "");

    userActivateDate.value = userDetail.mqsUserActiveTimestamp?.isEmpty ?? false
        ? ""
        : DateTime.parse(userDetail.mqsUserActiveTimestamp ?? "")
            .toIso8601String();
    enterpriseCreatedDate.value =
        userDetail.mqsEnterpriseCreatedTimestamp?.isEmpty ?? false
            ? ""
            : DateTime.parse(userDetail.mqsEnterpriseCreatedTimestamp ?? '')
                .toIso8601String();

    createdTimestamp.value = userDetail.mqsCreatedTimestamp ?? "";
  }

  Future<void> pickUserActivateDateTime(
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

        userActiveTimestampController.text = formattedDateTime;

        userActivateDate.value = pickedDateTime.toIso8601String();
      }
    }
  }

  Future<void> pickEnterpriseCreatedDateTime(
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

        enterpriseCreatedTimestampController.text = formattedDateTime;

        enterpriseCreatedDate.value = pickedDateTime.toIso8601String();
      }
    }
  }

  getUsers() async {
    try {
      if (!FirebaseAuthService.i.isMarketingUser) {
        userLoader.value = true;

        List<MQSMyQUserIamModel> userList = await UserRepository.i.getUsers();
        searchedUsers.value = userList;
        users.value = userList;
        userStream = UserRepository.i.getUserStream().listen((data) {
          searchedUsers.value = data;

          users.value = data;
          viewIndex.value = -1;
        });
        if (Get.isRegistered<DatabaseController>()) {
          Get.find<DatabaseController>().setFilterFields();
        }
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {
      userLoader.value = false;
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

  searchUser({String? status}) {
    try {
      reset();
      String query = searchController.text.trim().toLowerCase();
      if (query.isEmpty) {
        searchedUsers.value = users;
      } else {
        searchedUsers.value = users.where((e) {
          final firstAndLastName =
              '${e.mqsFirstName?.toLowerCase()} ${e.mqsLastName?.toLowerCase()}';
          return (e.mqsEmail?.toLowerCase().contains(query) ?? false) ||
              firstAndLastName.contains(query) ||
              (e.mqsUserLoginWith?.toLowerCase().contains(query) ?? false);
        }).toList();
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

  getMaxOffset({bool? isReport}) {
    int rem = (searchedUsers.length) % pageLimit.value;
    if (rem != 0 && currentPage.value == totalUserPage) {
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
      if (currentPage.value < totalUserPage) {
        offset.value = offset.value + pageLimit.value;
        currentPage.value++;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  importUserIAM() async {
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

          List<MQSUserMilestones> mileStonesList = [];
          if (rowMap[StringConfig.dashboard.userMilestoneList] != null &&
              rowMap[StringConfig.dashboard.userMilestoneList]
                  .toString()
                  .isNotEmpty) {
            try {
              List<dynamic> mileStones =
                  jsonDecode(rowMap[StringConfig.dashboard.userMilestoneList]);
              mileStonesList = mileStones.map((team) {
                return MQSUserMilestones(
                  mqsMilestoneID: team['mqsMilestoneID'] ?? "",
                  mqsMilestoneName: team['mqsMilestoneName'] ?? "",
                  mqsMilestoneImage: team['mqsMilestoneImage'] ?? "",
                  mqsMilestoneDescription:
                      team['mqsMilestoneDescription'] ?? "",
                  mqsAboutMilestone: team['mqsAboutMilestone'] ?? "",
                );
              }).toList();
            } catch (e) {
              errorDialogWidget(msg: e.toString());
            }
          }
          List<MQSUserBadges> userBadgeList = [];
          if (rowMap[StringConfig.dashboard.userBadgesList] != null &&
              rowMap[StringConfig.dashboard.userBadgesList]
                  .toString()
                  .isNotEmpty) {
            try {
              List<dynamic> userBadge =
              jsonDecode(rowMap[StringConfig.dashboard.userBadgesList]);
              userBadgeList = userBadge.map((team) {
                return MQSUserBadges(
                  mqsBadgeID: team['mqsBadgeID'] ?? "",
                  mqsBadgeName: team['mqsBadgeName'] ?? "",
                  mqsBadgeImage: team['mqsBadgeImage'] ?? "",
                  mqsAwardTimestamp:
                  team['mqsAwardTimestamp'] ?? "",
                  mqsBadgeNotes: team['mqsBadgeNotes'] ?? "",
                );
              }).toList();
            } catch (e) {
              errorDialogWidget(msg: e.toString());
            }
          }


          final docRef = FirebaseStorageService.i.enterprise.doc().id;
          MQSMyQUserIamModel user = MQSMyQUserIamModel(
            id: docRef,
            mqsEmail: rowMap[StringConfig.dashboard.email].toString(),
            mqsFirstName: rowMap[StringConfig.dashboard.firstName].toString(),
            mqsLastName: rowMap[StringConfig.dashboard.lastName].toString(),
            mqsCreatedTimestamp:
                rowMap[StringConfig.reporting.creationDate].toString().isEmpty
                    ? ""
                    : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                        .parse(rowMap[StringConfig.reporting.creationDate])
                        .toIso8601String(),
            mqsEnterpriseUserFlag: rowMap[StringConfig.reporting.enterpriseUser]
                    ?.toString()
                    .toLowerCase() ==
                'true',
            mqsUserID: rowMap[StringConfig.dashboard.userId].toString(),
            mqsMONGODBUserID:
                rowMap[StringConfig.reporting.mongoDbUserId].toString(),
            mqsUserLoginWith:
                rowMap[StringConfig.dashboard.loginWith].toString(),
            mqsUserActiveTimestamp:
                rowMap[StringConfig.dashboard.userActiveTimestamp]
                        .toString()
                        .isEmpty
                    ? ""
                    : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                        .parse(
                            rowMap[StringConfig.dashboard.userActiveTimestamp])
                        .toIso8601String(),
            mqsEnterpriseCreatedTimestamp:
                rowMap[StringConfig.dashboard.enterpriseCreatedTimestamp]
                        .toString()
                        .isEmpty
                    ? ""
                    : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                        .parse(rowMap[
                            StringConfig.dashboard.enterpriseCreatedTimestamp])
                        .toIso8601String(),
            mqsRegistrationStatus:
                rowMap[StringConfig.dashboard.registrationStatus].toString(),
            mqsUserMilestones: mileStonesList,
            mqsUserBadges: userBadgeList,
            mqsAppVersion:
                rowMap[StringConfig.dashboard.appVersion]?.toString() ?? "",
            mqsUserGrowth:MQSUserGrowth.fromJson(
                parseJsonToModel(rowMap[StringConfig.dashboard.userGrowth])),

            mqsEnterpriseDetails: MQSEnterpriseDetails.fromJson(
                parseJsonToModel(
                    rowMap[StringConfig.dashboard.enterpriseDetail])),
            // mqsOnboardingDetails: MQSOnboardingDetails.fromJson(
            //     parseJsonToModel(
            //         rowMap[StringConfig.dashboard.onboardingDetails])),
            mqsUserJMStatus: MQSUserJMStatus.fromJson(
                parseJsonToModel(rowMap[StringConfig.dashboard.userJMSStatus])),
            mqsUserChallengesStatus: MQSUserChallengesStatus.fromJson(
                parseJsonToModel(
                    rowMap[StringConfig.dashboard.userChallengesStatus])),
            mqsPrivacySettingsDetails: MQSPrivacySettingsDetails.fromJson(
                parseJsonToModel(
                    rowMap[StringConfig.dashboard.privacySettingsDetails])),
            mqsUserProfile: MQSUserProfile.fromJson(
                parseJsonToModel(rowMap[StringConfig.dashboard.userProfile])),
            mqsUpdatedTimestamp: rowMap[StringConfig.reporting.creationDate]
                        ?.toString()
                        .isEmpty ??
                    true
                ? ""
                : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .parse(
                        rowMap[StringConfig.reporting.creationDate].toString())
                    .toIso8601String(),
          );
          await UserRepository.i.addUser(userModel: user, customId: docRef);
        }
      }
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
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
            // jsonEncode(model.mqsOnboardingDetails?.toJson()),
            jsonEncode(model.mqsEnterpriseDetails?.toJson()),
            jsonEncode(model.mqsUserJMStatus?.toJson()),
            jsonEncode(model.mqsUserChallengesStatus?.toJson()),
            jsonEncode(model.mqsPrivacySettingsDetails?.toJson()),
            jsonEncode(model.mqsUserGrowth?.toJson()),
            jsonEncode(model.mqsUserProfile?.toJson()),
            jsonEncode(model.mqsUserMilestones?.isNotEmpty ?? false
                ? model.mqsUserMilestones?.toList()
                : []),
            jsonEncode(model.mqsUserBadges?.isNotEmpty ?? false
                ? model.mqsUserBadges?.toList()
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
          // StringConfig.dashboard.onboardingDetails,
          StringConfig.dashboard.enterpriseDetail,
          StringConfig.dashboard.userJMSStatus,
          StringConfig.dashboard.userChallengesStatus,
          StringConfig.dashboard.privacySettingsDetails,
          StringConfig.dashboard.userGrowth,
          StringConfig.dashboard.userProfile,
          StringConfig.dashboard.userMilestoneList,
          StringConfig.dashboard.userBadgesList,
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

  parseJsonToModel(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return null;
    try {
      return json.decode(jsonString);
    } catch (e) {
      return null;
    }
  }
}
