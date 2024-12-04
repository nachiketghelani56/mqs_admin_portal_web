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
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class CircleController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxList<CircleModel> searchedCircle = <CircleModel>[].obs,
      circle = <CircleModel>[].obs;
  RxInt pageLimit = 10.obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  int get totalCirclePage => (searchedCircle.length / pageLimit.value).ceil();
  RxInt viewIndex = (-1).obs;
  CircleModel get circleDetail => searchedCircle[viewIndex.value];
  StreamSubscription<List<CircleModel>>? circleStream;

  @override
  onInit() {
    getCircle();
    super.onInit();
  }

  @override
  void onClose() async {
    await circleStream?.cancel();
    super.onClose();
  }

  getCircle() async {
    try {
      List<CircleModel> circleList =
          await FirebaseStorageService.i.getCircles();
      searchedCircle.value = circleList;
      circle.value = circleList;
      circleStream =
          FirebaseStorageService.i.getCircleStream().listen((circleList) {
        searchedCircle.value = circleList;
        circle.value = circleList;
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getMaxOffset() {
    int rem = searchedCircle.length % pageLimit.value;
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

  searchCircle() {
    try {
      reset();
      String query = searchController.text.trim().toLowerCase();
      if (query.isEmpty) {
        searchedCircle.value = circle;
      } else {
        searchedCircle.value = circle
            .where((e) =>
                (e.postTime ?? "").toLowerCase().contains(query) ||
                (e.postContent ?? "").toLowerCase().contains(query) ||
                (e.userName ?? "").toLowerCase().contains(query) ||
                (e.flagName ?? "").toLowerCase().contains(query) ||
                (e.hashtag?.any((ele) =>
                        (ele.name ?? "").toLowerCase().contains(query)) ??
                    false))
            .toList();
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  exportCircle() async {
    try {
      String currentDate =
          DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(DateTime(0));
      List<List<String>> rows = [
        ...circle.map((model) {
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
        name: StringConfig.dashboard.circleInformation,
      );
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }
}
