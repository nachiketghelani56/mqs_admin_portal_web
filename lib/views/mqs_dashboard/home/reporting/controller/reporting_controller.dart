import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/chart_model.dart';
import 'package:mqs_admin_portal_web/models/circle_model.dart';
import 'package:mqs_admin_portal_web/models/user_iam_model.dart';
import 'package:mqs_admin_portal_web/models/user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class ReportingController extends GetxController {
  RxList<String> options = [
    StringConfig.reporting.entity,
    StringConfig.reporting.unit,
    StringConfig.reporting.function,
  ].obs;
  Map<String, Color> barChartOpts = {
    StringConfig.reporting.leadership: ColorConfig.bullet1Color,
    StringConfig.reporting.management: ColorConfig.bullet2Color,
    StringConfig.reporting.team: ColorConfig.bullet3Color,
    StringConfig.reporting.employees: ColorConfig.bullet4Color,
  };
  Map<String, Map<Color, RxInt>> get circleChartOpts => {
        StringConfig.reporting.completed: {
          ColorConfig.card3TextColor: completedOBUsers
        },
        StringConfig.reporting.partialCompletion: {
          ColorConfig.card2TextColor: partialCompletedOBUsers
        },
        StringConfig.reporting.skipped: {
          ColorConfig.card1TextColor: skippedOBUsers
        },
      };
  RxInt optionIndex = 0.obs;
  RxList<ChartModel> indicatorCharData = [
    ChartModel(StringConfig.reporting.advocacy, 6),
    ChartModel(StringConfig.reporting.awareness, 9),
    ChartModel(StringConfig.reporting.acceptance, 3),
    ChartModel(StringConfig.reporting.aptitude, 4),
    ChartModel(StringConfig.reporting.adoption, 8)
  ].obs;
  RxList<String> filterOpts = [
    StringConfig.reporting.lastDay,
    StringConfig.reporting.lastWeek,
    StringConfig.reporting.lastMonth,
    StringConfig.reporting.customRange,
  ].obs;
  RxString circleFilter = ''.obs, authFilter = ''.obs;
  RxInt totalRegisteredUsers = 0.obs,
      activeUsers = 0.obs,
      inactiveUsers = 0.obs,
      totalCircles = 0.obs,
      featuredCircles = 0.obs,
      flaggedCircles = 0.obs,
      completedOBUsers = 0.obs,
      partialCompletedOBUsers = 0.obs,
      skippedOBUsers = 0.obs,
      activeSubscriptions = 0.obs,
      purchasedSubscription = 0.obs;
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxDouble completedOB = 0.0.obs,
      partialCompletedOB = 0.0.obs,
      skippedOB = 0.0.obs;
  StreamSubscription<List<UserIAMModel>>? userStream;
  StreamSubscription<List<CircleModel>>? circleStream;
  StreamSubscription<List<UserSubscriptionReceiptModel>>?
      userSubscriptionReceiptStream;

  @override
  onInit() {
    getAuthAndOBSummary();
    getCircleSummary();
    getSubscriptionSummary();
    super.onInit();
  }

  @override
  void onClose() async {
    await userStream?.cancel();
    await circleStream?.cancel();
    await userSubscriptionReceiptStream?.cancel();
    super.onClose();
  }

  getAuthAndOBSummary() async {
    try {
      List<UserIAMModel> users = await FirebaseStorageService.i.getUsers();
      totalRegisteredUsers.value = users.length;
      activeUsers.value = users.where((e) => e.mqsIsUserActive).length;
      inactiveUsers.value = users.where((e) => !e.mqsIsUserActive).length;
      getOBSummary(users: users);
      userStream = FirebaseStorageService.i.getUserStream().listen((data) {
        totalRegisteredUsers.value = data.length;
        activeUsers.value = data.where((e) => e.mqsIsUserActive).length;
        inactiveUsers.value = data.where((e) => !e.mqsIsUserActive).length;
        getOBSummary(users: data);
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  filterAuth() async {
    try {
      List<UserIAMModel> users = await FirebaseStorageService.i.getUsers();
      if (authFilter.value == StringConfig.reporting.lastDay) {
        DateTime lastDay = DateTime.now().subtract(const Duration(days: 1));
        totalRegisteredUsers.value = users.where((e) {
          DateTime createdTime = DateTime.parse(e.mqsCreatedTimestamp);
          return createdTime.day == lastDay.day &&
              createdTime.month == lastDay.month &&
              createdTime.year == lastDay.year;
        }).length;
      } else if (authFilter.value == StringConfig.reporting.lastWeek) {
        DateTime lastWeek = DateTime.now().subtract(const Duration(days: 7));
        DateTime start =
            lastWeek.subtract(Duration(days: DateTime.now().weekday - 1));
        DateTime startDate = DateTime(start.year, start.month, start.day);
        DateTime end = lastWeek
            .add(Duration(days: DateTime.daysPerWeek - lastWeek.weekday));
        DateTime endDate = DateTime(end.year, end.month, end.day, 24);
        totalRegisteredUsers.value = users.where((e) {
          DateTime createdTime = DateTime.parse(e.mqsCreatedTimestamp);
          return createdTime.isAfter(startDate) &&
              createdTime.isBefore(endDate);
        }).length;
      } else if (authFilter.value == StringConfig.reporting.lastMonth) {
        DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));
        totalRegisteredUsers.value = users.where((e) {
          DateTime createdTime = DateTime.parse(e.mqsCreatedTimestamp);
          return createdTime.month == lastMonth.month &&
              createdTime.year == lastMonth.year;
        }).length;
      } else {
        DateTime start =
            DateFormat('dd/MM/yyyy').parse(startDateController.text);
        DateTime endDate =
            DateFormat('dd/MM/yyyy').parse(endDateController.text);
        DateTime end = DateTime(endDate.year, endDate.month, endDate.day, 24);
        totalRegisteredUsers.value = users.where((e) {
          DateTime createdTime = DateTime.parse(e.mqsCreatedTimestamp);
          return createdTime.isAfter(start) && createdTime.isBefore(end);
        }).length;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  exportAuthSummary() async {
    try {
      List<UserIAMModel> users = await FirebaseStorageService.i.getUsers();
      String currentDate =
          DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(DateTime(0));
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
        name: StringConfig.reporting.authSummary,
      );
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getCircleSummary() async {
    try {
      List<CircleModel> circles = await FirebaseStorageService.i.getCircles();
      setCircle(circles);
      circleStream = FirebaseStorageService.i.getCircleStream().listen((data) {
        setCircle(data);
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  setCircle(List<CircleModel> circles) {
    totalCircles.value = circles.length;
    featuredCircles.value =
        circles.where((element) => element.userIsGuide == true).toList().length;
    flaggedCircles.value =
        circles.where((element) => element.isFlag == true).toList().length;
  }

  filterCircle() async {
    try {
      List<CircleModel> circles = await FirebaseStorageService.i.getCircles();
      if (circleFilter.value == StringConfig.reporting.lastDay) {
        DateTime lastDay = DateTime.now().subtract(const Duration(days: 1));
        totalCircles.value = circles.where((e) {
          DateTime postTime =
              DateTime.parse(e.postTime ?? DateTime.now().toIso8601String());
          return postTime.day == lastDay.day &&
              postTime.month == lastDay.month &&
              postTime.year == lastDay.year;
        }).length;
        featuredCircles.value = circles.where((e) {
          DateTime postTime =
              DateTime.parse(e.postTime ?? DateTime.now().toIso8601String());
          return e.userIsGuide == true &&
              postTime.day == lastDay.day &&
              postTime.month == lastDay.month &&
              postTime.year == lastDay.year;
        }).length;
        flaggedCircles.value = circles.where((e) {
          DateTime postTime =
              DateTime.parse(e.postTime ?? DateTime.now().toIso8601String());
          return e.isFlag == true &&
              postTime.day == lastDay.day &&
              postTime.month == lastDay.month &&
              postTime.year == lastDay.year;
        }).length;
      } else if (circleFilter.value == StringConfig.reporting.lastWeek) {
        DateTime lastWeek = DateTime.now().subtract(const Duration(days: 7));
        DateTime start =
            lastWeek.subtract(Duration(days: DateTime.now().weekday - 1));
        DateTime startDate = DateTime(start.year, start.month, start.day);
        DateTime end = lastWeek
            .add(Duration(days: DateTime.daysPerWeek - lastWeek.weekday));
        DateTime endDate = DateTime(end.year, end.month, end.day, 24);
        totalCircles.value = circles.where((e) {
          DateTime postTime =
              DateTime.parse(e.postTime ?? DateTime.now().toIso8601String());
          return postTime.isAfter(startDate) && postTime.isBefore(endDate);
        }).length;
        featuredCircles.value = circles.where((e) {
          DateTime postTime =
              DateTime.parse(e.postTime ?? DateTime.now().toIso8601String());
          return e.userIsGuide == true &&
              postTime.isAfter(startDate) &&
              postTime.isBefore(endDate);
        }).length;
        flaggedCircles.value = circles.where((e) {
          DateTime postTime =
              DateTime.parse(e.postTime ?? DateTime.now().toIso8601String());
          return e.isFlag == true &&
              postTime.isAfter(startDate) &&
              postTime.isBefore(endDate);
        }).length;
      } else if (circleFilter.value == StringConfig.reporting.lastMonth) {
        DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));
        totalCircles.value = circles.where((e) {
          DateTime postTime =
              DateTime.parse(e.postTime ?? DateTime.now().toIso8601String());
          return postTime.month == lastMonth.month &&
              postTime.year == lastMonth.year;
        }).length;
        featuredCircles.value = circles.where((e) {
          DateTime postTime =
              DateTime.parse(e.postTime ?? DateTime.now().toIso8601String());
          return e.userIsGuide == true &&
              postTime.month == lastMonth.month &&
              postTime.year == lastMonth.year;
        }).length;
        flaggedCircles.value = circles.where((e) {
          DateTime postTime =
              DateTime.parse(e.postTime ?? DateTime.now().toIso8601String());
          return e.isFlag == true &&
              postTime.month == lastMonth.month &&
              postTime.year == lastMonth.year;
        }).length;
      } else {
        DateTime start =
            DateFormat('dd/MM/yyyy').parse(startDateController.text);
        DateTime endDate =
            DateFormat('dd/MM/yyyy').parse(endDateController.text);
        DateTime end = DateTime(endDate.year, endDate.month, endDate.day, 24);
        totalCircles.value = circles.where((e) {
          DateTime postTime =
              DateTime.parse(e.postTime ?? DateTime.now().toIso8601String());
          return postTime.isAfter(start) && postTime.isBefore(end);
        }).length;
        featuredCircles.value = circles.where((e) {
          DateTime postTime =
              DateTime.parse(e.postTime ?? DateTime.now().toIso8601String());
          return e.userIsGuide == true &&
              postTime.isAfter(start) &&
              postTime.isBefore(end);
        }).length;
        flaggedCircles.value = circles.where((e) {
          DateTime postTime =
              DateTime.parse(e.postTime ?? DateTime.now().toIso8601String());
          return e.isFlag == true &&
              postTime.isAfter(start) &&
              postTime.isBefore(end);
        }).length;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  exportCircleSummary() async {
    try {
      List<CircleModel> circles = await FirebaseStorageService.i.getCircles();
      String currentDate =
          DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(DateTime(0));
      List<List<String>> rows = [
        ...circles.map((model) {
          return [
            model.userName ?? "",
            model.postTitle ?? "",
            model.postContent ?? "",
            (model.postTime ?? "").isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .format(DateTime.parse(model.postTime ?? ""))
                : "",
            "${model.postView ?? 0}",
            "${model.userIsGuide}",
            "${model.isMainPost}",
            "${model.isFlag}",
            model.flagName ?? "",
            "${model.postReply?.length ?? 0}",
            model.hashtag?.join(", ") ?? "",
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
          StringConfig.dashboard.fullName,
          StringConfig.reporting.postTitle,
          StringConfig.reporting.postContent,
          StringConfig.reporting.postTime,
          StringConfig.reporting.postViews,
          StringConfig.reporting.userIsGuide,
          StringConfig.reporting.isMainPost,
          StringConfig.reporting.isFlag,
          StringConfig.reporting.flagName,
          StringConfig.reporting.postReplies,
          StringConfig.reporting.hashTags,
        ],
      );
      String csvData = const ListToCsvConverter().convert(rows);
      Uint8List bytes = Uint8List.fromList(utf8.encode(csvData));
      await FileSaver.instance.saveFile(
        bytes: bytes,
        ext: "csv",
        mimeType: MimeType.csv,
        name: StringConfig.reporting.circleSummary,
      );
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getOBSummary({required List<UserIAMModel> users}) async {
    try {
      completedOBUsers.value = users
          .where((e) =>
              e.onboardingModel.checkInValue.isNotEmpty &&
              e.onboardingModel.demoGraphicValue.isNotEmpty &&
              e.onboardingModel.scenesValue.isNotEmpty)
          .toList()
          .length;
      skippedOBUsers.value = users
          .where((e) =>
              e.onboardingModel.checkInValue.isEmpty &&
              e.onboardingModel.demoGraphicValue.isEmpty &&
              e.onboardingModel.scenesValue.isEmpty)
          .toList()
          .length;
      partialCompletedOBUsers.value =
          users.length - (completedOBUsers.value + skippedOBUsers.value);
      completedOB.value = completedOBUsers.value / users.length;
      skippedOB.value = skippedOBUsers.value / users.length;
      partialCompletedOB.value = partialCompletedOBUsers.value / users.length;
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getSubscriptionSummary() async {
    try {
      List<UserSubscriptionReceiptModel> receipt =
          await FirebaseStorageService.i.getUserSubscriptionReceipt();
      activeSubscriptions.value = receipt
          .where((e) =>
              e.mqsUserSubscriptionStatus == StringConfig.reporting.active)
          .length;
      purchasedSubscription.value =
          receipt.where((e) => e.mqsPurchaseID.isNotEmpty).length;
      userSubscriptionReceiptStream = FirebaseStorageService.i
          .getUserSubscriptionReceiptStream()
          .listen((data) {
        activeSubscriptions.value = data
            .where((e) =>
                e.mqsUserSubscriptionStatus == StringConfig.reporting.active)
            .length;
        purchasedSubscription.value =
            data.where((e) => e.mqsPurchaseID.isNotEmpty).length;
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  exportSubscriptionSummary() async {
    try {
      List<UserSubscriptionReceiptModel> receipt =
          await FirebaseStorageService.i.getUserSubscriptionReceipt();
      List<List<String>> rows = [
        [
          StringConfig.reporting.firebaseUserId,
          StringConfig.reporting.mongoDbUserId,
          StringConfig.reporting.appSpecificSharedSecret,
          StringConfig.reporting.expiryDate,
          StringConfig.reporting.localVerificationData,
          StringConfig.reporting.packageName,
          StringConfig.reporting.purchaseId,
          StringConfig.reporting.serverVerificationData,
          StringConfig.reporting.source,
          StringConfig.reporting.subscriptionActivePlan,
          StringConfig.reporting.subscriptionPlatform,
          StringConfig.reporting.transactionId,
          StringConfig.reporting.subscriptionStatus,
        ],
        ...receipt.map((model) {
          return [
            model.isFirebaseUserID,
            model.isMONGODBUserID,
            model.mqsAppSpecificSharedSecret,
            model.mqsExpiryDate.isNotEmpty
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .format(DateTime.parse(model.mqsExpiryDate))
                : "",
            model.mqsLocalVerificationData,
            model.mqsPackageName,
            model.mqsPurchaseID,
            model.mqsServerVerificationData,
            model.mqsSource,
            model.mqsSubscriptionActivePlan,
            model.mqsSubscriptionPlatform,
            model.mqsTransactionID,
            model.mqsUserSubscriptionStatus,
          ];
        }),
      ];
      String csvData = const ListToCsvConverter().convert(rows);
      Uint8List bytes = Uint8List.fromList(utf8.encode(csvData));
      await FileSaver.instance.saveFile(
        bytes: bytes,
        ext: "csv",
        mimeType: MimeType.csv,
        name: StringConfig.reporting.subscriptionSummary,
      );
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }
}
