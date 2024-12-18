import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/dashboard/widgets/user_iam_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/controller/mqs_dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/custom_range_dialog.dart';

class OBSummaryScreen extends StatelessWidget {
  OBSummaryScreen({super.key});

  final DashboardController _dashboardController = Get.find();
  final MqsDashboardController _mqsDashboardController = Get.find();
  final ReportingController reportingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.width > SizeConfig.size600
            ? SizeConfig.size50
            : SizeConfig.size15),
        child: Obx(
          () => userIAMWidget(
            dashboardController: _dashboardController,
            context: context,
            mqsDashboardController: _mqsDashboardController,
            filterWidget: Row(
              children: [
                PopupMenuButton(
                  icon: Container(
                    height: SizeConfig.size46,
                    decoration:
                        FontTextStyleConfig.topOptionDecoration.copyWith(
                      borderRadius: BorderRadius.circular(SizeConfig.size12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeConfig.size15),
                    child: Image.asset(
                      ImageConfig.filterNew,
                      width: SizeConfig.size22,
                    ),
                  ),
                  onOpened: () {
                    _dashboardController.searchController.clear();
                  },
                  onSelected: (value) {
                    if (value == StringConfig.reporting.customRange) {
                      reportingController.startDateController.clear();
                      reportingController.endDateController.clear();
                      customRangeDialog(
                        context: context,
                        reportingController: reportingController,
                        type: StringConfig.reporting.onboardingSummary,
                        isDetailView: true,
                      );
                    } else {
                      reportingController.detailFilter.value = value;
                      reportingController.filterOnboarding(
                          filterType: value, isDetailView: true);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      for (int i = 0;
                          i < reportingController.filterOpts.length;
                          i++)
                        PopupMenuItem(
                          value: reportingController.filterOpts[i],
                          child: Text(
                            reportingController.filterOpts[i],
                            style: FontTextStyleConfig.fieldTextStyle,
                          ),
                        ),
                    ];
                  },
                ),
                if (reportingController.detailFilter.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      reportingController.startDateController.clear();
                      reportingController.endDateController.clear();
                      reportingController.detailFilter.value = '';
                      reportingController.filterOnboarding(
                          filterType: '', isDetailView: true);
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: ColorConfig.primaryColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
