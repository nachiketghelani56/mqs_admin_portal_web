import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/models/mqs_my_q_user_subscription_receipt_model.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

class UserSubscriptionReceiptController extends GetxController {
  final DashboardController _dashboardController =
      Get.put(DashboardController());
  RxInt offset = 0.obs, currentPage = 1.obs;
  RxInt viewIndex = (-1).obs;
  MQSMyQUserSubscriptionReceiptModel get userSubscriptionReceiptDetail =>
      _dashboardController.userSubscriptionReceipts[viewIndex.value];

  RxInt pageLimit = 10.obs;
  int get totalCirclePage =>
      (_dashboardController.userSubscriptionReceipts.length / pageLimit.value)
          .ceil();

  getMaxOffset() {
    int rem =
        _dashboardController.userSubscriptionReceipts.length % pageLimit.value;
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
}
