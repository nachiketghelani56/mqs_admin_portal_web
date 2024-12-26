import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/models/circle_model.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/services/firebase_auth_service.dart';
import 'package:mqs_admin_portal_web/services/firebase_storage_service.dart';
import 'package:mqs_admin_portal_web/views/circle/repository/circle_repository.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

class CircleController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxList<CircleModel> searchedCircle = <CircleModel>[].obs,
      circle = <CircleModel>[].obs,
      searchCircleType = <CircleModel>[].obs;
  RxInt pageLimit = 10.obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  int get totalCirclePage => (searchedCircle.length / pageLimit.value).ceil();
  RxInt viewIndex = (-1).obs;
  CircleModel get circleDetail => searchedCircle[viewIndex.value];
  StreamSubscription<List<CircleModel>>? circleStream;
  RxBool isAdd = false.obs, isEdit = false.obs;
  final TextEditingController postTitleController = TextEditingController();
  final TextEditingController postContentController = TextEditingController();
  final TextEditingController postViewController = TextEditingController();
  final TextEditingController flagNameController = TextEditingController();
  final TextEditingController hashtagController = TextEditingController();
  RxList<Hashtag> hashtags = <Hashtag>[].obs;
  RxString mainPostId = "".obs;
  RxBool isMainPost = true.obs,
      userIsGuide = false.obs,
      isFlag = false.obs,
      showHashTag = false.obs;
  RxBool circleLoader = false.obs;
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
      circleLoader.value = true;
      List<CircleModel> circleList = await CircleRepository.i.getCircles();
      searchedCircle.value = circleList;
      circle.value = circleList;
      searchCircleType.value = circleList;
      circleStream = CircleRepository.i.getCircleStream().listen((circleList) {
        searchedCircle.value = circleList;
        searchCircleType.value = circleList;
        circle.value = circleList;
        viewIndex.value = -1;
      });
      // Set filter fields of circle in filter sheet
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>().setFilterFields();
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {
      circleLoader.value = false;
    }
  }

  deleteCircle({required String docId}) async {
    try {
      showLoader();
      viewIndex.value = 0;
      isAdd.value = false;
      isEdit.value = false;
      CircleModel model = circle.firstWhere((e) => e.id == docId);
      if (model.isMainPost == true && (model.postReply?.isNotEmpty ?? false)) {
        model.postReply?.forEach((e) async {
          await CircleRepository.i.deleteCircle(docId: e);
        });
        await CircleRepository.i.deleteCircle(docId: model.id ?? "");
      } else if (model.isMainPost == false) {
        List<CircleModel> mainModel = circle
            .where((e) =>
                e.postReply?.where((ele) => ele == docId).isNotEmpty ?? false)
            .toList();
        if (mainModel.isNotEmpty) {
          CircleModel updated = mainModel.first;
          updated.postReply?.removeWhere((e) => e == docId);
          await CircleRepository.i
              .editCircle(docId: updated.id ?? "", circleModel: updated);
        }
      }
      await CircleRepository.i.deleteCircle(docId: docId);
      hideLoader();
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  clearAllFields() {
    postTitleController.clear();
    postContentController.clear();
    postViewController.clear();
    flagNameController.clear();
    isMainPost.value = true;
    mainPostId.value = "";
    userIsGuide.value = false;
    isFlag.value = false;
    hashtags.clear();
  }

  setCircleForm() {
    postTitleController.text = circleDetail.postTitle ?? "";
    postContentController.text = circleDetail.postContent ?? "";
    postViewController.text = (circleDetail.postView ?? 0).toString();
    flagNameController.text = circleDetail.flagName ?? "";
    isMainPost.value = circleDetail.isMainPost ?? false;
    userIsGuide.value = circleDetail.userIsGuide ?? false;
    isFlag.value = circleDetail.isFlag ?? false;
    hashtags.value = circleDetail.hashtag ?? [];
  }

  addCircle() async {
    try {

        final docRef = FirebaseStorageService.i.enterprise.doc().id;
        final circleModel = CircleModel(
          id: docRef,
          userId: isAdd.value
              ? FirebaseAuthService.i.user?.uid
              : circleDetail.userId,
          userName: isAdd.value
              ? FirebaseAuthService.i.user?.displayName ?? 'Admin'
              : circleDetail.userName,
          userIsGuide: userIsGuide.value,
          isFlag: isFlag.value,
          flagName: flagNameController.text.trim(),
          isMainPost: isMainPost.value,
          postTime: isAdd.value
              ? DateTime.now().toIso8601String()
              : circleDetail.postTime,
          postView: int.parse(postViewController.text),
          postTitle: postTitleController.text,
          postContent: postContentController.text,
          hashtag: hashtags,
          postReply: isAdd.value ? [] : circleDetail.postReply,
        );
        showLoader();
        if (isEdit.value) {
          await CircleRepository.i.editCircle(
              circleModel: circleModel, docId: circleDetail.id ?? "");
        } else {
          await CircleRepository.i
              .addCircle(circleModel: circleModel, customId: docRef);
        }
        if (!isMainPost.value && mainPostId.value.isNotEmpty) {
          CircleModel? mainCircle =
              circle.firstWhereOrNull((e) => e.id == mainPostId.value);
          mainCircle?.postReply?.add(docRef);
          if (mainCircle != null) {
            await CircleRepository.i
                .editCircle(docId: mainPostId.value, circleModel: mainCircle);
          }
        }
        hideLoader();
        clearAllFields();
        isAdd.value = false;
        isEdit.value = false;
        if (Get.currentRoute == AppRoutes.addCircle) {
          Get.back();
        }

    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  addHashatag() {
    hashtags.add(Hashtag(
      id: Random().nextInt(10000),
      name: hashtagController.text.trim(),
    ));
    hashtagController.clear();
  }

  removeHashtag({required int? id}) {
    hashtags.removeWhere((e) => e.id == id);
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

  searchCircle({String? status}) {
    try {
      reset();
      String query = searchController.text.trim().toLowerCase();
      if (query.isEmpty) {
        searchedCircle.value = status == "type" ? searchCircleType : circle;
      } else {
        if (status == "type") {
          searchedCircle.value = searchCircleType
              .where((e) =>
                  (e.postTitle ?? "").toLowerCase().contains(query) ||
                  (e.postContent ?? "").toLowerCase().contains(query) ||
                  (e.userName ?? "").toLowerCase().contains(query) ||
                  (e.flagName ?? "").toLowerCase().contains(query) ||
                  (e.hashtag?.any((ele) =>
                          (ele.name ?? "").toLowerCase().contains(query)) ??
                      false))
              .toList();
        } else {
          searchedCircle.value = circle
              .where((e) =>
                  (e.postTitle ?? "").toLowerCase().contains(query) ||
                  (e.postContent ?? "").toLowerCase().contains(query) ||
                  (e.userName ?? "").toLowerCase().contains(query) ||
                  (e.flagName ?? "").toLowerCase().contains(query) ||
                  (e.hashtag?.any((ele) =>
                          (ele.name ?? "").toLowerCase().contains(query)) ??
                      false))
              .toList();
        }
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  importCircle() async {
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
          List<Hashtag> hashTags = [];
          if (rowMap[StringConfig.reporting.hashTags] != null &&
              rowMap[StringConfig.reporting.hashTags].toString().isNotEmpty) {
            try {
              List<dynamic> tags =
                  jsonDecode(rowMap[StringConfig.reporting.hashTags]);
              hashTags = tags.map((team) {
                return Hashtag(
                  id: Random().nextInt(10000),
                  name: (team['name'] ?? "").toString(),
                );
              }).toList();
            } catch (e) {
              errorDialogWidget(msg: e.toString());
            }
          }
          final docRef = FirebaseStorageService.i.enterprise.doc().id;
          CircleModel circle = CircleModel(
            id: docRef,
            userId: rowMap[StringConfig.dashboard.userId].toString(),
            userName: rowMap[StringConfig.dashboard.fullName].toString(),
            userIsGuide: rowMap[StringConfig.reporting.userIsGuide]
                    .toString()
                    .toLowerCase() ==
                StringConfig.dashboard.trueText.toLowerCase(),
            isFlag: rowMap[StringConfig.reporting.isFlag]
                    .toString()
                    .toLowerCase() ==
                StringConfig.dashboard.trueText.toLowerCase(),
            flagName: rowMap[StringConfig.reporting.flagName].toString(),
            isMainPost: rowMap[StringConfig.reporting.isMainPost]
                    .toString()
                    .toLowerCase() ==
                StringConfig.dashboard.trueText.toLowerCase(),
            postTime: DateFormat(StringConfig.dashboard.dateYYYYMMDD)
                .parse(rowMap[StringConfig.reporting.postTime])
                .toIso8601String(),
            postView: rowMap[StringConfig.reporting.postViews],
            postTitle: rowMap[StringConfig.reporting.postTitle].toString(),
            postContent: rowMap[StringConfig.reporting.postContent].toString(),
            hashtag: hashTags,
            postReply:
                (jsonDecode(rowMap[StringConfig.reporting.postReplies]) as List)
                    .map((e) => e.toString())
                    .toList(),
          );
          await CircleRepository.i
              .addCircle(circleModel: circle, customId: docRef);
        }
      }
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    }
  }

  exportCircle() async {
    try {
      String currentDate =
          DateFormat(StringConfig.dashboard.dateYYYYMMDD).format(DateTime(0));
      List<List<String>> rows = [];

      rows = [
        ...searchedCircle.map((model) {
          return [
            model.userId ?? "",
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
            jsonEncode(model.postReply ?? []),
            jsonEncode(model.hashtag?.map((p) => p.toJson()).toList() ?? []),
          ];
        }),
      ];

      rows.sort((a, b) => DateFormat(StringConfig.dashboard.dateYYYYMMDD)
          .parse(b[4].isNotEmpty ? b[4] : currentDate)
          .compareTo(DateFormat(StringConfig.dashboard.dateYYYYMMDD)
              .parse(a[4].isNotEmpty ? a[4] : currentDate)));
      rows.insert(
        0,
        [
          StringConfig.dashboard.userId,
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
        name: StringConfig.circle.circleInformation,
      );
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }
}
