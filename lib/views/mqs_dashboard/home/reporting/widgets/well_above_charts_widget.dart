import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/controller/reporting_controller.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/well_above_drivers_widget.dart';
import 'package:mqs_admin_portal_web/views/mqs_dashboard/home/reporting/widgets/well_above_indictaors_widget.dart';

Widget wellAboveChartsWidget(
    {required ReportingController reportingController}) {
  return Row(
    children: [
      Expanded(
        flex: SizeConfig.size5.toInt(),
        child: Container(
          height: SizeConfig.size498,
          padding: const EdgeInsets.all(SizeConfig.size24),
          decoration: FontTextStyleConfig.cardDecoration,
          child: wellAboveIndicatorsWidget(
              reportingController: reportingController),
        ),
      ),
      SizeConfig.size34.width,
      Expanded(
        flex: SizeConfig.size4.toInt(),
        child: Container(
          height: SizeConfig.size498,
          padding: const EdgeInsets.all(SizeConfig.size24),
          decoration: FontTextStyleConfig.cardDecoration,
          child:
              wellAboveDriversWidget(reportingController: reportingController),
        ),
      ),
    ],
  );
}
