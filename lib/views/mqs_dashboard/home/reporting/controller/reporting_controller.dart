import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/circle_model.dart';
import 'package:mqs_admin_portal_web/models/enterprise_model.dart';
import 'package:mqs_admin_portal_web/models/reporting_chart_model.dart';
import 'package:mqs_admin_portal_web/models/user_iam_model.dart';
import 'package:mqs_admin_portal_web/models/user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/views/circle/repository/circle_repository.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/enterprise_repository.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/user_repository.dart';
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
  RxList<String> filterOpts = [
    StringConfig.reporting.lastDay,
    StringConfig.reporting.lastWeek,
    StringConfig.reporting.lastMonth,
    StringConfig.reporting.customRange,
  ].obs;
  RxString circleFilter = ''.obs, authFilter = ''.obs, obFilter = ''.obs;
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
  Map<String, Color> totalReport = {
    StringConfig.dashboard.enterprise: ColorConfig.secondaryColor,
    StringConfig.dashboard.users: ColorConfig.bullet6Color,
    StringConfig.dashboard.circle: ColorConfig.dividerColor,
    StringConfig.dashboard.userSubscription: ColorConfig.card1TextColor,
  };
  RxString authtype = StringConfig.reporting.totalRegisteredUsers.obs;

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

  Future<List<ReportingChartModel>> getOverAllData() async {
    try {
      List<UserIAMModel> users = await UserRepository.i.getUsers();
      List<EnterpriseModel> enterpriseList =
          await EnterpriseRepository.i.getEnterprises();
      List<CircleModel> circleList = await CircleRepository.i.getCircles();

      List totalStatus =
          users.where((e) => e.mqsUserSubscriptionStatus == "Active").toList();
      int totalSubscriptionActivePlan = totalStatus.length;
      int totalUsers = users.length;

      int totalEnterpriseUsers = enterpriseList.length;

      int totalCircles = circleList.length;
      return [
        ReportingChartModel(
            label: StringConfig.dashboard.enterprise,
            value: totalEnterpriseUsers),
        ReportingChartModel(
            label: StringConfig.dashboard.users, value: totalUsers),
        ReportingChartModel(
            label: StringConfig.dashboard.circle, value: totalCircles),
        ReportingChartModel(
            label: StringConfig.dashboard.userSubscription,
            value: totalSubscriptionActivePlan),
      ];
    } catch (e) {
      errorDialogWidget(msg: e.toString());
      return [];
    } finally {}
  }

  getAuthAndOBSummary() async {
    try {
      startDateController.clear();
      endDateController.clear();
      final DashboardController dashboardController = Get.find();
      List<UserIAMModel> users = await UserRepository.i.getUsers();
      dashboardController.searchedUsers.value = users;
      if (authtype.value == StringConfig.reporting.activeUsers) {
        dashboardController.searchedUsers.value =
            users.where((e) => e.mqsIsUserActive).toList();
      } else if (authtype.value == StringConfig.reporting.inactiveUsers) {
        dashboardController.searchedUsers.value =
            users.where((e) => !e.mqsIsUserActive).toList();
      }
      totalRegisteredUsers.value = users.length;
      activeUsers.value = users.where((e) => e.mqsIsUserActive).length;
      inactiveUsers.value = users.where((e) => !e.mqsIsUserActive).length;
      getOBSummary(users: users);
      userStream = UserRepository.i.getUserStream().listen((data) {
        authFilter.value = '';
        totalRegisteredUsers.value = data.length;
        activeUsers.value = data.where((e) => e.mqsIsUserActive).length;
        inactiveUsers.value = data.where((e) => !e.mqsIsUserActive).length;
        getOBSummary(users: data);
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  filterAuth({String? type}) async {
    try {
      if (type != null) {
        authtype.value = type;
      }
      final DashboardController dashboardController = Get.find();
      List<UserIAMModel> users = await UserRepository.i.getUsers();
      if (authFilter.value == StringConfig.reporting.lastDay) {
        DateTime lastDay = DateTime.now().subtract(const Duration(days: 1));
        users = users.where((e) {
          DateTime createdTime = DateTime.parse(e.mqsCreatedTimestamp);
          return createdTime.day == lastDay.day &&
              createdTime.month == lastDay.month &&
              createdTime.year == lastDay.year;
        }).toList();
      } else if (authFilter.value == StringConfig.reporting.lastWeek) {
        DateTime lastWeek = DateTime.now().subtract(const Duration(days: 7));
        DateTime start =
            lastWeek.subtract(Duration(days: DateTime.now().weekday - 1));
        DateTime startDate = DateTime(start.year, start.month, start.day);
        DateTime end = lastWeek
            .add(Duration(days: DateTime.daysPerWeek - lastWeek.weekday));
        DateTime endDate = DateTime(end.year, end.month, end.day, 24);
        users = users.where((e) {
          DateTime createdTime = DateTime.parse(e.mqsCreatedTimestamp);
          return createdTime.isAfter(startDate) &&
              createdTime.isBefore(endDate);
        }).toList();
      } else if (authFilter.value == StringConfig.reporting.lastMonth) {
        DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));
        users = users.where((e) {
          DateTime createdTime = DateTime.parse(e.mqsCreatedTimestamp);
          return createdTime.month == lastMonth.month &&
              createdTime.year == lastMonth.year;
        }).toList();
      } else if (startDateController.text.isNotEmpty &&
          endDateController.text.isNotEmpty) {
        DateTime start =
            DateFormat('dd/MM/yyyy').parse(startDateController.text);
        DateTime endDate =
            DateFormat('dd/MM/yyyy').parse(endDateController.text);
        DateTime end = DateTime(endDate.year, endDate.month, endDate.day, 24);
        users = users.where((e) {
          DateTime createdTime = DateTime.parse(e.mqsCreatedTimestamp);
          return createdTime.isAfter(start) && createdTime.isBefore(end);
        }).toList();
      }
      totalRegisteredUsers.value = users.length;
      activeUsers.value = users.where((e) => e.mqsIsUserActive).length;
      inactiveUsers.value = users.where((e) => !e.mqsIsUserActive).length;
      dashboardController.reset();
      dashboardController.searchedUsers.value = users;
      if (authtype.value == StringConfig.reporting.activeUsers) {
        dashboardController.searchedUsers.value =
            users.where((e) => e.mqsIsUserActive).toList();
      } else if (authtype.value == StringConfig.reporting.inactiveUsers) {
        dashboardController.searchedUsers.value =
            users.where((e) => !e.mqsIsUserActive).toList();
      }
      if (dashboardController.searchedUsers.isEmpty) {
        dashboardController.viewIndex.value = -1;
      } else {
        dashboardController.viewIndex.value = 0;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  filterOnboarding() async {}

  exportAuthSummary() async {
    try {
      List<UserIAMModel> users = await UserRepository.i.getUsers();
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
      List<CircleModel> circles = await CircleRepository.i.getCircles();
      setCircle(circles);
      circleStream = CircleRepository.i.getCircleStream().listen((data) {
        circleFilter.value = '';
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
      List<CircleModel> circles = await CircleRepository.i.getCircles();
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
      List<CircleModel> circles = await CircleRepository.i.getCircles();
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
      skippedOBUsers.value =
          users.where((e) => e.mqsSkipOnboarding).toList().length;
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
          await UserRepository.i.getUserSubscriptionReceipt();
      activeSubscriptions.value = receipt
          .where((e) =>
              e.mqsUserSubscriptionStatus == StringConfig.reporting.active)
          .length;
      purchasedSubscription.value =
          receipt.where((e) => e.mqsPurchaseID.isNotEmpty).length;
      userSubscriptionReceiptStream =
          UserRepository.i.getUserSubscriptionReceiptStream().listen((data) {
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
          await UserRepository.i.getUserSubscriptionReceipt();
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

  Future<String> pickDate({required BuildContext context}) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(0),
      lastDate: DateTime(3000),
      initialDate: DateTime.now(),
    );
    if (date != null) {
      return DateFormat('dd/MM/yyyy').format(date);
    }
    return "";
  }
}
