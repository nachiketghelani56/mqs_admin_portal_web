import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_user_iam_model.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/services/firebase_auth_service.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/user_IAM_repository.dart';
import 'package:mqs_admin_portal_web/views/database/controller/database_controller.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class UserDataController extends GetxController {
  RxBool isAdd = false.obs, isEdit = false.obs;

  RxBool userLoader = false.obs;
  RxList<MQSMyQUserIamModel> searchedUsers = <MQSMyQUserIamModel>[].obs,
      users = <MQSMyQUserIamModel>[].obs;
  RxInt pageLimit = 10.obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  RxInt viewIndex = (-1).obs;
  final TextEditingController searchController = TextEditingController();
  RxInt selectedTabIndex = 0.obs;
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
  RxBool showMqsUserMilestone = false.obs;

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
          return (e.mqsEmail?.toLowerCase().contains(query) ?? false) ||
              (e.mqsFirstName?.toLowerCase().contains(query) ?? false) ||
              (e.mqsLastName?.toLowerCase().contains(query) ?? false) ||
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
}
