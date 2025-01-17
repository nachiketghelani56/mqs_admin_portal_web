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
import 'package:mqs_admin_portal_web/models/mqs_my_q_user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/user_IAM_repository.dart';
import 'package:mqs_admin_portal_web/views/database/controller/database_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

class UserSubscriptionReceiptController extends GetxController {
  StreamSubscription<List<MQSMyQUserSubscriptionReceiptModel>>?
      userSubscriptionReceiptStream;

  RxBool userSubscriptionReceiptLoader = false.obs;
  final TextEditingController searchController = TextEditingController();
  final MqsDashboardController mqsDashboardController =
      Get.put(MqsDashboardController());
  RxList<MQSMyQUserSubscriptionReceiptModel> searchedUserSubRec =
          <MQSMyQUserSubscriptionReceiptModel>[].obs,
      userSubscriptionReceipts = <MQSMyQUserSubscriptionReceiptModel>[].obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  RxInt viewIndex = (-1).obs;
  MQSMyQUserSubscriptionReceiptModel get userSubscriptionReceiptDetail =>
      searchedUserSubRec[viewIndex.value];
  RxBool isAdd = false.obs, isEdit = false.obs;
  RxString startDate = "".obs, expiryDate = "".obs, renewalDate = "".obs;
  RxInt pageLimit = 10.obs;
  int get totalCirclePage =>
      (searchedUserSubRec.length / pageLimit.value).ceil();
  final TextEditingController firebaseIdController = TextEditingController();
  final TextEditingController mONGODBUserIDController = TextEditingController();
  final TextEditingController appSpecificSharedSecretController =
      TextEditingController();
  final TextEditingController subscriptionExpiryTimestampController =
      TextEditingController();
  final TextEditingController localVerificationDataController =
      TextEditingController();
  final TextEditingController packageNameController = TextEditingController();
  final TextEditingController purchaseIDController = TextEditingController();
  final TextEditingController serverVerificationDataController =
      TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController subscriptionActivePlanController =
      TextEditingController();
  final TextEditingController subscriptionPlatformController =
      TextEditingController();
  final TextEditingController transactionIDController = TextEditingController();
  final TextEditingController subscriptionStatusController =
      TextEditingController();
  final TextEditingController subscriptionActivationTimestampController =
      TextEditingController();
  final TextEditingController subscriptionRenewalController =
      TextEditingController();
  RxString createdTimestamp = "".obs;

  @override
  onInit() {
    getUserSubscriptionRecipts();
    super.onInit();
  }

  @override
  void onClose() async {
    await userSubscriptionReceiptStream?.cancel();
    super.onClose();
  }

