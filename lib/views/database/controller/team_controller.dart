import 'dart:async';

import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/models/mqs_team_model.dart';
import 'package:mqs_admin_portal_web/views/database/repository/database_repository.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class TeamController extends GetxController {
  RxBool showMqsTeamMemberDetail = false.obs;
  RxBool teamLoader = false.obs;
  RxList<MqsTeamModel> team = <MqsTeamModel>[].obs;
  StreamSubscription<List>? teamStream;
  RxInt viewIndex = (-1).obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  MqsTeamModel get teamDetail => team[viewIndex.value];

  RxInt pageLimit = 10.obs;
  int get totalTeamPage => (team.length / pageLimit.value).ceil();

  @override
  onInit() {
    getTeam();

    super.onInit();
  }

  getMaxOffset() {
    int rem = team.length % pageLimit.value;
    if (rem != 0 && currentPage.value == totalTeamPage) {
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
      if (currentPage.value < totalTeamPage) {
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

  getTeam() async {
    try {
      teamLoader.value = true;
      List<MqsTeamModel> teamList = await DatabaseRepository.i.getTeams();

      team.value = teamList;
      teamStream = DatabaseRepository.i.getTeamStream().listen((list) {
        team.value = list;
        viewIndex.value = -1;
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {
      teamLoader.value = false;
    }
  }
}
