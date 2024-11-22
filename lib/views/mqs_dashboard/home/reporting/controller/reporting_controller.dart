import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/chart_model.dart';
import 'package:mqs_admin_portal_web/models/circle_model.dart';
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
  Map<String, Color> circleChartOpts = {
    StringConfig.reporting.trainingProgram: ColorConfig.card3TextColor,
    StringConfig.reporting.leadershipSupport: ColorConfig.card2TextColor,
    StringConfig.reporting.recognitionProgram: ColorConfig.card1TextColor,
  };
  RxInt optionIndex = 0.obs;
  RxList<ChartModel> indicatorCharData = [
    ChartModel(StringConfig.reporting.advocacy, 6),
    ChartModel(StringConfig.reporting.awareness, 9),
    ChartModel(StringConfig.reporting.acceptance, 3),
    ChartModel(StringConfig.reporting.aptitude, 4),
    ChartModel(StringConfig.reporting.adoption, 8)
  ].obs;
  RxInt totalRegisteredUsers = 0.obs,
      totalCircles = 0.obs,
      featuredCircles = 0.obs,
      flaggedCircles = 0.obs;

  @override
  onInit() {
    getAuthSummary();
    getCircleSummary();
    super.onInit();
  }

  getAuthSummary() async {
    try {
      totalRegisteredUsers.value =
          (await FirebaseStorageService.i.getUsers()).length;
      FirebaseStorageService.i.listenToUserChange((data) {
        totalRegisteredUsers.value = data.size;
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getCircleSummary() async {
    try {
      List<CircleModel> circles = await FirebaseStorageService.i.getCircles();
      setCircle(circles);
      FirebaseStorageService.i.listenToCircleChange((data) {
        List<CircleModel> circles = data.docs
            .map((e) => CircleModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
        setCircle(circles);
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

  exportCircleSummary() async {
    try {
      List<List<String>> rows = [
        [
          StringConfig.reporting.totalCircles,
          StringConfig.reporting.featuredCircles,
          StringConfig.reporting.flaggedCircles,
        ],
        [
          "${totalCircles.value}",
          "${featuredCircles.value}",
          "${flaggedCircles.value}",
        ],
      ];
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
}
