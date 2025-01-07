import 'dart:async';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/models/mqs_circle_flagged_post_model.dart';
import 'package:mqs_admin_portal_web/views/database/repository/database_repository.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class CircleFlaggedPostController extends GetxController {
  RxBool
      showHashTag = false.obs,showPostReply = false.obs;
  RxBool showCircleFlaggedPostDetail = false.obs;
  RxBool circleFlaggedPostLoader = false.obs;
  RxList<MqsCircleFlaggedPostModel> circleFlaggedPost =
      <MqsCircleFlaggedPostModel>[].obs;
  StreamSubscription<List>? circleFlaggedPostStream;
  RxInt viewIndex = (-1).obs;
  RxInt offset = 0.obs, currentPage = 1.obs;
  MqsCircleFlaggedPostModel get circleFlaggedPostDetail =>
      circleFlaggedPost[viewIndex.value];

  RxInt pageLimit = 10.obs;
  int get totalCircleFlaggedPost =>
      (circleFlaggedPost.length / pageLimit.value).ceil();

  @override
  onInit() {
    getCircleFlaggedPost();

    super.onInit();
  }

  getMaxOffset() {
    int rem = circleFlaggedPost.length % pageLimit.value;
    if (rem != 0 && currentPage.value == totalCircleFlaggedPost) {
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
      if (currentPage.value < totalCircleFlaggedPost) {
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

  getCircleFlaggedPost() async {
    try {
      circleFlaggedPostLoader.value = true;
      List<MqsCircleFlaggedPostModel> teamList =
          await DatabaseRepository.i.getCircleFlaggedPost();

      circleFlaggedPost.value = teamList;
      circleFlaggedPostStream =
          DatabaseRepository.i.getCircleFlaggedPostStream().listen((list) {
        circleFlaggedPost.value = list;
        viewIndex.value = -1;
      });
    } catch (e) {
      errorDialogWidget(msg: e.toString());
    } finally {
      circleFlaggedPostLoader.value = false;
    }
  }
}