  getMaxOffset() {
    int rem = searchedUserSubRec.length % pageLimit.value;
    if (rem != 0 && currentPage.value == totalCirclePage) {
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
      if (currentPage.value < totalCirclePage) {
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

  deleteUserSubRec({required String docId}) async {
    try {
      showLoader();
      viewIndex.value = 0;
      isAdd.value = false;
      isEdit.value = false;
      await UserRepository.i.deleteUserSubRec(docId: docId);
      hideLoader();
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  clearAllFields() {
    firebaseIdController.clear();
    mONGODBUserIDController.clear();
    appSpecificSharedSecretController.clear();
    subscriptionExpiryTimestampController.clear();
    localVerificationDataController.clear();
    packageNameController.clear();
    purchaseIDController.clear();
    serverVerificationDataController.clear();
    sourceController.clear();
    subscriptionActivePlanController.clear();
    subscriptionPlatformController.clear();
    transactionIDController.clear();
    subscriptionStatusController.clear();
    subscriptionActivationTimestampController.clear();
    subscriptionRenewalController.clear();
    expiryDate.value = "";
    startDate.value = "";
    renewalDate.value = "";
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

        subscriptionActivationTimestampController.text = formattedDateTime;

        startDate.value = pickedDateTime.toIso8601String();
      }
    }
  }

  Future<void> pickExpiryDateTime(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      firstDate: isEdit.value
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
      initialDate: isEdit.value
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

        subscriptionExpiryTimestampController.text = formattedDateTime;

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

        subscriptionRenewalController.text = formattedDateTime;

        renewalDate.value = pickedDateTime.toIso8601String();
        subscriptionExpiryTimestampController.clear();

        expiryDate.value = "";
      }
    }
  }

  getUserSubscriptionRecipts() async {
    try {
      userSubscriptionReceiptLoader.value = true;
      List<MQSMyQUserSubscriptionReceiptModel> userSubRecList =
          await UserRepository.i.getUserSubscriptionReceipt();

      searchedUserSubRec.value = userSubRecList;
      userSubscriptionReceipts.value = userSubRecList;
      userSubscriptionReceiptStream =
          UserRepository.i.getUserSubscriptionReceiptStream().listen((data) {
        userSubscriptionReceipts.value = data;
        searchedUserSubRec.value = data;
        viewIndex.value = -1;
      });
      if (Get.isRegistered<DatabaseController>()) {
        Get.find<DatabaseController>().setFilterFields();
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {
      userSubscriptionReceiptLoader.value = false;
    }
  }

  addUserSubRec() async {
    try {
      final docRef = FirebaseStorageService.i.enterprise.doc().id;
      final userSubRecModel = MQSMyQUserSubscriptionReceiptModel(
        mqsFirebaseUserID: firebaseIdController.text.trim(),
        mqsMONGODBUserID: mONGODBUserIDController.text.trim(),
        mqsAppSpecificSharedSecret:
            appSpecificSharedSecretController.text.trim(),
        mqsSubscriptionExpiryTimestamp: expiryDate.value.trim(),
        mqsLocalVerificationData: localVerificationDataController.text.trim(),
        mqsPackageName: packageNameController.text.trim(),
        mqsPurchaseID: purchaseIDController.text.trim(),
        mqsServerVerificationData: serverVerificationDataController.text.trim(),
        mqsSource: sourceController.text.trim(),
        mqsSubscriptionActivePlan: subscriptionActivePlanController.text.trim(),
        mqsSubscriptionPlatform: subscriptionPlatformController.text.trim(),
        mqsTransactionID: transactionIDController.text.trim(),
        mqsSubscriptionStatus: subscriptionStatusController.text.trim(),
        mqsCreatedTimestamp: isEdit.value
            ? createdTimestamp.value
            : DateTime.now().toIso8601String(),
        mqsUpdatedTimestamp: DateTime.now().toIso8601String(),
        mqsSubscriptionActivationTimestamp: startDate.value.trim(),
        mqsSubscriptionRenewalTimestamp:
            isEdit.value ? renewalDate.value.trim() : "",
      );
      showLoader();

      if (isEdit.value) {
        await UserRepository.i.editUserSubRec(
            userSubscriptionReceiptModel: userSubRecModel,
            docId: userSubscriptionReceiptDetail.id ?? "");
      } else {
        await UserRepository.i.addUserSubRec(
            customId: docRef, userSubscriptionReceiptModel: userSubRecModel);
      }

      hideLoader();
      clearAllFields();
      isAdd.value = false;
      isEdit.value = false;
      mqsDashboardController.userSubRecStatus.value = "";
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  setUserSubRecForm() {
    firebaseIdController.text =
        userSubscriptionReceiptDetail.mqsFirebaseUserID ?? "";
    mONGODBUserIDController.text =
        userSubscriptionReceiptDetail.mqsMONGODBUserID ?? "";
    appSpecificSharedSecretController.text =
        userSubscriptionReceiptDetail.mqsAppSpecificSharedSecret ?? "";

    localVerificationDataController.text =
        userSubscriptionReceiptDetail.mqsLocalVerificationData ?? "";
    packageNameController.text =
        userSubscriptionReceiptDetail.mqsPackageName ?? "";
    purchaseIDController.text =
        userSubscriptionReceiptDetail.mqsPurchaseID ?? "";
    serverVerificationDataController.text =
        userSubscriptionReceiptDetail.mqsServerVerificationData ?? "";
    sourceController.text = userSubscriptionReceiptDetail.mqsSource ?? "";
    subscriptionActivePlanController.text =
        userSubscriptionReceiptDetail.mqsSubscriptionActivePlan ?? "";
    subscriptionPlatformController.text =
        userSubscriptionReceiptDetail.mqsSubscriptionPlatform ?? "";
    transactionIDController.text =
        userSubscriptionReceiptDetail.mqsTransactionID ?? "";
    subscriptionStatusController.text =
        userSubscriptionReceiptDetail.mqsSubscriptionStatus ?? "";
    subscriptionExpiryTimestampController.text = dateConvert(
        userSubscriptionReceiptDetail.mqsSubscriptionExpiryTimestamp ?? "");
    subscriptionActivationTimestampController.text = dateConvert(
        userSubscriptionReceiptDetail.mqsSubscriptionActivationTimestamp ?? "");
    subscriptionRenewalController.text = dateConvert(
        userSubscriptionReceiptDetail.mqsSubscriptionRenewalTimestamp ?? "");
    startDate.value = userSubscriptionReceiptDetail
                .mqsSubscriptionActivationTimestamp?.isEmpty ??
            false
        ? ""
        : DateTime.parse(userSubscriptionReceiptDetail
                    .mqsSubscriptionActivationTimestamp ??
                "")
            .toIso8601String();
    expiryDate.value = userSubscriptionReceiptDetail
                .mqsSubscriptionExpiryTimestamp?.isEmpty ??
            false
        ? ""
        : DateTime.parse(
                userSubscriptionReceiptDetail.mqsSubscriptionExpiryTimestamp ??
                    "")
            .toIso8601String();
    renewalDate.value = userSubscriptionReceiptDetail
                .mqsSubscriptionRenewalTimestamp?.isEmpty ??
            false
        ? ""
        : DateTime.parse(
                userSubscriptionReceiptDetail.mqsSubscriptionRenewalTimestamp ??
                    "")
            .toIso8601String();
    createdTimestamp.value =
        userSubscriptionReceiptDetail.mqsCreatedTimestamp ?? "";
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

  searchUserSubRec({String? status}) {
    try {
      reset();
      String query = searchController.text.trim().toLowerCase();
      if (query.isEmpty) {
        searchedUserSubRec.value = userSubscriptionReceipts;
      } else {
        searchedUserSubRec.value = userSubscriptionReceipts
            .where((e) =>
                (e.mqsAppSpecificSharedSecret ?? "")
                    .toLowerCase()
                    .contains(query) ||
                (e.mqsMONGODBUserID ?? "").toLowerCase().contains(query) ||
                (e.mqsFirebaseUserID ?? "").toLowerCase().contains(query) ||
                (e.mqsSubscriptionPlatform ?? "")
                    .toLowerCase()
                    .contains(query) ||
                (e.mqsSubscriptionActivePlan ?? "")
                    .toLowerCase()
                    .contains(query))
            .toList();
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  importUserSubRec() async {
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

          final docRef = FirebaseStorageService.i.enterprise.doc().id;

          MQSMyQUserSubscriptionReceiptModel userSubscriptionReceipt =
              MQSMyQUserSubscriptionReceiptModel(
            mqsFirebaseUserID:
                rowMap[StringConfig.reporting.firebaseUserId].toString() ?? "",
            mqsMONGODBUserID:
                rowMap[StringConfig.reporting.mongoDbUserId].toString() ?? "",
            mqsAppSpecificSharedSecret:
                rowMap[StringConfig.reporting.appSpecificSharedSecret]
                        .toString() ??
                    "",
            mqsSubscriptionExpiryTimestamp:
                rowMap[StringConfig.dashboard.expiryDate].toString().isEmpty
                    ? ""
                    : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                        .parse(rowMap[StringConfig.dashboard.expiryDate])
                        .toIso8601String(),
            mqsLocalVerificationData:
                rowMap[StringConfig.reporting.localVerificationData]
                        .toString() ??
                    "",
            mqsPackageName:
                rowMap[StringConfig.reporting.packageName].toString(),
            mqsPurchaseID: rowMap[StringConfig.reporting.purchaseId].toString(),
            mqsServerVerificationData:
                rowMap[StringConfig.reporting.serverVerificationData]
                        .toString() ??
                    "",
            mqsSource: rowMap[StringConfig.reporting.source].toString(),
            mqsSubscriptionActivePlan:
                rowMap[StringConfig.reporting.subscriptionActivePlan]
                    .toString(),
            mqsSubscriptionPlatform:
                rowMap[StringConfig.reporting.subscriptionPlatform]
                    .toString()
                    .toString(),
            mqsTransactionID:
                rowMap[StringConfig.reporting.transactionId].toString(),
            mqsSubscriptionStatus:
                rowMap[StringConfig.reporting.subscriptionStatus].toString(),
            mqsCreatedTimestamp:
                rowMap[StringConfig.csv.createdTimestamp].toString().isEmpty
                    ? ""
                    : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                        .parse(rowMap[StringConfig.csv.createdTimestamp])
                        .toIso8601String(),
            mqsUpdatedTimestamp:
                rowMap[StringConfig.csv.updatedTimestamp].toString().isEmpty
                    ? ""
                    : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                        .parse(rowMap[StringConfig.csv.updatedTimestamp])
                        .toIso8601String(),
            mqsSubscriptionActivationTimestamp:
                rowMap[StringConfig.csv.subscriptionActivationTimestamp]
                        .toString()
                        .isEmpty
                    ? ""
                    : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                        .parse(rowMap[
                            StringConfig.csv.subscriptionActivationTimestamp])
                        .toIso8601String(),
            mqsSubscriptionRenewalTimestamp: rowMap[
                        StringConfig.csv.subscriptionRenewalTimestamp]
                    .toString()
                    .isEmpty
                ? ""
                : DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .parse(
                        rowMap[StringConfig.csv.subscriptionRenewalTimestamp])
                    .toIso8601String(),
          );

          await UserRepository.i.addUserSubRec(
              userSubscriptionReceiptModel: userSubscriptionReceipt,
              customId: docRef);
        }
      }
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    }
  }

  exportUserSubRec() async {
    try {
      List<List<String>> rows = [
        [
          StringConfig.reporting.firebaseUserId,
          StringConfig.reporting.mongoDbUserId,
          StringConfig.reporting.appSpecificSharedSecret,
          StringConfig.reporting.localVerificationData,
          StringConfig.reporting.packageName,
          StringConfig.reporting.purchaseId,
          StringConfig.reporting.serverVerificationData,
          StringConfig.reporting.source,
          StringConfig.reporting.subscriptionActivePlan,
          StringConfig.reporting.subscriptionPlatform,
          StringConfig.reporting.transactionId,
          StringConfig.reporting.subscriptionStatus,
          StringConfig.csv.createdTimestamp,
          StringConfig.csv.updatedTimestamp,
          StringConfig.csv.subscriptionActivationTimestamp,
          StringConfig.csv.subscriptionRenewalTimestamp,
          StringConfig.dashboard.expiryDate,
        ],
        ...searchedUserSubRec.map((model) {
          return [
            model.mqsFirebaseUserID ?? "",
            model.mqsMONGODBUserID ?? "",
            model.mqsAppSpecificSharedSecret ?? "",
            model.mqsLocalVerificationData ?? "",
            model.mqsPackageName ?? "",
            model.mqsPurchaseID ?? "",
            model.mqsServerVerificationData ?? "",
            model.mqsSource ?? "",
            model.mqsSubscriptionActivePlan ?? "",
            model.mqsSubscriptionPlatform ?? "",
            model.mqsTransactionID ?? "",
            model.mqsSubscriptionStatus ?? "",
            (model.mqsCreatedTimestamp ?? "").isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .format(DateTime.parse(model.mqsCreatedTimestamp ?? ""))
                : "",
            (model.mqsUpdatedTimestamp ?? "").isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .format(DateTime.parse(model.mqsUpdatedTimestamp ?? ""))
                : "",
            (model.mqsSubscriptionActivationTimestamp ?? "").isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(
                        model.mqsSubscriptionActivationTimestamp ?? ""))
                : "",
            (model.mqsSubscriptionRenewalTimestamp ?? "").isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(model.mqsSubscriptionRenewalTimestamp ?? ""))
                : "",
            (model.mqsSubscriptionExpiryTimestamp ?? "").isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(
                    DateTime.parse(model.mqsSubscriptionExpiryTimestamp ?? ""))
                : "",
          ];
        }),
      ];
      String csvData = const ListToCsvConverter().convert(rows);
      Uint8List bytes = Uint8List.fromList(utf8.encode(csvData));
      await FileSaver.instance.saveFile(
        bytes: bytes,
        ext: "csv",
        mimeType: MimeType.csv,
        name: StringConfig.database.subscriptionReceiptInformation,
      );
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }
}
