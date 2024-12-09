import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_pathway_model.dart';
import 'package:mqs_admin_portal_web/views/pathway/repository/pathway_repository.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';
import 'package:mqs_admin_portal_web/widgets/loader_widget.dart';

class PathwayController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxBool isAdd = false.obs, isEdit = false.obs, showModules = false.obs;
  RxList<MQSMyQPathwayModel> searchedPathway = <MQSMyQPathwayModel>[].obs,
      pathway = <MQSMyQPathwayModel>[].obs;
  RxInt pageLimit = 10.obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  int get totalCirclePage => (searchedPathway.length / pageLimit.value).ceil();
  RxInt viewIndex = (-1).obs;
  MQSMyQPathwayModel get pathwayDetail => searchedPathway[viewIndex.value];
  List<MqsModule> get modules =>
      pathwayDetail.mqsPathwayDetail?.mqsModules ?? [];
  StreamSubscription<List>? pathwayStream;
  final GlobalKey<FormState> pathwayFormKey = GlobalKey<FormState>();
  RxList<int> moduleIndexes = <int>[].obs;

  @override
  onInit() {
    getPathway();
    super.onInit();
  }

  @override
  void onClose() async {
    await pathwayStream?.cancel();
    super.onClose();
  }

  getPathway() async {
    try {
      List<MQSMyQPathwayModel> pathwayList =
          await PathwayRepository.i.getPathways();
      searchedPathway.value = pathwayList;
      pathway.value = pathwayList;
      pathwayStream = PathwayRepository.i.getPathwayStream().listen((list) {
        searchedPathway.value = list;
        pathway.value = list;
        viewIndex.value = -1;
      });
      // Set filter fields of pathway in filter sheet
      // if (Get.isRegistered<DashboardController>()) {
      //   Get.find<DashboardController>().setFilterFields();
      // }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  getMaxOffset() {
    int rem = searchedPathway.length % pageLimit.value;
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

  clearAllFields() {
    showModules.value = false;
  }

  addPathway() async {
    try {
      if (pathwayFormKey.currentState?.validate() ?? false) {}
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  deletePathway({required String docId}) async {
    try {
      showLoader();
      viewIndex.value = 0;
      isAdd.value = false;
      isEdit.value = false;
      hideLoader();
    } catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  searchPathway() {
    try {
      reset();
      String query = searchController.text.trim().toLowerCase();
      if (query.isEmpty) {
        searchedPathway.value = pathway;
      } else {
        searchedPathway.value = pathway
            .where((e) =>
                e.id.toLowerCase().contains(query) ||
                e.mqsPathwayTitle.toLowerCase().contains(query) ||
                e.mqsPathwaySubtitle.toLowerCase().contains(query) ||
                e.mqsPathwayType.toLowerCase().contains(query) ||
                e.mqsAboutPathway.toLowerCase().contains(query) ||
                e.mqsLearningObj.toLowerCase().contains(query) ||
                e.mqsPathwayCoachInstructions.toLowerCase().contains(query))
            .toList();
      }
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }

  importPathway() async {
    try {} catch (e) {
      hideLoader();
      errorDialogWidget(msg: e.toString());
    }
  }

  exportPathway() async {
    try {} catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {}
  }
}
