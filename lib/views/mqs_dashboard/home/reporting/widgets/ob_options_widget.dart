import 'package:mqs_admin_portal_web/views/dashboard/controller/dashboard_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_list.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';

Iterable<Widget> obOptionsWidget(
    {required ReportingController reportingController,
    required DashboardController dashboardController}) {
  return reportingController.circleChartOpts
      .map(
        (key, value) => MapEntry(
          key,
          Obx(
            () => TextButton.icon(
              onPressed: () {
                reportingController.detailFilter.value = '';
                reportingController.filterOnboarding(
                    type: key, filterType: reportingController.obFilter.value);
                dashboardController.searchController.clear();
                reportingController.reportType.value = key;
              },
              label: Text(
                '$key (${value.entries.first.value.value} ${StringConfig.reporting.users})',
                style: FontTextStyleConfig.dateTextStyle
                    .copyWith(color: ColorConfig.cardTitleColor),
              ),
              icon: Container(
                height: SizeConfig.size4,
                width: SizeConfig.size14,
                decoration: BoxDecoration(
                  color: value.entries.first.key,
                  borderRadius: BorderRadius.circular(SizeConfig.size11),
                ),
              ),
            ),
          ),
        ),
      )
      .values
      .toList()
      .separator(SizeConfig.size24.height);
}
