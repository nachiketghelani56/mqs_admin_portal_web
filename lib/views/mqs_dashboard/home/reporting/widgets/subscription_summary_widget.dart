import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_widget.dart';
import 'package:mqs_admin_portal_web/routes/app_routes.dart';
import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/custom_range_dialog.dart';
import 'package:mqs_admin_portal_web/widgets/error_dialog_widget.dart';

Widget subscriptionSummaryWidget(
    {required BuildContext context,
    required ReportingController reportingController,
    required DashboardController dashboardController}) {
  return Container(
    padding: const EdgeInsets.all(SizeConfig.size24),
    decoration: FontTextStyleConfig.cardDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Row(
            children: [
              Expanded(
                child: Text(
                  '${StringConfig.reporting.subscriptionSummary} ${reportingController.subscriptionFilter.value.isNotEmpty ? "(${reportingController.subscriptionFilter.value})" : ""}',
                  style: FontTextStyleConfig.cardTitleTextStyle,
                ),
              ),
              PopupMenuButton(
                icon: Container(
                  height: SizeConfig.size46,
                  decoration: FontTextStyleConfig.topOptionDecoration.copyWith(
                    borderRadius: BorderRadius.circular(SizeConfig.size12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeConfig.size15),
                  child: Image.asset(
                    ImageConfig.filterNew,
                    width: SizeConfig.size22,
                  ),
                ),
                onSelected: (value) {
                  if (value == StringConfig.reporting.customRange) {
                    reportingController.startDateController.clear();
                    reportingController.endDateController.clear();
                    customRangeDialog(
                      context: context,
                      reportingController: reportingController,
                      type: StringConfig.reporting.subscriptionSummary,
                    );
                  } else {
                    reportingController.subscriptionFilter.value = value;
                    reportingController.filterSubscription();
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
              if (reportingController.subscriptionFilter.isNotEmpty)
                IconButton(
                  onPressed: () {
                    reportingController.subscriptionFilter.value = '';
                    reportingController.getSubscriptionSummary();
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: ColorConfig.primaryColor,
                  ),
                ),
            ],
          ),
        ),
        SizeConfig.size24.height,
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {

                  reportingController.filterSubscription(
                      type: StringConfig.reporting.activeSubscription);
                  reportingController.subscriptionFilterType.value="";
                  dashboardController.searchController.clear();
                  Get.toNamed(AppRoutes.subscriptionSummaryDetailScreen);
                },
                child: Container(
                  height: SizeConfig.size202,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.size12),
                    color: ColorConfig.card1Color,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          '${reportingController.activeSubscriptions.value}',
                          style: FontTextStyleConfig.cardMainTextStyle,
                        ),
                      ),
                      SizeConfig.size12.height,
                      Text(
                        StringConfig.reporting.active,
                        textAlign: TextAlign.center,
                        style: FontTextStyleConfig.cardSubTextStyle.copyWith(
                            fontSize: context.width < SizeConfig.size600
                                ? FontSizeConfig.fontSize18
                                : null),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizeConfig.size34.width,
            Expanded(
              child: GestureDetector(
                onTap: () {
                  reportingController.filterSubscription(
                      type: StringConfig.reporting.purchasedSubscription);
                  reportingController.subscriptionFilterType.value="";
                  dashboardController.searchController.clear();
                  Get.toNamed(AppRoutes.subscriptionSummaryDetailScreen);
                },
                child: Container(
                  height: SizeConfig.size202,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.size12),
                    color: ColorConfig.card2Color,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          '${reportingController.purchasedSubscription.value}',
                          style: FontTextStyleConfig.cardMainTextStyle
                              .copyWith(color: ColorConfig.card2TextColor),
                        ),
                      ),
                      SizeConfig.size12.height,
                      Text(
                        StringConfig.reporting.purchased,
                        textAlign: TextAlign.center,
                        style: FontTextStyleConfig.cardSubTextStyle.copyWith(
                            fontSize: context.width < SizeConfig.size600
                                ? FontSizeConfig.fontSize18
                                : null),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizeConfig.size34.width,
            Expanded(
              child: Container(
                height: SizeConfig.size202,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.size12),
                  color: ColorConfig.card3Color,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '0',
                      style: FontTextStyleConfig.cardMainTextStyle
                          .copyWith(color: ColorConfig.card3TextColor),
                    ),
                    SizeConfig.size12.height,
                    Text(
                      StringConfig.reporting.cancelled,
                      textAlign: TextAlign.center,
                      style: FontTextStyleConfig.cardSubTextStyle.copyWith(
                          fontSize: context.width < SizeConfig.size600
                              ? FontSizeConfig.fontSize18
                              : null),
                    ),
                  ],
                ),
              ).tap(() {
                errorDialogWidget(
                    msg: StringConfig.reporting.pendingSubscription);
              }),
            ),
          ],
        ),
      ],
    ),
  );
}
