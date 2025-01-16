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
import 'package:mqs_admin_portal_web/models/line_chart_model.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_user_iam_model.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/models/reporting_chart_model.dart';
import 'package:mqs_admin_portal_web/views/circle/controller/circle_controller.dart';
import 'package:mqs_admin_portal_web/views/circle/repository/circle_repository.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/enterprise_repository.dart';
import 'package:mqs_admin_portal_web/views/dashboard/repository/user_IAM_repository.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class ReportingController extends GetxController {
  final GlobalKey<ScaffoldState> circleKey = GlobalKey();
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
    StringConfig.reporting.today,
    StringConfig.reporting.lastDay,
    StringConfig.reporting.lastWeek,
    StringConfig.reporting.lastMonth,
    StringConfig.reporting.customRange,
  ].obs;
  RxList<String> chartOpts = [
    StringConfig.reporting.year,
    StringConfig.reporting.month,
    StringConfig.reporting.week,
    StringConfig.reporting.day,
  ].obs;
  RxString circleFilter = ''.obs,
      circleFilterType = ''.obs,
      authFilter = ''.obs,
      obFilter = ''.obs,
      subscriptionFilter = ''.obs,
      subscriptionFilterType = ''.obs,
      detailFilter = ''.obs,
      reportType = ''.obs;
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
  final TextEditingController startSubscriptionTypeDateController =
      TextEditingController();
  final TextEditingController endSubscriptionTypeDateController =
      TextEditingController();
  final TextEditingController startCircleDateController =
      TextEditingController();
  final TextEditingController endCircleDateController = TextEditingController();
  final TextEditingController startCircleTypeDateController =
      TextEditingController();
  final TextEditingController endCircleTypeDateController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxDouble completedOB = 0.0.obs,
      partialCompletedOB = 0.0.obs,
      skippedOB = 0.0.obs;
  StreamSubscription<List<MQSMyQUserIamModel>>? userStream;
  StreamSubscription<List<CircleModel>>? circleStream;
  StreamSubscription<List<MQSMyQUserSubscriptionReceiptModel>>?
      userSubscriptionReceiptStream;
  Map<String, Color> totalReport = {
    StringConfig.dashboard.enterprise: ColorConfig.secondaryColor,
    StringConfig.dashboard.users: ColorConfig.bullet6Color,
    StringConfig.dashboard.circle: ColorConfig.dividerColor,
    StringConfig.dashboard.userSubscription: ColorConfig.card1TextColor,
  };
  RxString authtype = StringConfig.reporting.totalRegisteredUsers.obs;
  RxString obtype = StringConfig.reporting.completed.obs;
  RxString circleType = StringConfig.reporting.totalCircles.obs;
  RxString subscriptionType = StringConfig.reporting.activeSubscription.obs;
  final CircleController _circleController = Get.put(CircleController());
  final DashboardController _dashboardController =
      Get.put(DashboardController());
  Map<String, Color> get singUpChartOpts => {
        StringConfig.reporting.userRegistered: ColorConfig.secondaryColor,
        StringConfig.reporting.onboradingCompleted: ColorConfig.bullet6Color,
        StringConfig.reporting.subscribed: ColorConfig.dividerColor,
        StringConfig.reporting.notSubscribed: ColorConfig.bullet2Color,
        StringConfig.reporting.subscriptionExpired: ColorConfig.chartColor,
        StringConfig.reporting.cancelled: ColorConfig.card1TextColor,
      };
  RxList<LineChartModel> signUpChartData = <LineChartModel>[].obs;
  RxString signUpChartFilter = StringConfig.reporting.month.obs;

  @override
  onInit() {
    getAuthAndOBSummary(isOB: true);
    getCircleSummary();
    getSubscriptionSummary();
    getMonthWiseSignUpChart();
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
      List<MQSMyQUserIamModel> users = await UserRepository.i.getUsers();
      List<MQSMyQUserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();

      List<EnterpriseModel> enterpriseList =
          await EnterpriseRepository.i.getEnterprises();
      List<CircleModel> circleList = await CircleRepository.i.getCircles();
      List<MQSMyQUserSubscriptionReceiptModel> activeRec = receipt
          .where((e) =>
              e.mqsSubscriptionStatus == StringConfig.reporting.active)
          .toList();

      List totalStatus = users.where((localItem) {
        return activeRec.any((firebaseItem) =>
            firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
      }).toList();
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

  getAuthAndOBSummary({bool isOB = false}) async {
    try {
      startDateController.clear();
      endDateController.clear();
      final DashboardController dashboardController = Get.find();
      List<MQSMyQUserIamModel> users = await UserRepository.i.getUsers();
      if (reportType.value == StringConfig.reporting.totalRegisteredUsers) {
        dashboardController.searchedUsers.value = users;
      } else if (reportType.value == StringConfig.reporting.activeUsers) {
        dashboardController.searchedUsers.value = users
            .where((e) =>
                (e.mqsUserActiveTimestamp?.isNotEmpty ?? false) &&
                DateTime.now()
                        .difference(DateTime.parse(e?.mqsUserActiveTimestamp ?? ""))
                        .inDays <
                    SizeConfig.size7)
            .toList();
      } else if (reportType.value == StringConfig.reporting.inactiveUsers) {
        dashboardController.searchedUsers.value = users
            .where((e) =>
                e.mqsUserActiveTimestamp?.isEmpty ?? false ||
                ((e.mqsUserActiveTimestamp?.isNotEmpty ?? false) &&
                    DateTime.now()
                            .difference(
                                DateTime.parse(e.mqsUserActiveTimestamp ?? ""))
                            .inDays >
                        SizeConfig.size7))
            .toList();
      } else if (reportType.value == StringConfig.reporting.completed) {
        dashboardController.searchedUsers.value = users
            .where((e) =>e.mqsOnboardingDetails?.mqsOBDone ==true)
            .toList();
      } else if (reportType.value == StringConfig.reporting.skipped) {
        dashboardController.searchedUsers.value =
            users.where((e) => e.mqsOnboardingDetails?.mqsOBSkip ==true).toList();
      } else if (reportType.value == StringConfig.reporting.partialCompletion) {

        dashboardController.searchedUsers.value = users
            .where((e) => e.mqsOnboardingDetails?.mqsOBStart == true && e.mqsOnboardingDetails?.mqsOBDone == false)
            .toList();
      }
      dashboardController.searchUserType.value = users;
      totalRegisteredUsers.value = users.length;
      activeUsers.value = users
          .where((e) =>
             ( e.mqsUserActiveTimestamp?.isNotEmpty  ?? false)&&
              DateTime.now()
                      .difference(DateTime.parse(e.mqsUserActiveTimestamp ?? ""))
                      .inDays <
                  SizeConfig.size7)
          .length;
      inactiveUsers.value = users
          .where((e) =>
              (e.mqsUserActiveTimestamp?.isEmpty  ?? false) ||
              ((e.mqsUserActiveTimestamp?.isNotEmpty   ?? false)&&
                  DateTime.now()
                          .difference(DateTime.parse(e.mqsUserActiveTimestamp??""))
                          .inDays >
                      SizeConfig.size7))
          .length;
      if (isOB) {
        getOBSummary(users: users);
      }
      userStream = UserRepository.i.getUserStream().listen((data) {
        authFilter.value = '';
        totalRegisteredUsers.value = data.length;
        activeUsers.value = data
            .where((e) =>
                (e.mqsUserActiveTimestamp?.isNotEmpty  ?? false) &&
                DateTime.now()
                        .difference(DateTime.parse(e.mqsUserActiveTimestamp ?? ""))
                        .inDays <
                    SizeConfig.size7)
            .length;
        inactiveUsers.value = data
            .where((e) =>
                (e.mqsUserActiveTimestamp?.isEmpty   ?? false )||
                ((e.mqsUserActiveTimestamp?.isNotEmpty  ?? false) &&
                    DateTime.now()
                            .difference(
                                DateTime.parse(e.mqsUserActiveTimestamp ??""))
                            .inDays >
                        SizeConfig.size7))
            .length;
        if (isOB) {
          obFilter.value = '';
          getOBSummary(users: data);
        }
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  filterAuth(
      {String? type,
      bool isDetailView = false,
      required String filterType}) async {
    try {
      if (type != null) {
        authtype.value = type;
      }
      final DashboardController dashboardController = Get.find();
      List<MQSMyQUserIamModel> users = isDetailView
          ? dashboardController.users
          : await UserRepository.i.getUsers();
      if (filterType == StringConfig.reporting.today) {
        DateTime today = DateTime.now();
        users = users.where((e) {
          DateTime createdTime = DateTime.parse((e.mqsCreatedTimestamp?.isNotEmpty   ?? false)
              ? e.mqsCreatedTimestamp ??""
              : (e.mqsEnterpriseCreatedTimestamp?.isNotEmpty  ?? false)
                  ? e.mqsEnterpriseCreatedTimestamp ?? ""
                  : DateTime.now().toIso8601String());
          return createdTime.day == today.day &&
              createdTime.month == today.month &&
              createdTime.year == today.year;
        }).toList();
      } else if (filterType == StringConfig.reporting.lastDay) {
        DateTime lastDay = DateTime.now().subtract(const Duration(days: 1));
        users = users.where((e) {
          DateTime createdTime = DateTime.parse((e.mqsCreatedTimestamp?.isNotEmpty   ?? false)
              ? e.mqsCreatedTimestamp ??""
              :( e.mqsEnterpriseCreatedTimestamp?.isNotEmpty  ?? false)
              ? e.mqsEnterpriseCreatedTimestamp ?? ""
              : DateTime.now().toIso8601String());
          return createdTime.day == lastDay.day &&
              createdTime.month == lastDay.month &&
              createdTime.year == lastDay.year;
        }).toList();
      } else if (filterType == StringConfig.reporting.lastWeek) {
        DateTime lastWeek = DateTime.now().subtract(const Duration(days: 7));
        DateTime start =
            lastWeek.subtract(Duration(days: DateTime.now().weekday - 1));
        DateTime startDate = DateTime(start.year, start.month, start.day);
        DateTime end = lastWeek
            .add(Duration(days: DateTime.daysPerWeek - lastWeek.weekday));
        DateTime endDate = DateTime(end.year, end.month, end.day, 24);
        users = users.where((e) {
          DateTime createdTime = DateTime.parse((e.mqsCreatedTimestamp?.isNotEmpty  ?? false)
              ? e.mqsCreatedTimestamp??""
              : (e.mqsEnterpriseCreatedTimestamp?.isNotEmpty  ?? false)
              ? e.mqsEnterpriseCreatedTimestamp??""
              : DateTime.now().toIso8601String());
          return createdTime.isAfter(startDate) &&
              createdTime.isBefore(endDate);
        }).toList();
      } else if (filterType == StringConfig.reporting.lastMonth) {
        DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));
        users = users.where((e) {
          DateTime createdTime = DateTime.parse((e.mqsCreatedTimestamp?.isNotEmpty  ?? false)
              ? e.mqsCreatedTimestamp ??""
              : (e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsEnterpriseCreatedTimestamp ??""
              : DateTime.now().toIso8601String());
          return createdTime.month == lastMonth.month &&
              createdTime.year == lastMonth.year;
        }).toList();
      } else if (startDateController.text.isNotEmpty &&
          endDateController.text.isNotEmpty &&
          filterType.isNotEmpty) {
        DateTime start =
            DateFormat('dd/MM/yyyy').parse(startDateController.text);
        DateTime endDate =
            DateFormat('dd/MM/yyyy').parse(endDateController.text);
        DateTime end = DateTime(endDate.year, endDate.month, endDate.day, 24);
        users = users.where((e) {
          DateTime createdTime = DateTime.parse((e.mqsCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsCreatedTimestamp??""
              : (e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsEnterpriseCreatedTimestamp ?? ""
              : DateTime.now().toIso8601String());
          return createdTime.isAfter(start) && createdTime.isBefore(end);
        }).toList();
      }
      dashboardController.reset();
      dashboardController.searchedUsers.value = users;
      dashboardController.searchUserType.value = users;
      if (!isDetailView) {
        totalRegisteredUsers.value = users.length;
        activeUsers.value = users
            .where((e) =>
                (e.mqsUserActiveTimestamp?.isNotEmpty ?? false) &&
                DateTime.now()
                        .difference(DateTime.parse(e.mqsUserActiveTimestamp??""))
                        .inDays <
                    SizeConfig.size7)
            .length;
        inactiveUsers.value = users
            .where((e) =>
                (e.mqsUserActiveTimestamp?.isEmpty ?? false) ||
                ((e.mqsUserActiveTimestamp?.isNotEmpty ?? false) &&
                    DateTime.now()
                            .difference(
                                DateTime.parse(e.mqsUserActiveTimestamp??""))
                            .inDays >
                        SizeConfig.size7))
            .length;
        dashboardController.users.value = users;
        if (authtype.value == StringConfig.reporting.activeUsers) {
          dashboardController.searchedUsers.value = users
              .where((e) =>
                  (e.mqsUserActiveTimestamp?.isNotEmpty ?? false) &&
                  DateTime.now()
                          .difference(DateTime.parse(e.mqsUserActiveTimestamp??""))
                          .inDays <
                      SizeConfig.size7)
              .toList();
          dashboardController.users.value = users
              .where((e) =>
                  (e.mqsUserActiveTimestamp?.isNotEmpty ?? false) &&
                  DateTime.now()
                          .difference(DateTime.parse(e.mqsUserActiveTimestamp ??""))
                          .inDays <
                      SizeConfig.size7)
              .toList();
          dashboardController.searchUserType.value = users
              .where((e) =>
                  (e.mqsUserActiveTimestamp?.isNotEmpty  ?? false)&&
                  DateTime.now()
                          .difference(DateTime.parse(e.mqsUserActiveTimestamp ??""))
                          .inDays <
                      SizeConfig.size7)
              .toList();
        } else if (authtype.value == StringConfig.reporting.inactiveUsers) {
          dashboardController.searchedUsers.value = users
              .where((e) =>
                  (e.mqsUserActiveTimestamp?.isEmpty  ?? false)||
                  ((e.mqsUserActiveTimestamp?.isNotEmpty ?? false) &&
                      DateTime.now()
                              .difference(
                                  DateTime.parse(e.mqsUserActiveTimestamp ?? ""))
                              .inDays >
                          SizeConfig.size7))
              .toList();
          dashboardController.users.value = users
              .where((e) =>
                  (e.mqsUserActiveTimestamp?.isEmpty ?? false) ||
                  ((e.mqsUserActiveTimestamp?.isNotEmpty ?? false) &&
                      DateTime.now()
                              .difference(
                                  DateTime.parse(e.mqsUserActiveTimestamp ??""))
                              .inDays >
                          SizeConfig.size7))
              .toList();
          dashboardController.searchUserType.value = users
              .where((e) =>
                  (e.mqsUserActiveTimestamp?.isEmpty ?? false) ||
                  ((e.mqsUserActiveTimestamp?.isNotEmpty ?? false) &&
                      DateTime.now()
                              .difference(
                                  DateTime.parse(e.mqsUserActiveTimestamp??""))
                              .inDays >
                          SizeConfig.size7))
              .toList();
        }
      }
      if (dashboardController.searchedUsers.isEmpty &&
          dashboardController.users.isNotEmpty) {
        dashboardController.viewIndex.value = -1;
      } else {
        dashboardController.viewIndex.value = 0;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  filterOnboarding(
      {String? type,
      bool isDetailView = false,
      required String filterType}) async {
    try {
      if (type != null) {
        obtype.value = type;
      }
      final DashboardController dashboardController = Get.find();
      List<MQSMyQUserIamModel> users = isDetailView
          ? dashboardController.users
          : await UserRepository.i.getUsers();
      if (filterType == StringConfig.reporting.today) {
        DateTime today = DateTime.now();
        users = users.where((e) {
          DateTime createdTime = DateTime.parse((e.mqsCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsCreatedTimestamp ?? ""
              : (e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsEnterpriseCreatedTimestamp??""
              : DateTime.now().toIso8601String());
          return createdTime.day == today.day &&
              createdTime.month == today.month &&
              createdTime.year == today.year;
        }).toList();
      } else if (filterType == StringConfig.reporting.lastDay) {
        DateTime lastDay = DateTime.now().subtract(const Duration(days: 1));
        users = users.where((e) {
          DateTime createdTime = DateTime.parse((e.mqsCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsCreatedTimestamp??""
              : (e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsEnterpriseCreatedTimestamp??""
              : DateTime.now().toIso8601String());
          return createdTime.day == lastDay.day &&
              createdTime.month == lastDay.month &&
              createdTime.year == lastDay.year;
        }).toList();
      } else if (filterType == StringConfig.reporting.lastWeek) {
        DateTime lastWeek = DateTime.now().subtract(const Duration(days: 7));
        DateTime start =
            lastWeek.subtract(Duration(days: DateTime.now().weekday - 1));
        DateTime startDate = DateTime(start.year, start.month, start.day);
        DateTime end = lastWeek
            .add(Duration(days: DateTime.daysPerWeek - lastWeek.weekday));
        DateTime endDate = DateTime(end.year, end.month, end.day, 24);
        users = users.where((e) {
          DateTime createdTime = DateTime.parse((e.mqsCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsCreatedTimestamp ??""
              :( e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsEnterpriseCreatedTimestamp ??""
              : DateTime.now().toIso8601String());
          return createdTime.isAfter(startDate) &&
              createdTime.isBefore(endDate);
        }).toList();
      } else if (filterType == StringConfig.reporting.lastMonth) {
        DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));
        users = users.where((e) {
          DateTime createdTime = DateTime.parse((e.mqsCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsCreatedTimestamp??""
              : (e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsEnterpriseCreatedTimestamp??""
              : DateTime.now().toIso8601String());
          return createdTime.month == lastMonth.month &&
              createdTime.year == lastMonth.year;
        }).toList();
      } else if (startDateController.text.isNotEmpty &&
          endDateController.text.isNotEmpty &&
          filterType.isNotEmpty) {
        DateTime start =
            DateFormat('dd/MM/yyyy').parse(startDateController.text);
        DateTime endDate =
            DateFormat('dd/MM/yyyy').parse(endDateController.text);
        DateTime end = DateTime(endDate.year, endDate.month, endDate.day, 24);
        users = users.where((e) {
          DateTime createdTime = DateTime.parse((e.mqsCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsCreatedTimestamp??""
              : (e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false)
              ? e.mqsEnterpriseCreatedTimestamp ??""
              : DateTime.now().toIso8601String());
          return createdTime.isAfter(start) && createdTime.isBefore(end);
        }).toList();
      }
      dashboardController.reset();
      dashboardController.searchedUsers.value = users
          .where((e) =>
              e.mqsOnboardingDetails?.mqsOBDone == true)
          .toList();
      dashboardController.searchUserType.value = users
          .where((e) =>e.mqsOnboardingDetails?.mqsOBDone == true)
          .toList();
      if (!isDetailView) {
        getOBSummary(users: users);
        dashboardController.users.value = users
            .where((e) =>e.mqsOnboardingDetails?.mqsOBDone == true)
            .toList();

        if (obtype.value == StringConfig.reporting.skipped) {
          dashboardController.searchedUsers.value =
              users.where((e) => e.mqsOnboardingDetails?.mqsOBSkip == true).toList();
          dashboardController.users.value =
              users.where((e) =>e.mqsOnboardingDetails?.mqsOBSkip == true).toList();
          dashboardController.searchUserType.value =
              users.where((e) => e.mqsOnboardingDetails?.mqsOBSkip == true).toList();
        } else if (obtype.value == StringConfig.reporting.partialCompletion) {

          dashboardController.searchedUsers.value = users
              .where((e) => e.mqsOnboardingDetails?.mqsOBStart == true && e.mqsOnboardingDetails?.mqsOBDone == false)
              .toList();
          dashboardController.users.value = users
              .where((e) =>e.mqsOnboardingDetails?.mqsOBStart == true && e.mqsOnboardingDetails?.mqsOBDone == false)
              .toList();
          dashboardController.searchUserType.value = users
              .where((e) => e.mqsOnboardingDetails?.mqsOBStart == true && e.mqsOnboardingDetails?.mqsOBDone == false)
              .toList();
        }
      }
      if (dashboardController.searchedUsers.isEmpty &&
          dashboardController.users.isNotEmpty) {
        dashboardController.viewIndex.value = -1;
      } else {
        dashboardController.viewIndex.value = 0;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  exportAuthSummary() async {
    try {
      List<MQSMyQUserIamModel> users = await UserRepository.i.getUsers();
      String currentDate =
          DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(DateTime(0));
      List<List<String>> rows = [
        ...users.map((model) {
          return [
            model.mqsEmail ?? '',
            model.mqsFirstName ?? '',
            model.mqsLastName ?? '',
            model.mqsCreatedTimestamp?.isNotEmpty ?? false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                    .format(DateTime.parse(model.mqsCreatedTimestamp ?? ""))
                : "",
            "${model.mqsEnterpriseUserFlag}",
            model.mqsUserID ?? '',
            model.mqsMONGODBUserID ?? '',
            // model.mqsSubscriptionActivePlan,
            // model.mqsUserSubscriptionStatus,
            // model.mqsSubscriptionPlatform,
            // model.mqsSubscriptionExpiryDate.isNotEmpty
            //     ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
            //         .format(DateTime.parse(model.mqsSubscriptionExpiryDate))
            //     : "",
            jsonEncode(model.mqsOnboardingDetails?.toJson()),

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
          // StringConfig.reporting.subscriptionActivePlan,
          // StringConfig.reporting.subscriptionStatus,
          // StringConfig.reporting.subscriptionPlatform,
          // StringConfig.reporting.subscriptionExpiryDate,
          StringConfig.dashboard.onboardingDetails,
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
      startCircleDateController.clear();
      endCircleDateController.clear();
      List<CircleModel> circles = await CircleRepository.i.getCircles();
      _circleController.searchedCircle.value = circles;
      _circleController.circle.value = circles;
      _circleController.searchCircleType.value = circles;
      if (circleType.value == StringConfig.reporting.featuredCircles) {
        _circleController.searchedCircle.value =
            circles.where((element) => element.userIsGuide == true).toList();
        _circleController.circle.value =
            circles.where((element) => element.userIsGuide == true).toList();
        _circleController.searchCircleType.value =
            circles.where((element) => element.userIsGuide == true).toList();
      } else if (circleType.value == StringConfig.reporting.flaggedCircles) {
        _circleController.searchedCircle.value =
            circles.where((element) => element.isFlag == true).toList();
        _circleController.circle.value =
            circles.where((element) => element.isFlag == true).toList();
        _circleController.searchCircleType.value =
            circles.where((element) => element.isFlag == true).toList();
      }

      totalCircles.value = circles.length;
      featuredCircles.value =
          circles.where((element) => element.userIsGuide == true).length;
      flaggedCircles.value =
          circles.where((element) => element.isFlag == true).length;

      circleStream = CircleRepository.i.getCircleStream().listen((data) {
        circleFilter.value = '';
        totalCircles.value = data.length;
        featuredCircles.value =
            data.where((element) => element.userIsGuide == true).length;
        flaggedCircles.value =
            data.where((element) => element.isFlag == true).length;
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  filterCircle({String? type}) async {
    try {
      if (type != null) {
        circleType.value = type;
      }

      List<CircleModel> circles = await CircleRepository.i.getCircles();
      if (circleFilter.value == StringConfig.reporting.today) {
        DateTime today = DateTime.now();
        circles = circles.where((e) {
          DateTime postTime = DateTime.parse(e.postTime?.isEmpty ?? false
              ? DateTime.now().toIso8601String()
              : e.postTime ?? DateTime.now().toIso8601String());
          return postTime.day == today.day &&
              postTime.month == today.month &&
              postTime.year == today.year;
        }).toList();
      } else if (circleFilter.value == StringConfig.reporting.lastDay) {
        DateTime lastDay = DateTime.now().subtract(const Duration(days: 1));
        circles = circles.where((e) {
          DateTime postTime = DateTime.parse(e.postTime?.isEmpty ?? false
              ? DateTime.now().toIso8601String()
              : e.postTime ?? DateTime.now().toIso8601String());
          return postTime.day == lastDay.day &&
              postTime.month == lastDay.month &&
              postTime.year == lastDay.year;
        }).toList();
      } else if (circleFilter.value == StringConfig.reporting.lastWeek) {
        DateTime lastWeek = DateTime.now().subtract(const Duration(days: 7));
        DateTime start =
            lastWeek.subtract(Duration(days: DateTime.now().weekday - 1));
        DateTime startDate = DateTime(start.year, start.month, start.day);
        DateTime end = lastWeek
            .add(Duration(days: DateTime.daysPerWeek - lastWeek.weekday));
        DateTime endDate = DateTime(end.year, end.month, end.day, 24);
        circles = circles.where((e) {
          DateTime postTime = DateTime.parse(e.postTime?.isEmpty ?? false
              ? DateTime.now().toIso8601String()
              : e.postTime ?? DateTime.now().toIso8601String());
          return postTime.isAfter(startDate) && postTime.isBefore(endDate);
        }).toList();
      } else if (circleFilter.value == StringConfig.reporting.lastMonth) {
        DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));
        circles = circles.where((e) {
          DateTime postTime = DateTime.parse(e.postTime?.isEmpty ?? false
              ? DateTime.now().toIso8601String()
              : e.postTime ?? DateTime.now().toIso8601String());
          return postTime.month == lastMonth.month &&
              postTime.year == lastMonth.year;
        }).toList();
      } else if (startCircleDateController.text.isNotEmpty &&
          endCircleDateController.text.isNotEmpty) {
        DateTime start =
            DateFormat('dd/MM/yyyy').parse(startCircleDateController.text);
        DateTime endDate =
            DateFormat('dd/MM/yyyy').parse(endCircleDateController.text);
        DateTime end = DateTime(endDate.year, endDate.month, endDate.day, 24);
        circles = circles.where((e) {
          DateTime postTime = DateTime.parse(e.postTime?.isEmpty ?? false
              ? DateTime.now().toIso8601String()
              : e.postTime ?? DateTime.now().toIso8601String());
          return postTime.isAfter(start) && postTime.isBefore(end);
        }).toList();
      }

      totalCircles.value = circles.length;
      featuredCircles.value =
          circles.where((element) => element.userIsGuide == true).length;
      flaggedCircles.value =
          circles.where((element) => element.isFlag == true).length;
      _circleController.reset();
      _circleController.searchedCircle.value = circles;
      _circleController.circle.value = circles;
      _circleController.searchCircleType.value = circles;
      if (circleType.value == StringConfig.reporting.featuredCircles) {
        _circleController.searchedCircle.value =
            circles.where((element) => element.userIsGuide == true).toList();
        _circleController.circle.value =
            circles.where((element) => element.userIsGuide == true).toList();
        _circleController.searchCircleType.value =
            circles.where((element) => element.userIsGuide == true).toList();
      } else if (circleType.value == StringConfig.reporting.flaggedCircles) {
        _circleController.searchedCircle.value =
            circles.where((element) => element.isFlag == true).toList();
        _circleController.circle.value =
            circles.where((element) => element.isFlag == true).toList();
        _circleController.searchCircleType.value =
            circles.where((element) => element.isFlag == true).toList();
      }
      if (_circleController.searchedCircle.isEmpty &&
          _circleController.circle.isEmpty) {
        _circleController.viewIndex.value = -1;
      } else {
        _circleController.viewIndex.value = 0;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  filterCircleType({String? type}) async {
    try {
      List<CircleModel> circles = _circleController.circle;
      List<CircleModel> filterCircles = [];
      if (circleFilterType.value == StringConfig.reporting.lastDay) {
        DateTime lastDay = DateTime.now().subtract(const Duration(days: 1));
        filterCircles = circles.where((e) {
          DateTime postTime = DateTime.parse(e.postTime?.isEmpty ?? false
              ? DateTime.now().toIso8601String()
              : e.postTime ?? DateTime.now().toIso8601String());
          return postTime.day == lastDay.day &&
              postTime.month == lastDay.month &&
              postTime.year == lastDay.year;
        }).toList();
      } else if (circleFilterType.value == StringConfig.reporting.lastWeek) {
        DateTime lastWeek = DateTime.now().subtract(const Duration(days: 7));
        DateTime start =
            lastWeek.subtract(Duration(days: DateTime.now().weekday - 1));
        DateTime startDate = DateTime(start.year, start.month, start.day);
        DateTime end = lastWeek
            .add(Duration(days: DateTime.daysPerWeek - lastWeek.weekday));
        DateTime endDate = DateTime(end.year, end.month, end.day, 24);
        filterCircles = circles.where((e) {
          DateTime postTime = DateTime.parse(e.postTime?.isEmpty ?? false
              ? DateTime.now().toIso8601String()
              : e.postTime ?? DateTime.now().toIso8601String());
          return postTime.isAfter(startDate) && postTime.isBefore(endDate);
        }).toList();
      } else if (circleFilterType.value == StringConfig.reporting.lastMonth) {
        DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));
        filterCircles = circles.where((e) {
          DateTime postTime = DateTime.parse(e.postTime?.isEmpty ?? false
              ? DateTime.now().toIso8601String()
              : e.postTime ?? DateTime.now().toIso8601String());
          return postTime.month == lastMonth.month &&
              postTime.year == lastMonth.year;
        }).toList();
      } else if (startCircleTypeDateController.text.isNotEmpty &&
          endCircleTypeDateController.text.isNotEmpty) {
        DateTime start =
            DateFormat('dd/MM/yyyy').parse(startCircleTypeDateController.text);
        DateTime endDate =
            DateFormat('dd/MM/yyyy').parse(endCircleTypeDateController.text);
        DateTime end = DateTime(endDate.year, endDate.month, endDate.day, 24);
        filterCircles = circles.where((e) {
          DateTime postTime = DateTime.parse(e.postTime?.isEmpty ?? false
              ? DateTime.now().toIso8601String()
              : e.postTime ?? DateTime.now().toIso8601String());
          return postTime.isAfter(start) && postTime.isBefore(end);
        }).toList();
      }
      _circleController.reset();
      _circleController.searchedCircle.value = filterCircles;
      _circleController.searchCircleType.value = filterCircles;
      if (_circleController.searchedCircle.isEmpty) {
        _circleController.viewIndex.value = -1;
      } else {
        _circleController.viewIndex.value = 0;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  filterSubscription({String? type}) async {
    try {
      if (type != null) {
        subscriptionType.value = type;
      }

      List<MQSMyQUserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();
      List<MQSMyQUserIamModel> users = await UserRepository.i.getUsers();
      if (subscriptionFilter.value == StringConfig.reporting.today) {
        DateTime today = DateTime.now();
        users = users.where((e) {
          DateTime postTime = DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
              ? e.mqsCreatedTimestamp ??""
              : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
              ? e.mqsEnterpriseCreatedTimestamp ??""
              : DateTime.now().toIso8601String());
          return postTime.day == today.day &&
              postTime.month == today.month &&
              postTime.year == today.year;
        }).toList();
      } else if (subscriptionFilter.value == StringConfig.reporting.lastDay) {
        DateTime lastDay = DateTime.now().subtract(const Duration(days: 1));

        users = users.where((e) {
          DateTime postTime = DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty?? false
              ? e.mqsCreatedTimestamp?? ""
              : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
              ? e.mqsEnterpriseCreatedTimestamp ??""
              : DateTime.now().toIso8601String());
          return postTime.day == lastDay.day &&
              postTime.month == lastDay.month &&
              postTime.year == lastDay.year;
        }).toList();
      } else if (subscriptionFilter.value == StringConfig.reporting.lastWeek) {
        DateTime lastWeek = DateTime.now().subtract(const Duration(days: 7));
        DateTime start =
            lastWeek.subtract(Duration(days: DateTime.now().weekday - 1));
        DateTime startDate = DateTime(start.year, start.month, start.day);
        DateTime end = lastWeek
            .add(Duration(days: DateTime.daysPerWeek - lastWeek.weekday));
        DateTime endDate = DateTime(end.year, end.month, end.day, 24);
        users = users.where((e) {
          DateTime postTime = DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty?? false
              ? e.mqsCreatedTimestamp??""
              : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
              ? e.mqsEnterpriseCreatedTimestamp ??""
              : DateTime.now().toIso8601String());
          return postTime.isAfter(startDate) && postTime.isBefore(endDate);
        }).toList();
      } else if (subscriptionFilter.value == StringConfig.reporting.lastMonth) {
        DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));
        users = users.where((e) {
          DateTime postTime = DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty?? false
              ? e.mqsCreatedTimestamp??""
              : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
              ? e.mqsEnterpriseCreatedTimestamp??""
              : DateTime.now().toIso8601String());
          return postTime.month == lastMonth.month &&
              postTime.year == lastMonth.year;
        }).toList();
      } else if (startDateController.text.isNotEmpty &&
          endDateController.text.isNotEmpty) {
        DateTime start =
            DateFormat('dd/MM/yyyy').parse(startDateController.text);
        DateTime endDate =
            DateFormat('dd/MM/yyyy').parse(endDateController.text);
        DateTime end = DateTime(endDate.year, endDate.month, endDate.day, 24);
        users = users.where((e) {
          DateTime postTime = DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty?? false
              ? e.mqsCreatedTimestamp??""
              : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
              ? e.mqsEnterpriseCreatedTimestamp??""
              : DateTime.now().toIso8601String());
          return postTime.isAfter(start) && postTime.isBefore(end);
        }).toList();
      }
      List activeRec = receipt
          .where(
              (e) => e.mqsSubscriptionStatus == StringConfig.reporting.active)
          .toList();

      activeSubscriptions.value = users.where((localItem) {
        return activeRec.any((firebaseItem) =>
            firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
      }).length;

      List purchasedRec =
          receipt.where((e) => e.mqsPurchaseID?.isNotEmpty ?? false).toList();

      purchasedSubscription.value = users.where((localItem) {
        return purchasedRec.any((firebaseItem) =>
            firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
      }).length;

      _dashboardController.reset();
      _dashboardController.searchedUsers.value = users;
      _dashboardController.searchUserType.value = users;
      _dashboardController.users.value = users;
      if (subscriptionType.value == StringConfig.reporting.activeSubscription) {
        List activeRec = receipt
            .where((e) =>
                e.mqsSubscriptionStatus == StringConfig.reporting.active)
            .toList();

        _dashboardController.searchedUsers.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        _dashboardController.users.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        _dashboardController.searchUserType.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
      } else if (subscriptionType.value ==
          StringConfig.reporting.purchasedSubscription) {
        List purchasedRec =
            receipt.where((e) => e.mqsPurchaseID?.isNotEmpty ?? false).toList();

        _dashboardController.searchedUsers.value = users.where((localItem) {
          return purchasedRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        _dashboardController.users.value = users.where((localItem) {
          return purchasedRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        _dashboardController.searchUserType.value = users.where((localItem) {
          return purchasedRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
      }
      if (_dashboardController.searchedUsers.isEmpty &&
          _dashboardController.users.isEmpty) {
        _dashboardController.viewIndex.value = -1;
      } else {
        _dashboardController.viewIndex.value = 0;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  filterSubscriptionType({String? type}) async {
    try {
      List<MQSMyQUserIamModel> users = _dashboardController.users;
      List<MQSMyQUserIamModel> filterUsers = [];
      if (subscriptionFilterType.value == StringConfig.reporting.lastDay) {
        DateTime lastDay = DateTime.now().subtract(const Duration(days: 1));
        filterUsers = users.where((e) {
          DateTime postTime = DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ??false
              ? e.mqsCreatedTimestamp??""
              : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty??false
              ? e.mqsEnterpriseCreatedTimestamp ??""
              : DateTime.now().toIso8601String());
          return postTime.day == lastDay.day &&
              postTime.month == lastDay.month &&
              postTime.year == lastDay.year;
        }).toList();
      } else if (subscriptionFilterType.value ==
          StringConfig.reporting.lastWeek) {
        DateTime lastWeek = DateTime.now().subtract(const Duration(days: 7));
        DateTime start =
            lastWeek.subtract(Duration(days: DateTime.now().weekday - 1));
        DateTime startDate = DateTime(start.year, start.month, start.day);
        DateTime end = lastWeek
            .add(Duration(days: DateTime.daysPerWeek - lastWeek.weekday));
        DateTime endDate = DateTime(end.year, end.month, end.day, 24);
        filterUsers = users.where((e) {
          DateTime postTime = DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty??false
              ? e.mqsCreatedTimestamp ??""
              : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty??false
              ? e.mqsEnterpriseCreatedTimestamp??""
              : DateTime.now().toIso8601String());
          return postTime.isAfter(startDate) && postTime.isBefore(endDate);
        }).toList();
      } else if (subscriptionFilterType.value ==
          StringConfig.reporting.lastMonth) {
        DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));
        filterUsers = users.where((e) {
          DateTime postTime = DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty??false
              ? e.mqsCreatedTimestamp??""
              : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty??false
              ? e.mqsEnterpriseCreatedTimestamp??""
              : DateTime.now().toIso8601String());
          return postTime.month == lastMonth.month &&
              postTime.year == lastMonth.year;
        }).toList();
      } else if (startSubscriptionTypeDateController.text.isNotEmpty &&
          endSubscriptionTypeDateController.text.isNotEmpty) {
        DateTime start = DateFormat('dd/MM/yyyy')
            .parse(startSubscriptionTypeDateController.text);
        DateTime endDate = DateFormat('dd/MM/yyyy')
            .parse(endSubscriptionTypeDateController.text);
        DateTime end = DateTime(endDate.year, endDate.month, endDate.day, 24);
        filterUsers = users.where((e) {
          DateTime postTime = DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty??false
              ? e.mqsCreatedTimestamp??""
              : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty??false
              ? e.mqsEnterpriseCreatedTimestamp??""
              : DateTime.now().toIso8601String());
          return postTime.isAfter(start) && postTime.isBefore(end);
        }).toList();
      }
      _dashboardController.reset();
      _dashboardController.searchedUsers.value = filterUsers;
      _dashboardController.searchUserType.value = filterUsers;
      if (_dashboardController.searchedUsers.isEmpty) {
        _dashboardController.viewIndex.value = -1;
      } else {
        _dashboardController.viewIndex.value = 0;
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

  getOBSummary({required List<MQSMyQUserIamModel> users}) async {
    try {
      completedOBUsers.value = users
          .where((e) =>
              e.mqsOnboardingDetails?.mqsOBDone == true)
          .toList()
          .length;
      skippedOBUsers.value =
          users.where((e) =>  e.mqsOnboardingDetails?.mqsOBSkip == true).toList().length;

      partialCompletedOBUsers.value =
          users.where((e) =>  e.mqsOnboardingDetails?.mqsOBStart == true && e.mqsOnboardingDetails?.mqsOBDone == false).toList().length;
      completedOB.value = completedOBUsers.value / users.length;
      skippedOB.value = skippedOBUsers.value / users.length;
      partialCompletedOB.value = partialCompletedOBUsers.value / users.length;
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getSubscriptionSummary() async {
    try {
      startDateController.clear();
      endDateController.clear();
      List<MQSMyQUserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();
      List<MQSMyQUserIamModel> users = await UserRepository.i.getUsers();

      _dashboardController.searchedUsers.value = users;
      _dashboardController.searchUserType.value = users;
      if (subscriptionType.value == StringConfig.reporting.activeSubscription) {
        List activeRec = receipt
            .where((e) =>
                e.mqsSubscriptionStatus == StringConfig.reporting.active)
            .toList();
        _dashboardController.searchedUsers.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        _dashboardController.searchUserType.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();

        _dashboardController.users.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
      } else if (subscriptionType.value ==
          StringConfig.reporting.purchasedSubscription) {
        List purchasedRec =
            receipt.where((e) => e.mqsPurchaseID?.isNotEmpty ?? false).toList();
        _dashboardController.searchedUsers.value = users.where((localItem) {
          return purchasedRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        _dashboardController.searchUserType.value = users.where((localItem) {
          return purchasedRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        _dashboardController.users.value = users.where((localItem) {
          return purchasedRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
      }
      List activeRec = receipt
          .where((e) =>
              e.mqsSubscriptionStatus == StringConfig.reporting.active)
          .toList();

      activeSubscriptions.value = users.where((localItem) {
        return activeRec.any((firebaseItem) =>
            firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
      }).length;

      List purchasedRec =
          receipt.where((e) => e.mqsPurchaseID?.isNotEmpty?? false).toList();

      purchasedSubscription.value = users.where((localItem) {
        return purchasedRec.any((firebaseItem) =>
            firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
      }).length;

      userSubscriptionReceiptStream =
          UserRepository.i.getUserSubscriptionReceiptStream().listen((data) {
        subscriptionFilter.value = '';

        List activeRec = data
            .where((e) =>
                e.mqsSubscriptionStatus == StringConfig.reporting.active)
            .toList();

        activeSubscriptions.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).length;

        List purchasedRec =
            data.where((e) => e.mqsPurchaseID?.isNotEmpty ?? false).toList();

        purchasedSubscription.value = users.where((localItem) {
          return purchasedRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).length;
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getSubscriptionSummaryDetail(String status) async {
    try {
      List<MQSMyQUserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();
      List<MQSMyQUserIamModel> users = await UserRepository.i.getUsers();

      if (status == "active") {
        List activeRec = receipt
            .where((e) =>
                e.mqsSubscriptionStatus == StringConfig.reporting.active)
            .toList();
        _dashboardController.searchedUsers.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        _dashboardController.users.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
      } else if (status == "purchased") {
        List purchasedRec =
            receipt.where((e) => e.mqsPurchaseID?.isNotEmpty?? false).toList();
        _dashboardController.searchedUsers.value = users.where((localItem) {
          return purchasedRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        _dashboardController.users.value = users.where((localItem) {
          return purchasedRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
      } else {}
      userSubscriptionReceiptStream =
          UserRepository.i.getUserSubscriptionReceiptStream().listen((data) {
        if (status == "active") {
          List activeRec = data
              .where((e) =>
                  e.mqsSubscriptionStatus == StringConfig.reporting.active)
              .toList();
          _dashboardController.searchedUsers.value = users.where((localItem) {
            return activeRec.any((firebaseItem) =>
                firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
          }).toList();
          _dashboardController.users.value = users.where((localItem) {
            return activeRec.any((firebaseItem) =>
                firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
          }).toList();
        } else if (status == "purchased") {
          List purchasedRec =
              data.where((e) => e.mqsPurchaseID?.isNotEmpty?? false).toList();
          _dashboardController.searchedUsers.value = users.where((localItem) {
            return purchasedRec.any((firebaseItem) =>
                firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
          }).toList();
          _dashboardController.users.value = users.where((localItem) {
            return purchasedRec.any((firebaseItem) =>
                firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
          }).toList();
        } else {}
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  exportSubscriptionSummary() async {
    try {
      List<MQSMyQUserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();
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
          StringConfig.dashboard.mqsSubscriptionActivationDate,
          StringConfig.dashboard.mqsSubscriptionRenewalDate,
          StringConfig.reporting.expiryDate,
        ],
        ...receipt.map((model) {
          return [
            model.mqsFirebaseUserID ??"",
            model.mqsMONGODBUserID??"",
            model.mqsAppSpecificSharedSecret??"",
            model.mqsLocalVerificationData??"",
            model.mqsPackageName??"",
            model.mqsPurchaseID??"",
            model.mqsServerVerificationData??"",
            model.mqsSource??"",
            model.mqsSubscriptionActivePlan??"",
            model.mqsSubscriptionPlatform??"",
            model.mqsTransactionID??"",
            model.mqsSubscriptionStatus??"",
            model.mqsSubscriptionActivationTimestamp?.isNotEmpty ?? false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                .format(DateTime.parse(model.mqsSubscriptionActivationTimestamp ??""))
                : "",
            model.mqsSubscriptionRenewalTimestamp?.isNotEmpty ?? false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                .format(DateTime.parse(model.mqsSubscriptionRenewalTimestamp ??""))
                : "",
            model.mqsSubscriptionExpiryTimestamp?.isNotEmpty ?? false
                ? DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                .format(DateTime.parse(model.mqsSubscriptionExpiryTimestamp ??""))
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

  getYearWiseSignUpChart() async {
    try {
      signUpChartData.clear();
      List<MQSMyQUserIamModel> users = await UserRepository.i.getUsers();
      List<MQSMyQUserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();
      List<MQSMyQUserSubscriptionReceiptModel> activeRec = receipt
          .where((e) =>
              e.mqsSubscriptionStatus == StringConfig.reporting.active)
          .toList();
      List<MQSMyQUserSubscriptionReceiptModel> inActiveRec = receipt
          .where((e) =>
              e.mqsSubscriptionStatus != StringConfig.reporting.active)
          .toList();
      users.sort((a, b) => DateTime.parse(a.mqsCreatedTimestamp?.isNotEmpty ?? false
          ? a.mqsCreatedTimestamp??""
          : a.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
          ? a.mqsEnterpriseCreatedTimestamp??""
          : DateTime.now().toIso8601String())
          .compareTo(DateTime.parse(b.mqsCreatedTimestamp?.isNotEmpty?? false
          ? b.mqsCreatedTimestamp??""
          : b.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
          ? b.mqsEnterpriseCreatedTimestamp??""
          : DateTime.now().toIso8601String())));
      List<int> uniqueYears = (users
              .map((data) => (DateTime.parse(data.mqsCreatedTimestamp?.isNotEmpty?? false
          ? data.mqsCreatedTimestamp??""
          : data.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
          ? data.mqsEnterpriseCreatedTimestamp??""
          : DateTime.now().toIso8601String()))
                  .year)
              .toList()
            ..addAll(
                (receipt.where((e) => e.mqsSubscriptionExpiryTimestamp?.isNotEmpty?? false))
                    .map((data) =>
                        (DateTime.parse(data.mqsSubscriptionExpiryTimestamp??"")).year)))
          .toSet()
          .toList()
        ..sort();
      for (int year in uniqueYears) {
        double y1 = users
            .where((e) =>
                (DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String()))
                    .year ==
                year)
            .length
            .toDouble();
        double y2 = users
            .where((e) =>
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .year ==
                    year &&
                e.mqsOnboardingDetails?.mqsOBDone == true)
            .length
            .toDouble();
        double y3 = users
            .where((e) =>
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .year ==
                    year &&
                activeRec.any(
                    (test) => test.mqsFirebaseUserID == e.mqsUserID))
            .length
            .toDouble();
        double y4 = receipt
            .where((e) =>
                (e.mqsSubscriptionExpiryTimestamp?.isNotEmpty?? false) &&
                DateTime.parse(e.mqsSubscriptionExpiryTimestamp ?? "").year == year)
            .length
            .toDouble();
        double y6 = users
            .where((e) =>
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .year ==
                    year &&
                inActiveRec.any(
                    (test) => test.mqsFirebaseUserID == e.mqsUserID))
            .length
            .toDouble();
        signUpChartData.add(
            LineChartModel(DateTime(year), y1, y2: y2, y3: y3, y4: y4, y6: y6));
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getMonthWiseSignUpChart() async {
    try {
      signUpChartData.clear();
      List<MQSMyQUserIamModel> users = await UserRepository.i.getUsers();
      List<MQSMyQUserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();
      List<MQSMyQUserSubscriptionReceiptModel> activeRec = receipt
          .where((e) =>
              e.mqsSubscriptionStatus == StringConfig.reporting.active)
          .toList();
      List<MQSMyQUserSubscriptionReceiptModel> inActiveRec = receipt
          .where((e) =>
              e.mqsSubscriptionStatus != StringConfig.reporting.active)
          .toList();

      users.sort((a, b) => DateTime.parse(a.mqsCreatedTimestamp?.isNotEmpty ?? false
          ? a.mqsCreatedTimestamp ??""
          : a.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
          ? a.mqsEnterpriseCreatedTimestamp??""
          : DateTime.now().toIso8601String())
          .compareTo(DateTime.parse(b.mqsCreatedTimestamp?.isNotEmpty ?? false
          ? b.mqsCreatedTimestamp??""
          : b.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
          ? b.mqsEnterpriseCreatedTimestamp??""
          : DateTime.now().toIso8601String())));
      // Use a set to ensure uniqueness
      final uniqueMonths = <String>{};
      for (var point in users) {
        // Format month-year for uniqueness
        final monthYear =
            "${DateTime.parse(point.mqsCreatedTimestamp?.isNotEmpty ?? false
            ? point.mqsCreatedTimestamp??""
            : point.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
            ? point.mqsEnterpriseCreatedTimestamp??""
            : DateTime.now().toIso8601String()).year}-${DateTime.parse(point.mqsCreatedTimestamp?.isNotEmpty?? false
            ? point.mqsCreatedTimestamp??""
            : point.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
            ? point.mqsEnterpriseCreatedTimestamp??""
            : DateTime.now().toIso8601String()).month.toString().padLeft(2, '0')}";
        uniqueMonths.add(monthYear);
      }
      for (var point
          in (receipt.where((e) => e.mqsSubscriptionExpiryTimestamp?.isNotEmpty ?? false))) {
        // Format month-year for uniqueness
        final monthYear =
            "${DateTime.parse(point.mqsSubscriptionExpiryTimestamp??"").year}-${DateTime.parse(point.mqsSubscriptionExpiryTimestamp??"").month.toString().padLeft(2, '0')}";
        uniqueMonths.add(monthYear);
      }
      for (String x in uniqueMonths) {
        int year = int.parse(x.split('-').first);
        int month = int.parse(x.split('-').last);
        double y1 = users
            .where((e) =>
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .month ==
                    month &&
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .year ==
                    year)
            .length
            .toDouble();
        double y2 = users
            .where((e) =>
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .month ==
                    month &&
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .year ==
                    year &&
                e.mqsOnboardingDetails?.mqsOBDone == true)
            .length
            .toDouble();
        double y3 = users
            .where((e) =>
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .month ==
                    month &&
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .year ==
                    year &&
                activeRec.any(
                    (test) => test.mqsFirebaseUserID == e.mqsUserID))
            .length
            .toDouble();
        double y4 = receipt
            .where((e) =>
                (e.mqsSubscriptionExpiryTimestamp?.isNotEmpty ?? false)&&
                DateTime.parse(e.mqsSubscriptionExpiryTimestamp??"").month == month &&
                DateTime.parse(e.mqsSubscriptionExpiryTimestamp??"").year == year)
            .length
            .toDouble();
        double y6 = users
            .where((e) =>
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .month ==
                    month &&
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .year ==
                    year &&
                inActiveRec.any(
                    (test) => test.mqsFirebaseUserID == e.mqsUserID))
            .length
            .toDouble();
        signUpChartData.add(LineChartModel(DateTime(year, month), y1,
            y2: y2, y3: y3, y4: y4, y6: y6));
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  int getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysOffset = firstDayOfYear.weekday - DateTime.monday;
    final firstMonday = firstDayOfYear.add(Duration(days: -daysOffset));
    final difference = date.difference(firstMonday).inDays;
    return (difference / 7).ceil() + 1;
  }

  DateTime getDateFromWeekNumber(int year, int weekNumber) {
    // Start of the year
    DateTime firstDayOfYear = DateTime(year, 1, 1);
    // Calculate the offset to the first day of the week (e.g., Monday)
    int daysOffset = (firstDayOfYear.weekday - DateTime.monday) % 7;
    // Calculate the start of the first week
    DateTime firstWeekStart =
        firstDayOfYear.subtract(Duration(days: daysOffset));
    // Calculate the desired week's start date
    DateTime weekStartDate =
        firstWeekStart.add(Duration(days: (weekNumber - 1) * 7));
    return weekStartDate;
  }

  getWeekWiseSignUpChart() async {
    try {
      signUpChartData.clear();
      List<MQSMyQUserIamModel> users = await UserRepository.i.getUsers();
      List<MQSMyQUserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();
      List<MQSMyQUserSubscriptionReceiptModel> activeRec = receipt
          .where((e) =>
              e.mqsSubscriptionStatus == StringConfig.reporting.active)
          .toList();
      List<MQSMyQUserSubscriptionReceiptModel> inActiveRec = receipt
          .where((e) =>
              e.mqsSubscriptionStatus != StringConfig.reporting.active)
          .toList();
      users.sort((a, b) => DateTime.parse(a.mqsCreatedTimestamp?.isNotEmpty?? false
          ? a.mqsCreatedTimestamp ??""
          : a.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
          ? a.mqsEnterpriseCreatedTimestamp??""
          : DateTime.now().toIso8601String())
          .compareTo(DateTime.parse(b.mqsCreatedTimestamp?.isNotEmpty?? false
          ? b.mqsCreatedTimestamp??""
          : b.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
          ? b.mqsEnterpriseCreatedTimestamp??""
          : DateTime.now().toIso8601String())));
      final groupedData = <String, List<MQSMyQUserIamModel>>{};
      for (var dataPoint in users) {
        DateTime date = DateTime.parse(dataPoint.mqsCreatedTimestamp?.isNotEmpty?? false
            ? dataPoint.mqsCreatedTimestamp??""
            : dataPoint.mqsEnterpriseCreatedTimestamp?.isNotEmpty?? false
            ? dataPoint.mqsEnterpriseCreatedTimestamp??""
            : DateTime.now().toIso8601String());
        final weekNumber = getWeekNumber(date);
        groupedData
            .putIfAbsent('$weekNumber-${date.year}', () => [])
            .add(dataPoint);
      }
      final groupedReceiptData = <String, List<MQSMyQUserSubscriptionReceiptModel>>{};
      for (var dataPoint
          in (receipt.where((e) => e.mqsSubscriptionExpiryTimestamp?.isNotEmpty?? false))) {
        DateTime date = DateTime.parse(dataPoint.mqsSubscriptionExpiryTimestamp??"");
        final weekNumber = getWeekNumber(date);
        groupedReceiptData
            .putIfAbsent('$weekNumber-${date.year}', () => [])
            .add(dataPoint);
      }
      final merged = (groupedData.keys.toList()
            ..addAll(groupedReceiptData.keys))
          .toSet()
          .toList();
      for (var data in merged) {
        List<MapEntry<String, List<MQSMyQUserIamModel>>> userElement =
            groupedData.entries.where((e) => e.key == data).toList();
        List<MapEntry<String, List<MQSMyQUserSubscriptionReceiptModel>>>
            receiptElement =
            groupedReceiptData.entries.where((e) => e.key == data).toList();
        int year = int.parse(data.split('-').last);
        int weekNumber = int.parse(data.split('-').first);
        DateTime date = getDateFromWeekNumber(year, weekNumber);
        double y1 = 0, y2 = 0, y3 = 0, y4 = 0, y6 = 0;
        if (userElement.isNotEmpty) {
          y1 = userElement.first.value.length.toDouble();
          y2 = userElement.first.value
              .where((e) =>
                  e.mqsOnboardingDetails?.mqsOBDone == true)
              .length
              .toDouble();
          y3 = userElement.first.value
              .where((e) => activeRec
                  .any((test) => test.mqsFirebaseUserID == e.mqsUserID))
              .length
              .toDouble();
          y6 = userElement.first.value
              .where((e) => inActiveRec
                  .any((test) => test.mqsFirebaseUserID == e.mqsUserID))
              .length
              .toDouble();
        }
        if (receiptElement.isNotEmpty) {
          y4 = receiptElement.first.value.length.toDouble();
        }
        signUpChartData
            .add(LineChartModel(date, y1, y2: y2, y3: y3, y4: y4, y6: y6));
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getDayWiseSignUpChart() async {
    try {
      signUpChartData.clear();
      List<MQSMyQUserIamModel> users = await UserRepository.i.getUsers();
      List<MQSMyQUserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();
      List<MQSMyQUserSubscriptionReceiptModel> activeRec = receipt
          .where((e) =>
              e.mqsSubscriptionStatus == StringConfig.reporting.active)
          .toList();
      List<MQSMyQUserSubscriptionReceiptModel> inActiveRec = receipt
          .where((e) =>
              e.mqsSubscriptionStatus != StringConfig.reporting.active)
          .toList();
      users.sort((a, b) => DateTime.parse(a.mqsCreatedTimestamp?.isNotEmpty ?? false
          ? a.mqsCreatedTimestamp ??""
          : a.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
          ? a.mqsEnterpriseCreatedTimestamp??""
          : DateTime.now().toIso8601String())
          .compareTo(DateTime.parse(b.mqsCreatedTimestamp?.isNotEmpty ?? false
          ? b.mqsCreatedTimestamp??""
          : b.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
          ? b.mqsEnterpriseCreatedTimestamp??""
          : DateTime.now().toIso8601String())));
      List<DateTime> uniqueDays = (users
              .map((data) => DateTime(
                  DateTime.parse(data.mqsCreatedTimestamp?.isNotEmpty ?? false
                      ? data.mqsCreatedTimestamp??""
                      : data.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                      ? data.mqsEnterpriseCreatedTimestamp??""
                      : DateTime.now().toIso8601String())
                      .year,
                  DateTime.parse(data.mqsCreatedTimestamp?.isNotEmpty ?? false
                      ? data.mqsCreatedTimestamp??""
                      : data.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                      ? data.mqsEnterpriseCreatedTimestamp??""
                      : DateTime.now().toIso8601String())
                      .month,
                  DateTime.parse(data.mqsCreatedTimestamp?.isNotEmpty ?? false
                      ? data.mqsCreatedTimestamp??""
                      : data.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                      ? data.mqsEnterpriseCreatedTimestamp??""
                      : DateTime.now().toIso8601String())
                      .day))
              .toList()
            ..addAll((receipt.where((e) => e.mqsSubscriptionExpiryTimestamp?.isNotEmpty ?? false))
                .map((data) => DateTime(DateTime.parse(data.mqsSubscriptionExpiryTimestamp??"").year, DateTime.parse(data.mqsSubscriptionExpiryTimestamp??"").month, DateTime.parse(data.mqsSubscriptionExpiryTimestamp??"").day))))
          .toSet()
          .toList();
      for (DateTime date in uniqueDays) {
        double y1 = users
            .where((e) =>
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .month ==
                    date.month &&
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .year ==
                    date.year &&
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .day ==
                    date.day)
            .length
            .toDouble();
        double y2 = users
            .where((e) =>
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .month ==
                    date.month &&
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .year ==
                    date.year &&
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .day ==
                    date.day &&
                e.mqsOnboardingDetails?.mqsOBDone == true)
            .length
            .toDouble();
        double y3 = users
            .where((e) =>
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .month ==
                    date.month &&
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .year ==
                    date.year &&
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .day ==
                    date.day &&
                activeRec.any(
                    (test) => test.mqsFirebaseUserID == e.mqsUserID))
            .length
            .toDouble();
        double y4 = receipt
            .where((e) =>
                (e.mqsSubscriptionExpiryTimestamp?.isNotEmpty ?? false )&&
                DateTime.parse(e.mqsSubscriptionExpiryTimestamp??"").month ==
                    date.month &&
                DateTime.parse(e.mqsSubscriptionExpiryTimestamp??"").year == date.year &&
                DateTime.parse(e.mqsSubscriptionExpiryTimestamp??"").day == date.day)
            .length
            .toDouble();
        double y6 = users
            .where((e) =>
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .month ==
                    date.month &&
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .year ==
                    date.year &&
                DateTime.parse(e.mqsCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsCreatedTimestamp??""
                    : e.mqsEnterpriseCreatedTimestamp?.isNotEmpty ?? false
                    ? e.mqsEnterpriseCreatedTimestamp??""
                    : DateTime.now().toIso8601String())
                        .day ==
                    date.day &&
                inActiveRec.any(
                    (test) => test.mqsFirebaseUserID == e.mqsUserID))
            .length
            .toDouble();
        signUpChartData.add(LineChartModel(
            DateTime(date.year, date.month, date.day), y1,
            y2: y2, y3: y3, y4: y4, y6: y6));
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  filterSignUp() async {
    try {
      final DashboardController dashboardController = Get.find();
      List<MQSMyQUserIamModel> users = await UserRepository.i.getUsers();
      List<MQSMyQUserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();
      dashboardController.reset();
      if (reportType.value == StringConfig.reporting.userRegistered) {
        dashboardController.searchedUsers.value = users;
        dashboardController.searchUserType.value = users;
        dashboardController.users.value = users;
      } else if (reportType.value ==
          StringConfig.reporting.onboradingCompleted) {
        dashboardController.searchedUsers.value = users
            .where((e) =>
                e.mqsOnboardingDetails?.mqsOBDone== true)
            .toList();
        dashboardController.searchUserType.value = users
            .where((e) =>
        e.mqsOnboardingDetails?.mqsOBDone== true)
            .toList();
        dashboardController.users.value = users
            .where((e) =>
        e.mqsOnboardingDetails?.mqsOBDone== true)
            .toList();
      } else if (reportType.value == StringConfig.reporting.subscribed) {
        List<MQSMyQUserSubscriptionReceiptModel> activeRec = receipt
            .where((e) =>
                e.mqsSubscriptionStatus == StringConfig.reporting.active)
            .toList();
        dashboardController.searchedUsers.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        dashboardController.searchUserType.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        dashboardController.users.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
      } else if (reportType.value ==
          StringConfig.reporting.subscriptionExpired) {
        List<MQSMyQUserSubscriptionReceiptModel> activeRec =
            receipt.where((e) => e.mqsSubscriptionExpiryTimestamp?.isNotEmpty ?? false).toList();
        dashboardController.searchedUsers.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        dashboardController.searchUserType.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        dashboardController.users.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
      } else if (reportType.value == StringConfig.reporting.notSubscribed) {
        List<MQSMyQUserSubscriptionReceiptModel> inActiveRec = receipt
            .where((e) =>
                e.mqsSubscriptionStatus != StringConfig.reporting.active)
            .toList();
        dashboardController.searchedUsers.value = users.where((localItem) {
          return inActiveRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        dashboardController.searchUserType.value = users.where((localItem) {
          return inActiveRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        dashboardController.users.value = users.where((localItem) {
          return inActiveRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
      }
      if (dashboardController.searchedUsers.isEmpty &&
          dashboardController.users.isNotEmpty) {
        dashboardController.viewIndex.value = -1;
      } else {
        dashboardController.viewIndex.value = 0;
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  overAllSummary() async {
    try {
      final DashboardController dashboardController = Get.find();
      dashboardController.searchController.clear();
      _circleController.searchController.clear();
      List<MQSMyQUserIamModel> users = await UserRepository.i.getUsers();
      List<MQSMyQUserSubscriptionReceiptModel> receipt =
          await UserRepository.i.getUserSubscriptionReceipt();

      List<EnterpriseModel> enterpriseList =
          await EnterpriseRepository.i.getEnterprises();
      List<CircleModel> circleList = await CircleRepository.i.getCircles();

      dashboardController.reset();
      _circleController.reset();
      if (reportType.value == StringConfig.dashboard.enterprise) {
        dashboardController.searchedEnterprises.value = enterpriseList;
        dashboardController.enterprises.value = enterpriseList;

        if (dashboardController.searchedEnterprises.isEmpty &&
            dashboardController.enterprises.isNotEmpty) {
          dashboardController.viewIndex.value = -1;
        } else {
          dashboardController.viewIndex.value = 0;
        }
      } else if (reportType.value == StringConfig.reporting.users) {
        dashboardController.searchedUsers.value = users;
        dashboardController.searchUserType.value = users;
        dashboardController.users.value = users;
        if (dashboardController.searchedUsers.isEmpty &&
            dashboardController.users.isNotEmpty) {
          dashboardController.viewIndex.value = -1;
        } else {
          dashboardController.viewIndex.value = 0;
        }
      } else if (reportType.value == StringConfig.dashboard.circle) {
        _circleController.searchedCircle.value = circleList;
        _circleController.circle.value = circleList;
        _circleController.searchCircleType.value = circleList;

        if (_circleController.searchedCircle.isEmpty &&
            _circleController.circle.isEmpty) {
          _circleController.viewIndex.value = -1;
        } else {
          _circleController.viewIndex.value = 0;
        }
      } else if (reportType.value == StringConfig.dashboard.userSubscription) {
        List<MQSMyQUserSubscriptionReceiptModel> activeRec = receipt
            .where((e) =>
                e.mqsSubscriptionStatus == StringConfig.reporting.active)
            .toList();
        dashboardController.searchedUsers.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        dashboardController.searchUserType.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        dashboardController.users.value = users.where((localItem) {
          return activeRec.any((firebaseItem) =>
              firebaseItem.mqsFirebaseUserID == localItem.mqsUserID);
        }).toList();
        if (dashboardController.searchedUsers.isEmpty &&
            dashboardController.users.isNotEmpty) {
          dashboardController.viewIndex.value = -1;
        } else {
          dashboardController.viewIndex.value = 0;
        }
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }
}
